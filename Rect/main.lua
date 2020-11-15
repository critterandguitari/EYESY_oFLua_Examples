---- EXAMPLE RECTANGLES
require("eyesy")                    -- include the eyesy library
modeTitle = "EXAMPLE RECTANGLES"    -- name the mode
print(modeTitle)                    -- print the mode title

---------------------------------------------------------------------------
-- helpful global variables 
w = of.getWidth()           -- width of screen, this function returns the width of the screen in pixels
h = of.getHeight()          -- height of screen, same as above but height
w2 = w / 2                  -- width half 
h2 = h / 2                  -- height half
w4 = w / 4                  -- width quarter
h4 = h / 4                  -- height quarter


---------------------------------------------------------------------------
-- the setup function runs once before the update and draw loops
function setup() 
    ----------------------- define color classes for background color and foreground color
    bg = of.Color()
    fg = of.Color()
    
    -- so we know that the setup was succesful
    print("done setup") 
end

---------------------------------------------------------------------------
-- update function runs on loop
function update()
   
end

-----------------------------------------------------------------------------------------------------
-- the main draw function also runs on loop
function draw()
    ----------------------- Color stuff
    colorPickHsb( knob4, fg )                   -- color for background, see above for ofColor class
    colorPickHsb( knob5, bg )                   -- color for drawings
    of.setBackgroundColor( bg )                 -- set the bg color 
    
    ----------------------- Draw a Rectangle
    of.pushMatrix()                             -- before we change the matrix, we save it, so we can 'pop' it later
    
    xPosition = knob1 * w                       -- x position is set by knob1(0.0-1.0) * the width = (0.0-MaxWidth)
    yPosition = knob2 * h                       -- y position is set by knob2 times max height
    
    rectSize = ( knob3 * (h-10) ) + 10          -- knob3 sets the size relative to max height, minimum of 10px
    
    of.translate( xPosition, yPosition )        -- put the two knobs in the x and y
    
    -- of.drawRectangle draws the rectangle from the top left point. so to center we can take its size and half it
    center = rectSize / 2                       -- divide the size by two to calculate the center point
    of.translate( -center, -center )            -- we use negative here to center, so the matrtix is moving left and up
    
    of.setColor( fg )                           -- use the fg color defined above to set the color
    of.drawRectangle( 0, 0, rectSize, rectSize )-- x y start, and then width and height. we use 0 here because of the translates
    
    of.popMatrix()                              -- recall last saved matrix, so begining of loop is same
  
end
---------------------------------------------------------------------------------------------------


------------------------------------ Color Function
-- this is how the knobs pick color
function colorPickHsb( knob, name )
    -- middle of the knob will be bright RBG, far right white, far left black
    
    k6 = (knob * 5) + 1                     -- split knob into 8ths
    hue = (k6 * 255) % 255 
    kLow = math.min( knob, 0.49 ) * 2       -- the lower half of knob is 0 - 1
    kLowPow = math.pow( kLow, 2 )
    kH = math.max( knob, 0.5 ) - 0.5    
    kHigh = 1 - (kH*2)                      -- the upper half is 1 - 0
    kHighPow = math.pow( kHigh, 0.5 )
    
    bright = kLow * 255                     -- brightness is 0 - 1
    sat = kHighPow * 255                    -- saturation is 1 - 0
    
    name:setHsb( hue, sat, bright )         -- set the ofColor, defined above
end

------------------------------------ the exit function ends the update and draw loops
function exit()
    -- so we know the script is done
    print("script finished")
end