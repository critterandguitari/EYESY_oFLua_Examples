---- Text Example
require("eyesy")                    -- include the eyesy library
modeTitle = "Example - Text"       -- name the mode
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
   
    of.enableBlendMode(of.BLENDMODE_ALPHA)              -- enable alpha channel blending
    
    --------------------- define light
    myLight = of.Light()                                -- define a light class
    myLight:setPointLight( )                            -- we'll use a point light for this example
	myLight:setAmbientColor( of.FloatColor( 1, 1, 1 ) ) -- and make the ambient color white
    myLight:setPosition( c + glm.vec3(0,0,h2) )         -- and set the position in the center with z closer
    
    -------------------- define the font class
    myFont = of.TrueTypeFont()                          -- define font
    -- load arial font, at size 32px
    myFont:load(
        "arial.ttf", 32, true, true, true, 80, 200 )                        
    
    --------------------- fill a table of random words
    subject = { "Me", "You", "They", "Critter", "Guitari" }       -- 5 item table
    verb = { "go", "ran", "went", "jumped" }                    -- 4 item table
    noun = { "home", "the museum", "the walk", "stadium"}               -- 4 itme table
    string4 = "generate a sentence"

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
    of.drawBitmapString( "TEXT EXAMPLE", c + glm.vec3( 5,-5,0 ) )
    
    --------------------- draw a string
    of.pushMatrix()                             -- save 0,0,0 matrix
    of.translate( w4, h4 )                      -- move to top left, center
    of.setColor( 0 )                            -- set color to black
    string1 = "hello world!"                    -- define the string we want to draw
    bBox1 = of.Rectangle                        -- define a rectangle class
    bBox1 = myFont:getStringBoundingBox( 
        string1, 0, 0 )                         -- get the bounding box of what we will draw
    centerX = bBox1:getWidth() / 2              -- get Width / 2 so we can center
    centerY = bBox1:getHeight() / 2             -- get Height / 2
    of.translate( -centerX, -centerY )          -- translate again to center the text
    myFont:drawString( string1, 0, 0 )          -- draw the text
    of.noFill()                                 -- draw just the outline
    of.drawRectangle( bBox1 )                   -- draw the ofRectangle bBox1
    
    --------------------- move a string and resize
    of.popMatrix()                              -- recall the 0,0,0 matrix
    of.pushMatrix()                             -- save 0,0,0 matrix
    
    of.translate( w2, 0 )                       -- move to top right, center
    -- we will use of.translate to move position and of.scale to scale the text
    of.translate( knob1*w2, knob2*h2)           -- then move the text within the top right
    scaleKnobX = (knob3*2) + 0.1                -- knob3 controls width scale
    scaleKnobY = (knob4*2) + 0.1                -- knob4 controls height scale
    of.scale( scaleKnobX, scaleKnobY )          -- scale the matrix
    of.translate( -scaleKnobX/2, -scaleKnobY/2 )  -- recenter the matrix
    string2 = "another string"                  -- define a different string
    bBox2 = of.Rectangle                        -- define a rectangle class
    bBox2 = myFont:getStringBoundingBox( 
        string2, 0, 0 )     
    bCenter = bBox2:getCenter()                 -- get center of bounding box, ofRectangle
    of.translate( -bCenter.x, -bCenter.y, 0 )   -- translate again to center the text
    
    myFont:drawString( string2, 0, 0 )          -- draw string2
    of.drawRectangle( bBox2 )                   -- draw the ofRectangle bBox1
    
    ------------------------------ other cool things we can do with text
    of.popMatrix()                              -- recall the 0,0,0 matrix
    of.pushMatrix()                             -- save 0,0,0 matrix   
    
    of.translate( w4, h2+h4)                      -- move to bottom left
    string3 = "cool things"                     -- define a new string
    bBox2 = myFont:getStringBoundingBox( 
        string3, 0, 0 )  
    bCenter = bBox2:getCenter()                 -- get center of bounding box, ofRectangle
    spaceH = bBox1:getHeight()                  -- get the height of the box   
    of.rotateDeg( knob5*360, 0,1,0 )            -- rotate matrix knob5 on y axis
    of.translate( -bCenter.x, -bCenter.y, 0 )   -- translate again to center the text
    myFont:drawString( string3, 0, 0 )          -- draw the string
    myFont:setLetterSpacing( 0.5 )              -- set letter spacing tighter, 1 is default
    myFont:drawString( string3, 0, spaceH )     -- draw the string again one space below
    myFont:setLetterSpacing( 2 )                -- set letter spacing wider, double default
    myFont:drawString( string3, 0, spaceH*2 )   -- draw the string again 2 space below
    myFont:setLetterSpacing( 1 )                -- set letter spacing back to default
    
    ------------------------------ make a mesh from a string
    of.popMatrix()                              -- recall the 0,0,0 matrix
    of.pushMatrix()                             -- save 0,0,0 matrix
    
    -- change the string with audio triggers
    if( avG() > 0.1 ) then
       item1 = subject[ math.random( 1, 5) ]
       item2 = verb[ math.random( 1, 4) ]
       item3 = noun[ math.random( 1, 4) ]
       string4 = item1 .. " " .. item2 .. " " .. item3 
    end
        
    of.translate( w2+w4, h2+h4 )                -- move to bottom right, center
    bBox2 = myFont:getStringBoundingBox( 
        string4, 0, 0 )                         -- get bounding box
    bCenter = bBox2:getCenter()                 -- get center of bounding box, ofRectangle, vec3
    of.translate( -bCenter.x, -bCenter.y )          -- center the string
    myFont:drawString( string4, 0, 0)
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