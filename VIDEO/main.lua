---- Video Example
require("eyesy")                    -- include the eyesy library
modeTitle = "Example - Video"       -- name the mode
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
    ---------------- get the path to this directory
    myDirect = of.Directory()                       -- define the Directory Class
    thePath = myDirect:getAbsolutePath()            -- get current path
    print("thePath", thePath )
    
    --------------------- video class
    myVid = of.VideoPlayer()                    -- define video player class
    
    myVid:load( thePath .. "/example_1_compressed.mp4" )
    myVid:play()                   
    
   
    of.enableBlendMode( of.BLENDMODE_ALPHA )
    --------------------- define light
    myLight = of.Light()                                  -- define a light class
    myLight:setPointLight( )                        -- we'll use a point light for this example
	myLight:setAmbientColor( of.FloatColor( 1, 1, 1 ) ) -- and make the ambient color white
    myLight:setPosition( c + glm.vec3(0,0,h2) )     -- and set the position in the center with z closer
    
  
    -- so we know that the setup was succesful
    print("done setup") 
end
---------------------------------------------------------------------------
-- update function runs on loop
function update()
                
    
    
    myVid:update()
    
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
    
    -------------------- enable modes for the scene
    of.enableLighting()                         -- enable lighting globally
    of.enableDepthTest()                        -- enable 3D rendering globally
    myLight:enable()                            -- begin rendering for myLight
    
    --------------------- draw the title
    of.drawBitmapString( "VIDEO EXAMPLE", c + glm.vec3( 5,-5,0 ) )
    
    --[[
    ------------------------ frame control
    frameAmt = myVid:getTotalNumFrames()        -- get the total number of frames
    selectF = (knob1 * frameAmt) + 1
    myVid:setFrame( math.floor(selectF) )
    --]]
    --------------------- draw video
    of.pushMatrix()                             -- save (0,0,0) matrix
    of.translate( w4, h4 )                      -- move to top left, center
    scaleKnob = (knob1*2) + 0.1                 -- define a scale knob
    scaleX = scaleKnob * w2                     -- scale width
    scaleY = scaleKnob * h2                     -- scale height
    of.rotateDeg( knob2*360, 0,1,0 )            -- rotate on Y axis
    of.translate( -scaleX/2, -scaleY/2 )        -- translate to center
    
    of.setColor( 255, 255, 255, 255 )           -- set color to white
    
    myVid:draw( 0, 0, scaleX, scaleY )          -- draw the video
    
    --------------------- bind to box
    of.popMatrix()                              -- recall matrix
    of.pushMatrix()                             -- save (0,0,0) matrix
    of.translate( w2+w4, h4 )                   -- top right, center
    
    of.rotateDeg( knob3*360, 0,1,0 )            -- rotate on y axis
    myVid:bind()                                -- bind the video texture to following shapes
    of.setColor(255,255,0)
    of.drawBox( h8 )                            -- draw the 3d box
    myVid:unbind()                              -- unbind
    
   
    
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
    myVid:closeMovie()                        -- free the memory space
    -- so we know the script is done
    print("script finished")
end