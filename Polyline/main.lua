---- Polyline Example
require("eyesy")                    -- include the eyesy library
modeTitle = "Example - Polyline"    -- name the mode
print(modeTitle)                    -- print the mode title

---------------------------------------------------------------------------
-- helpful global variables 
w = of.getWidth()           -- global width  
h = of.getHeight()          -- global height of screen
w2 = w / 2                  -- width half 
h2 = h / 2                  -- height half
w4 = w / 4                  -- width quarter
h4 = h / 4                  -- height quarter
w8 = w / 8                  -- width 8th
h8 = h / 8                  -- height 8th
c = glm.vec3( w2, h2, 0 )   -- center in glm vector



---------------------------------------------------------------------------
-- the setup function runs once before the update and draw loops
function setup() 
    of.enableBlendMode(of.BLENDMODE_ALPHA)
    --------------------- define light
    myLight = of.Light()                            -- define a light class
    myLight:setPointLight( )                        -- we'll use a point light for this example
	myLight:setAmbientColor( of.FloatColor( 1, 1, 1 ) ) -- and make the ambient color white
    myLight:setPosition( c + glm.vec3(0,0,h2) )     -- and set the position in the center with z closer
    
    
    ---------------------- draw circles using polyline
    myLine = of.Polyline()                          -- define a polyline class
    circleW = h8
    for i = 0, 10 do                                -- start at 0 and count up to 19, (20 times)
        iter = i / 10                               -- ten points to a cycle
        xPos = math.sin( iter * 6.28 ) * circleW    -- sine function
        yPos = math.cos( iter * 6.28 ) * circleW    -- cosine function

        myLine:addVertex( glm.vec3( xPos, yPos, 0) )        -- this makes a circle
    end 
    
    
    myLineCurve = of.Polyline()
    
    circleW = circleW + (h8/2)
    for i = 0, 12 do                                -- start at 0 and count up to 19, (20 times)
        iter = i / 10
        xPos = math.sin( iter * 6.28 ) * circleW
        yPos = math.cos( iter * 6.28 ) * circleW

        myLineCurve:curveTo( glm.vec3( xPos, yPos, 0) )
    end 
    myLineCurve:close()
    
    ---------------------- draw a random scribble, in 3D
    myLine2 = of.Polyline()
    for i = 0, 25 do
        x = math.random( -h8, h8 )
        y = math.random( -h8, h8 )
        z = math.random( -h8, h8 )
        myLine2:addVertex( glm.vec3( x, y, z) )
    end
    myLine2:setClosed(true)
    
    ---------------------- define another polyline class, this for the oscilliscope
    myLine3 = of.Polyline()                         -- polyline named myLine3
    
    ---------------------- define another class for random points
    myLine4 = of.Polyline()                 -- polyline named myLine4
    
    -- instead of defining the vertices we will store the vec3 points to a table
    
    line4Tab = {}                           -- define a Lua table like this, named line4Tab
    
    -- Lua tables index from 1, so the for loop will be 1 - 25, 25 points total.
    for i = 1, 25 do
        x = math.random( -h8, h8 )
        y = math.random( -h8, h8 )
        z = math.random( -h8, h8 )
        line4Tab[i] = glm.vec3( x, y, z)
    end

    -- so we know that the setup was succesful
    print("done setup") 
end
---------------------------------------------------------------------------
-- update function runs on loop
function update()
end

