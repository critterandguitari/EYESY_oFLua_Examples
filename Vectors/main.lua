---- Vector Example
require("eyesy")                    -- include the eyesy library
modeTitle = "Example - Vectors"    -- name the mode
print(modeTitle)                    -- print the mode title

---------------------------------------------------------------------------
-- helpful global variables 
w = of.getWidth()           -- global width  
h = of.getHeight()          -- global height of screen
w2 = w / 2                  -- width half 
h2 = h / 2                  -- height half
w4 = w / 4                  -- width quarter
h4 = h / 4                  -- height quarter
w6 = w / 6                  -- width 6th
h6 = h / 6                  -- height 6th
w8 = w / 8                  -- width 8th
h8 = h / 8                  -- height 8th
h16 = h / 16                -- 16th height
h32 = h / 32                -- 32nd height

-- glm.vec3 is a vector with three components x,y,z which are the 3D position in our scene
c = glm.vec3( w2, h2, 0 )   -- center in glm vector3
tLeft = glm.vec3( 0,0,0 )   -- top left in glm vec3
text = glm.vec3(-15,0,0)    -- center the printed text for the points

-- vectors are helpful becasue we can make them a global variable as above we call the...
-- center point 'c'
-- vectors can also be used with math, example: c + tLeft adds c's xyz with tLefts'


---------------------------------------------------------------------------
-- the setup function runs once before the update and draw loops
function setup() 
    of.enableBlendMode(of.BLENDMODE_ALPHA)          -- turn blend mode for transparency blending
    --------------------- define light
    myLight = of.Light()                            -- define a light class
    myLight:setPointLight( )                        -- we'll use a point light for this example
	myLight:setAmbientColor( of.FloatColor( 1, 1, 1 ) ) -- and make the ambient color white
    myLight:setPosition( c + glm.vec3(0,0,h2) )     -- and set the position in the center with z closer
    
   
    
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
    of.drawBitmapString( "VECTOR EXAMPLE", c + glm.vec3( 5,-5,0 ) )
    
    -------------------- enable modes for the scene
    of.enableLighting()                         -- enable lighting globally
    of.enableDepthTest()                        -- enable 3D rendering globally
    myLight:enable()                            -- begin rendering for myLight
    
    -------------------- draw first vector as 3d box
    of.pushMatrix()                             -- save the current matrix (0,0,0)
    ------------ of.translate shifts the matrix, positive width moves to the right, pos height, down...
    --------- negative width to the left, and neg height is up.
    of.translate( glm.vec3( w4, h4, 0 ) )       -- move the matrix to top left, center
                                                -- w4 to the right, h4 down, no change z axis
    of.drawBitmapString( "point 1", text )      -- draw the text, with x axis offset
    of.setColor( of.Color.green )               -- set color to green
    of.noFill()                                 -- draw just the lines of box
    of.drawBox( h32 )                           -- draw the box, no 2nd argument places it 0,0,0
    
    -------------------------- move one point around the screen
    of.popMatrix()                              -- recall last matrix(0,0,0)
    of.pushMatrix()                             -- save again
    point2 = glm.vec3( w2, 0, 0 )               -- top right, top left corner
    point2mod = glm.vec3( 
        knob1*w2, knob2*h2, 0 )                 -- a vec3 to move point2, knob1=x, knob2=y
    
    of.translate( point2 + point2mod )
    of.setColor(0)                              -- set color to black
    of.drawBitmapString( "point 2", text )      -- draw the text, with x axis offset
    of.setColor( of.Color.red )                 -- set color to green
    of.drawBox( h32 )                           -- draw the box, no 2nd argument places it 0,0,0
    
   
    ---------------------------- draw a grid of boxes that can be rotated on knob3
    of.popMatrix()                              -- recall last matrix (0,0,0)
    of.pushMatrix()                             -- save again
    
    of.translate( 0, h2 )                       -- move to bottom left, top left
    offsetX = w2 / 10                           -- get the width space for the quadrant
    offsetY = h2 / 10                           -- get the height space 
    gridP = glm.vec3( offsetX/2, offsetY/2, 0 ) -- define a new point and...
    of.translate( gridP )                       -- translate again to center the grid
    
    for i = 0, 9 do                             -- the 10 columns
        x = i * offsetX                         -- get the x steps
        for j = 0, 9 do
            -- save the current matrix above, ***note we still have the(0,0,0)matrix saved, so two pops will bring us back to 0,0,0
            of.pushMatrix()                     
            y = j * offsetY                     -- get the y steps
            gridP.x = x                         -- change gridP by using the name.x 
            gridP.y = y                         -- change gridP.y
            of.translate( gridP )               -- translate to our position
            of.rotateDeg( knob3*360, 0, 1, 0)   -- rotate the box on its own y axis
            of.rotateDeg( knob4*360, 1, 0, 0)   -- rotate the box on its own x axis
            of.setColor(0)                      -- set color to black
            of.drawBitmapString( 
                (i*10)+j, text )                -- draw the text, with x axis offset
            of.setColor( of.Color.blue )        -- set color to blue
            of.drawBox( h32 )                   -- draw the box
            of.popMatrix()                      -- recall last matrix stored for this loop
        end
        
    end
    
    -------------------------------
    of.popMatrix()                              -- recall (0,0,0) matrix
    of.pushMatrix()                             -- save again
    
    of.translate( w2+w4, h2+h4 )                -- move to bottom right, center
    of.rotateDeg( knob5*360, 0,1,0 )            -- rotate the following on the y axis
    
    of.translate( -w8, -h8 )                -- move to bottom right, top left
    
    offsetX = w4 / 5                            -- get the width space for the quadrant
    offsetY = h4 / 5                            -- get the height space 
    gridP = glm.vec3( offsetX/2, offsetY/2, 0 ) -- define a new point and...
    of.translate( gridP )                       -- translate again to center the grid
      
    for i = 0, 4 do                             -- the 10 columns
        x = i * offsetX                         -- get the x steps
        for j = 0, 4 do
            of.pushMatrix()         
            num = ( i * 10 ) + j                -- calculate the number
            audio = inL[ num+1 ]                -- audio buffer 1-100
            aRange = audio * h2                 -- audio range is h2
            y = j * offsetY                     -- get the y steps
            
            gridP.x = x                         -- change gridP by using the name.x 
            gridP.y = y                         -- change gridP.y
            gridP.z = aRange                    -- change the z axis with the audio
            
            of.translate( gridP )               -- translate to our position
            of.rotateDeg( knob3*360, 0, 1, 0)   -- rotate the box on its own y axis
            of.rotateDeg( knob4*360, 1, 0, 0)   -- rotate the box on its own x axis
            of.setColor(0)                      -- set color to black
            of.drawBitmapString( 
                num, text )                -- draw the text, with x axis offset
            of.setColor( of.Color.cyan )        -- set color to blue
            of.drawBox( h32 )                   -- draw the box
            of.popMatrix()                      -- recall last matrix stored for this loop
        end
        
    end

    
        

    ------------------------ disable lighting and depth
    myLight:disable()                           -- end rendering for myLight
    of.disableLighting()                        -- disable lighting globally
    of.disableDepthTest()                       -- enable 3D rendering globally
    of.popMatrix()                              -- recall last matrix
end

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