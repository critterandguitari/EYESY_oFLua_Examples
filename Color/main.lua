---- Color Example
require("eyesy")                    -- include the eyesy library
modeTitle = "Example - Color"    -- name the mode
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
c = glm.vec3( w2, h2, 0 )   -- center in glm vector



---------------------------------------------------------------------------
-- the setup function runs once before the update and draw loops
function setup() 
    of.enableBlendMode(of.BLENDMODE_ALPHA)          -- turn blend mode for transparency blending
    --------------------- define light
    myLight = of.Light()                            -- define a light class
    myLight:setPointLight( )                        -- we'll use a point light for this example
	myLight:setAmbientColor( of.FloatColor( 1, 1, 1 ) ) -- and make the ambient color white
    myLight:setPosition( c + glm.vec3(0,0,h2) )     -- and set the position in the center with z closer
    
    ----------------------------------- define color classes
    myRgbColor = of.Color()                 -- define the class for Rgb
    myHsbColor = of.Color()                 -- and define the class for Hsb
    
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
    of.drawBitmapString( "COLOR EXAMPLE", c + glm.vec3( 5,-5,0 ) )
    
    -------------------- first step is show how RGB Color works
    of.pushMatrix()                             -- store the matrix positon to recall
    of.translate( w4, h4 )                      -- move to top left, center
    red = math.floor( knob1 * 255 )             -- knob1 red 0 - 255, rounded down to Int
    green = math.floor( knob2 * 255 )           -- knob2 green
    blue = math.floor( knob3 * 255 )            -- knob3 blue
    transp = math.floor( knob4 * 255 )          -- knob4 transparency

    ---------- print to screen
    of.drawBitmapString( "DEFINE COLOR WITH RGB", glm.vec3(-h8, -h6, 0) )
    of.drawBitmapString( "RED = " .. red, glm.vec3(-w6, -40, 0) )
    of.drawBitmapString( "GREEN = " .. green, glm.vec3(-w6, 0, 0) )
    of.drawBitmapString( "BLUE = " .. blue, glm.vec3(-w6, 40, 0) )
    of.drawBitmapString( "TRANSPARENCY = " .. transp, glm.vec3(-w6, 120, 0) )

    myRgbColor.r = red 
    myRgbColor.g = green
    myRgbColor.b = blue
    myRgbColor.a = transp
    of.setColor( myRgbColor )     -- set the color from the rgb variables
    
    of.enableLighting()                         -- enable lighting globally
    of.enableDepthTest()                        -- enable 3D rendering globally
    myLight:enable()                            -- begin rendering for myLight
    
    of.drawBox( glm.vec3(0,0,-h8), h4 )     -- draw a plane center with h4 height, width
    
    ------------------------ draw HSB to top left
    of.popMatrix()                              -- recall last matrix
    of.pushMatrix()                             -- save again
    
    of.translate( w2+w4, h4 )                   -- move to top left, center
    hue = math.floor( knob1 * 255 )             -- knob1 hue 0 - 255, rounded down to Int
    sat = math.floor( knob2 * 255 )             -- knob2 saturation
    bright = math.floor( knob3 * 255 )          -- knob3 brightness
    transp = math.floor( knob4 * 255 )          -- knob4 transparency
    of.setColor( 0 )                            -- set color to black for text
    
    ---------- print to screen
    of.drawBitmapString( "DEFINE COLOR WITH HSB", glm.vec3(-h8, -h6, 0) )
    of.drawBitmapString( "HUE = " .. hue, glm.vec3(-w6, -40, 0) )
    of.drawBitmapString( "SATURATION = " .. sat, glm.vec3(-w6, 0, 0) )
    of.drawBitmapString( "BRIGHTNESS = " .. bright, glm.vec3(-w6, 40, 0) )
    of.drawBitmapString( "TRANSPARENCY = " .. transp, glm.vec3(-w6, 120, 0) )


    myHsbColor:setHsb( hue, sat, bright, transp )  -- set hsb for myColor
    of.setColor( myHsbColor )                      -- use myColor to set the color
    of.drawBox( glm.vec3(0,0,-h8), h4 )         -- draw a plane center with h4 height, width
    
    ------------------------ draw inverse of rgb and hsb to bottom left
    of.popMatrix()                              -- recall last matrix
    of.pushMatrix()                             -- save again
    
    of.translate( w4, h2+h4 )                   -- bottom left
    --- inverse of rgb
    of.setColor( 0 )                            -- set color to black
    of.drawBitmapString( "INVERSE RGB", glm.vec3(-w4,-h6,0) ) -- draw text
    of.setColor( myRgbColor:getInverted() )     -- set color to the inverse of myRgb
    of.drawBox( glm.vec3(-h6,-h8,0), h8 )       -- draw a box
    --- inverse of hsb
    of.setColor( 0 )                            -- set color to black
    of.drawBitmapString( "INVERSE HSB", glm.vec3(w6,-h6,0) ) -- draw text
    of.setColor( myHsbColor:getInverted() )     -- set color to the inverse of myRgb
    of.drawBox( glm.vec3( h6,-h8,0), h8 )       -- draw a box
    --- lerp from og rgb to invere
    of.setColor( 0 )                            -- set color to black
    of.drawBitmapString( "LERP INVERSE HSB", glm.vec3(-w4,h6,0) ) -- draw text
    of.drawBitmapString( "WITH KNOB 5", glm.vec3(-w4,h6+15,0) ) -- draw text
    myHsbColor:lerp( myHsbColor:getInverted(), knob5 )
    of.setColor( myHsbColor )                   -- set color to the inverse of myRgb
    of.drawBox( glm.vec3( -h6,h8,0), h8 )       -- draw a box
    --- use a named color, see: https://openframeworks.cc/documentation/types/ofColor/
    --- for a list of color names
    of.setColor( 0 )                                -- set color to black
    of.drawBitmapString( 
        "Use Preset Color:", glm.vec3(w6,h6,0) )    -- draw text
     of.drawBitmapString( 
        "Olive", glm.vec3(w6,h6+15,0) )             -- draw text
    of.setColor( of.Color.olive )                   -- set color to preset olive
    of.drawBox( glm.vec3( h6,h8,0), h8 )            -- draw a box
    
    ------------------------ modulate given color
    of.popMatrix()                              -- recall last matrix
    of.pushMatrix()                             -- save again
    of.translate( w2+w8, h2+h8 )                -- move to center    
    
    of.setColor(0)                              -- set color to black
    of.drawBitmapString( "Modulate RGB", glm.vec3( 0, -20, 0) )
    wChunk = w4 / 25                            -- 25 boxes in w4 space
    boxW = wChunk * 0.98                        -- same chunk just smaller for even space
    for i = 0, 24 do                            -- 25 for loop 0-24 (25 times)
        x = wChunk * i                          -- xP position
        colMod = i * 1                          -- the color modulation
        myRgbColor.r = (myRgbColor.r + colMod) % 255 -- r channel %255 keeps the param 0-255
        myRgbColor.g = (myRgbColor.g + colMod) % 255 -- g channel
        myRgbColor.b = (myRgbColor.b + colMod) % 255 -- b channel
        of.setColor( myRgbColor)                -- set the color
        of.drawBox( glm.vec3( x, 0, 0 ), boxW ) -- draw the box
    end
    
    of.translate( 0, h8 )                   -- move to center    
    of.setColor(0)                          -- set color to black
    of.drawBitmapString( "Modulate HUE of HSB",
        glm.vec3( 0, -20, 0) ) -- draw string
    newColor = of.Color()
    newColor = myHsbColor
    for i = 0, 24 do                                    -- 25 loop
        x = wChunk * i                      
        colMod = i * 10
        newColor:setHue( myHsbColor:getHue() + i )    -- get the hsb hue and modulate
        of.setColor( newColor )                        -- set color
        of.drawBox( glm.vec3( x, 0, 0 ), boxW )         -- draw box
    end
    
    of.translate( 0, h8 )                   -- move to center    
    of.setColor(0)                          -- set color to black
    of.drawBitmapString( "Modulate Brightness of HSB", 
        glm.vec3( 0, -20, 0) ) -- draw string
    
    newColor2 = of.Color()
    newColor2 = myHsbColor
    for i = 0, 24 do                                    -- 25 loop
        x = wChunk * i                      
        colMod = i
        newColor2:setBrightness( 
            myHsbColor:getBrightness() - colMod )    -- get the hsb hue and modulate
        of.setColor( newColor2)                        -- set color
        of.drawBox( glm.vec3( x, 0, 0 ), boxW )         -- draw box
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