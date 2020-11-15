---- TEXTURE EXAMPLE
require("eyesy")                    -- include the eyesy library
modeTitle = "Example - Texture"     -- name the mode
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
    -- for this example we need to define a frame buffer object
    myFbo = of.Fbo()            -- 1st define an Fbo class
    myFbo:allocate( w2, h2)     -- then we need to 'allocate' space for the fbo, define the size
    --------- we also need a texture class which also calls for allocation
    myPix = of.Pixels()                         -- define pixels class
    myPix:allocate( w2, h2, of.PIXELS_RGBA )    -- allocate pixels first    
    myTex = of.Texture()                        -- define texture class
    myTex:allocate( myPix )                     -- allocate w and h and type of pixels
    ----------- make a pixels class for a custom gradient
    myPix2 = of.Pixels()                         -- define pixels class
    myPix2:allocate( 50, 50, of.PIXELS_RGB )    -- allocate pixels first
    myTex2 = of.Texture()
    myTex2:allocate( myPix2 )
    
    
    
   
   
    -- for loop fill the myGrad pixels
    for i = 0, myPix2:size() - 1 do
        myPix2:setColor( i, of.Color( 25, 25, 255, 1) )
    end
    
    
    
    myTex2:loadData( myPix2 )
    --------------------- define light
    myLight = of.Light()                -- define a light class
    myLight:setPointLight( )            -- we'll use a point light for this example
	myLight:setAmbientColor( of.FloatColor( 1, 1, 1 ) ) -- and make the ambient color white
    myLight:setPosition( c + glm.vec3(0,0,h2) ) -- and set the position in the center with z closer
    
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
    of.setLineWidth( 1 )                -- set the line width to 1 pixel
    of.setColor( 0 )                    -- set color black
    of.drawLine( 0, h2, w, h2 )         -- draw a horizontal line at the center (h2)
    of.drawLine( w2, 0, w2, h )         -- draw a vertical at the center (w2) 
    --------------------- draw the title
    of.drawBitmapString( "TEXTURES EXAMPLE", c + glm.vec3(5,-5,0) )
    -------------------------- draw same osc to a frame buffer
    myFbo:beginFbo()                        -- begin the fbo buffer, following will render off-screen               
    
    
    of.setLineWidth( 4 )                    -- set the line width to 4 pixels
    of.clear( 25,255,255,255 )             -- clear the buffer, white-opaque
   
    lineOsc( 0, h4, w2, h2, 99 )            -- make a simple oscilloscope, see function at bottom
    
    myTex:loadScreenData( 0, 0, w2, h2)    -- capture the entire scene to myTex
    
    myFbo:endFbo()                          -- end the fbo
    
    --------------------------- draw the texture top left
    of.enableLighting()             -- enable lighting globally
    of.enableDepthTest()            -- enable 3D rendering globally
    of.enableAlphaBlending()
    of.setColor( 255 )              -- make color bright white, so we can see the texture
    myLight:enable()                -- begin rendering for myLight
    myTex:draw( 0, 0, w2, h2 )      -- draw the texture to the screen
    of.setColor(0)                  -- set color to black
    -- draw text
    
    of.drawBitmapString( "The Texture", glm.vec3( 0,0,0 ) )
    -------------------------- draw a sphere
    
    of.pushMatrix()                 -- save current matrix
    of.translate( w2+w4, h4 )       -- center on the top right
    of.setColor( 255,155,0 )               -- set color to grey
    of.drawSphere( 0, 0, h4/2 )     -- draw sphere in center, radius of h4/2
    of.popMatrix()                  -- recall last matrix
    -------------------------- apply the texture to the sphere
    of.pushMatrix()                 -- save current matrix
    of.translate( w4, h2+h4 )       -- center on the bottom left
    of.rotateDeg( knob1*360, 1,1,1 )    -- rotate with knob1 on xyz
    myTex:bind()                    -- apply the texture to the following shapes
    of.drawSphere( 0, 0, h8 )     -- draw sphere in center, radius of h4/2, color still gray
    myTex:unbind()                  -- end the texture bind
    of.popMatrix()                  -- recall last matrix
    ---------------------------- capture the bottom right sphere and use as texture
    
    
    of.pushMatrix()                 -- save current matrix
    
    of.translate( w2+w4, h2+h4 )    -- move to center of bottom right
    of.rotateDeg( knob2*360, 1,1,1)
    myTex:bind()                    -- apply the texture to the following shapes
    of.drawBox( glm.vec3(0,0,0), h4 )     -- draw sphere in center, radius of h4/2, color still gray
    myTex:unbind()                  -- end the texture bind
    ---------------------------------------
    myLight:disable()               -- end rendering for myLight
    of.disableLighting()            -- disable lighting globally
    of.popMatrix()                  -- recall last matrix
end

---------------------------------------------------------------------------
-- oscillopscpe function using line segments
function lineOsc( x, y, width, height, segAmt )
    -- x, y are far left starting position
    -- width is how long the oscilloscope is
    -- height is the max vertical distance 
    -- segAmt is the amount of line segments
    xSeg = width / segAmt                           -- get the length of each line
    for i = 0, segAmt - 1 do                        -- for loop, seg amt minus 1
        audio1 = inL[ (i%100) + 1 ] * height        -- audio buffer for 1st xy
        audio2 = inL[ ((i+1)%100) + 1 ] * height    -- audio buffer for 2nd
        xPos1 = xSeg * i                            -- x position for 1st
        yPos1 = y + audio1                          -- y posiiton
        xPos2 = xPos1 + xSeg                        -- x
        yPos2 = y + audio2                          -- y
        of.drawLine( xPos1, yPos1, xPos2, yPos2 )   -- simple draw line 
    end
end
-- the exit function ends the update and draw loops
function exit()
    -- so we know the script is done
    print("script finished")
end