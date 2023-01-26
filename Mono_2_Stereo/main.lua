-- S - SoundSheet
require("eyesy")                        -- include the eyesy library
modeTitle = "Mono 2 Stereo Visual"      -- name the mode
print(modeTitle)                        -- print the mode title in the print window
modeExplain = "wow idk"                 -- explain mode

---------------------------------------------------------------------------
-- variables 
w = of.getWidth()                   -- width of screen, this function returns the width of the screen in pixels
h = of.getHeight()                  -- height of screen, same as above but height

---------------------------------------------------------------------------
-- the setup function runs once before the update and draw loops
function setup() 
    bg = of.Color()
    fg = of.Color()
    

end

---------------------------------------------------------------------------
-- update function part of main loop
function update()
	

end
---------------------------------------------------------------------------
-- the draw loop
function draw()
    
    -- KNOB STUFF
    colorPickHSB( knob4, fg )                   -- color for background, see above for ofColor class
    colorPickHSB( knob5, bg )                   -- color for drawings
    of.setBackgroundColor( bg )
    
    of.setColor(fg)
    of.pushMatrix()
        bar(w/12, h/16, w/3, (h/8)*7, knob1)
        of.translate(w/2,0)
        bar(w/12, h/16, w/3, (h/8)*7, knob2)
    of.popMatrix()
    
end

---------------------------------------------------------------------------
-- draw bar
function bar(x,y,w,h, fill) -- fill 0-1 float
    vY = ((1-fill)*h) + y
    vHei = fill * h
    of.drawRectangle(x, vY, w, math.max(vHei,1) )
end
---------------------------------------------------------------------------
--color picker
function colorPickHSB( knob, name )
    -- middle of the knob will be bright RBG, far right white, far left black
    
    k6 = (knob * 5) + 1              -- split knob into 8ths
    hue = (k6 * 255) % 255 
    kLow = math.min( knob, 0.49 ) * 2    -- the lower half of knob is 0 - 1
    kLowPow = math.pow( kLow, 2 )
    kH = math.max( knob, 0.5 ) - 0.5    
    kHigh = 1 - (kH*2)                      -- the upper half is 1 - 0
    kHighPow = math.pow( kHigh, 0.5 )
    
    bright = kLow * 255                     -- brightness is 0 - 1
    sat = kHighPow * 255                       -- saturation is 1 - 0
    
    name:setHsb( hue, sat, bright )      -- set the ofColor, defined above
end

------------------------------------ the exit function ends the update and draw loops
function exit()
    -- so we know the script is done
    theLight:disable()
    
    theCam:endCamera()
    of.disableDepthTest()
    
    print("script finished")
end