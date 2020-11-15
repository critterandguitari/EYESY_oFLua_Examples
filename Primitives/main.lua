---- explain the example
require("eyesy")                    -- include the eyesy library
modeTitle = "Example - Primitives"    -- name the mode
print(modeTitle)                    -- print the mode title

---------------------------------------------------------------------------
-- helpful global variables 
w = of.getWidth()           -- global width  
h = of.getHeight()          -- global height of screen
w2 = w / 2                  -- width half 
h2 = h / 2                  -- height half
w4 = w / 4                 -- width quarter
h4 = h / 4                 -- height quarter
w8 = w / 8                  -- width 8th
h8 = h / 8                  -- height 8th
c = glm.vec3( w2, h2, 0 )   -- center in glm vector
s1c = glm.vec3( w4, h4, 0 )
s2c = glm.vec3( w4+w2, h4, 0)


---------------------------------------------------------------------------
-- the setup function runs once before the update and draw loops
function setup()                
    -------- define and set the light source
    myLight = of.Light()                -- define a light class
    myLight:setPointLight( )            -- we'll use a point light for this example
	myLight:setAmbientColor( of.FloatColor( 1, 1, 1 ) ) -- and make the ambient color white
    myLight:setPosition( c )            -- and set the position in the center
    
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
    of.setColor( 0 )                    -- set color black
    of.drawLine( 0, h2, w, h2 )         -- draw a horizontal line at the center (h2)
    of.drawLine( w2, 0, w2, h )         -- draw a vertical at the center (w2)    
    
    --------------------- draw the title
    of.drawBitmapString( "PRIMITIVES EXAMPLE", c + glm.vec3( 5,-5,0 ) )
    
    
    ---------------------- draw a cube
    ------- center the matrix on the top left quadrant    
    of.pushMatrix()                     -- save the current matrix(0,0)
    of.translate( -w4, -h4 )            -- move the matrix left a quarter and up a quarter
    of.setColor( 90 )                   -- set color to a dark gray
    of.drawBox( c, h4 )                 -- draw a 3D box width, height, and depth at h4
    of.popMatrix()                      -- recall last push matrix
    ---------------------- draw a sphere with lighting on, size responds to amplitude
    of.pushMatrix()                     -- save the current matrix(0,0)
    of.translate( w4, -h4 )             -- move the matrix right a quarter and up a quarter
    of.enableLighting()                 -- enable lighting (globally?)
    of.enableDepthTest()                -- enable 3D render
    ----- color is still dark gray
    myLight:enable()                    -- start the light
    minSize = (h8 * knob1) + 1
    audio = ( avG() * h4 ) + minSize
    of.drawSphere( c, audio )            -- draw the sphere at center with h4/2 radius
    ----------------------------
    of.popMatrix()                      -- recall last push matrix(0,0)
    of.pushMatrix()                     -- save the current matrix(0,0)
    of.translate( w4, h2+h4 )
    of.rotateDeg( knob3 * 360, 1,1,1 )  -- rotate the cylinder on all axis
    of.drawCylinder( glm.vec3(0,0,0), (knob2*h4/2)+1, h4 )  -- draw the cylinder
    
    -------------------------------- mix some primitives together
    of.popMatrix()                          -- recall last push matrix(0,0)
    of.pushMatrix()                         -- save the current matrix(0,0)
    of.translate( w2+w4, h2+h4 )            -- move to bottom right, center
    of.rotateDeg( knob4*360, 1,1,1 )
    
    audio = avG() * h4
    point = glm.vec3(0,0,0)                 -- make a top left vec3 point
    of.drawCone( point, h8, h8 )            -- draw cone, at vec3 point, radius, height
    
    circP = glm.vec3(0,-h8/2,0)             -- make a vec3 to move the shpere
    of.setColor( 150 )
    of.drawSphere( point+circP, h8/4)       -- draw the sphere
    
    boxP = glm.vec3( 0,h8/4,0)
    of.setColor( 120 )
    of.drawBox( point+boxP, h8)
    myLight:disable()                       -- end the light
    of.disableLighting()                    -- disable lighting globally
    of.disableDepthTest()                   -- disable 3D render globally
    
end
---------------------------------------------------------------------------

--------------------- function for audio average, takes the whole 100 pt audio buffer and averages.
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
------------------------- the exit function ends the update and draw loops
function exit()
    -- so we know the script is done
    print("script finished")
end