---- EXAMPLE GRID OF RECTANGLES
require("eyesy")                    -- include the eyesy library
modeTitle = "EXAMPLE GRID OF RECTANGLES"    -- name the mode
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
    
    ----------------------- Draw a 10 x 10 Grid of Rectangles
    of.setColor( fg )
    
    -- we will use a 'for' loop to create the grid, where we loop the same thing over with a counter
    spaceW = w / 10                             -- we want the space between each point horizontally
    spaceH = h / 10                             -- space between for vertical placement
    
    -- the grid draws from the top left so to center the grid as the margin goes up we add by half of margin
    margin = (knob1 * 0.95) + 0.05              -- set the amount of space between the rectangles, min of 0.05, max 1
    marginW = spaceW*margin                     -- get margin for width
    marginH = spaceH*margin                     -- get margin for height
    centerW = (spaceW - marginW) / 2            -- get the remainder to determine the space then divide by 2, for width
    centerH = (spaceH - marginH) / 2            -- same for height
    
    of.pushMatrix()                             -- before we move the matrix save it
    of.translate( centerW, centerH )            -- center the grid related to the margin
    
    for i = 0, 9 do                             -- the variable i starts at 0, and goes to 9, 10 loops
        xPos = i * spaceW                       -- the i loop will be our x position each loop will then do the y position loop
        
        for j = 0, 9 do                         -- the j loop will be the y positions so we draw the rectangles going down
            yPos = j * spaceH                   -- get the y Position
            
            of.drawRectangle( xPos, yPos, marginW, marginH ) -- x,y position, width, height in pixels
        end
    end
    
    of.popMatrix()                              -- recall original matrix before begining of loop
end -- end of the draw() loop
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