---------------------------------------------------------------------------
-- the main draw function also runs on loop
function draw()
    of.setBackgroundColor( 255 )        -- set background color to white
    
    --------------------- draw the grid
    of.setLineWidth( 1 )                        -- set the line width to 1 pixel
    of.setColor( 0 )                            -- set color black
    of.drawLine( 0, h2, w, h2 )                 -- draw a horizontal line at the center (h2)
    of.drawLine( w2, 0, w2, h )                 -- draw a vertical at the center (w2)
    
    --------------------- draw the title
    of.drawBitmapString( "POLYLINE EXAMPLE", c + glm.vec3( 5,-5,0 ) )
    
    ------------------ see the vertices defined above in set up
    of.pushMatrix()                             -- store the matrix
    of.translate( w4, h4)                       -- translate to the top left, center
    of.setLineWidth( 10 )                       -- set line width to 10px
    of.setColor( 123, 200, 222, 200)            -- set color to a light blue
    myLine:draw()                               -- draw myLine
    of.setColor( 223, 200, 222, 200)            -- change color to a pink
    
    myLineCurve:draw()                          -- draw myLineCurve 
    
    ----------------------- draw random vertices in 3D Space
    of.popMatrix()                              -- recall stored matrix
    of.pushMatrix()                             -- store the matrix
    
    -- draw the random points again with the same code above, if audio average is over 0.3
    if( avG() > 0.1 ) then
        myLine2:clear()
        for i = 0, 25 do
            x = math.random( -h8, h8 )
            y = math.random( -h8, h8 )
            z = math.random( -h8, h8 )
            myLine2:addVertex( glm.vec3( x, y, z) )
        end   
    end
    
    of.translate( w2+w4, h4 )                   -- move to top right, center
    of.setLineWidth(2)                          -- set line width to 2 pixels
    of.setColor( 223, 0, 100 )                  -- set color to a dark pink
    of.rotateDeg( knob2*360, 1, 1, 1 )          -- rotate on all 3 axis with knob2
    myLine2:draw()                              -- draw myLine2
    
    ----------------------- draw polyline circle that respsonds to sound
    -- draw the polyline with vertices
    lineChunk = w2 / 98
    
    -- curve needs 1 point back (-1) and one point over target drawing 
    for i = -1, 99 do
        audio = inL[ (i%100) + 1 ]              -- the audio buffer(-1 - 1), the table is 1-100
        x = lineChunk * i                       -- the line chunk times the for loop count
        y = audio * h2                          -- scale audio to h2
        myLine3:curveTo( glm.vec3( x, y, 0 ) )  -- draw a simple oscilloscope but use curve
    end                

    of.popMatrix()                              -- recall stored matrix
    of.pushMatrix()                             -- store the matrix
    of.translate( w4, h2+h4 )                   -- posiiton bottom left, center
    of.rotateDeg( knob3*360, 0,1,0)             -- knob3 rotates on the y axis
    of.translate( -w4, 0 )                      -- draw the line from far left
    of.setLineWidth( 6 )                       -- set lineWidth to 10 px
    myLine3:draw()                              -- draw myLine3 at new matrix
    myLine3:clear()                             -- clear the points, draw new each draw loop

    ---------------------------- draw random 3D points with curveTo()
    of.popMatrix()                              -- recall stored matrix
    of.pushMatrix()                             -- store the matrix
    of.translate( w2+w4, h2+h4 )                -- draw to bottom right
    of.setLineWidth( 2 )                        -- set lineWidth to 2 px
    of.rotateDeg( knob4*360, 1,1,1)             -- knob4 rotates on the xyz axis

    
    if( avG() > 0.1 ) then                      -- if audio average over 0.1 then...
        
        for i = 1, 25 do                        -- for 1 - 25 redfine the 3d points
            x = math.random( -h8, h8 )          -- x range -h8 to h8
            y = math.random( -h8, h8 )
            z = math.random( -h8, h8 )
            line4Tab[i] = glm.vec3( x, y, z)    -- fill the global table line4Tab
        end   
    end
    
    for i = 1, 25 do                            -- read from the table to define the points
        audio = inL[i] * h4                     -- get individual audio points from buffer
        aVec = glm.vec3( 0, audio, 0)           -- define a vec3 to modulate the points
        ogPoint = line4Tab[i]                   -- get the point defined above
        myLine4:curveTo( ogPoint + aVec )       -- add the og point to the modulating one
    end
    myLine4:draw()                              -- draw the line
    myLine4:clear()                             -- clear the data form myLine4
    

end -- end of draw function

---------------------------------------------------------------------------
------ function for audio average, takes the whole 100 pt audio buffer and averages.
function avG()  
    a = 0
    for i = 1, 100 do
        aud = math.abs( inL[i])
        a = a + aud
    end
    x = a / 100
    if( x <= 0.001 ) then
        x = 0
    else
        x = x
    end
    return  x
end  
-- the exit function ends the update and draw loops
function exit()
    -- so we know the script is done
    print("script finished")
end