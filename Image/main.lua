---- example for how to use Images
require("eyesy")                    -- include the eyesy library
modeTitle = "Example - Image"       -- name the mode
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
    --------------------- define light
    myLight = of.Light()                            -- define a light class
    myLight:setPointLight( )                        -- we'll use a point light for this example
	myLight:setAmbientColor( of.FloatColor( 1, 1, 1 ) ) -- and make the ambient color white
    myLight:setPosition( c + glm.vec3(0,0,h2) )     -- and set the position in the center with z closer
    
    ---------------- fill a table of image paths, looks for Images folder
    myDirect = of.Directory()                       -- define the Directory Class
    myImg = of.Image()          					-- define Image class 
    thePath = myDirect:getAbsolutePath()            -- get current path
    theImgDirectory =  thePath .. "/Images"         -- look in 'Images'
    imgDir = of.Directory( theImgDirectory )        -- define new Directory class
    imgDir:allowExt( "png" )                        -- load only .png files
    imgDir:allowExt( "jpg" )                        -- and load only .jpg files
    imgDir:listDir()                                -- list the directory
    imgTable = {}                                   -- define the table

    for i = 0, imgDir:size()-1 do                   -- for the size of new directory do
        imagePath = imgDir:getPath( i )             -- load paths into a table
        print( "loaded image :", imagePath )              -- print so we can see what is loaded
        imgTable[ i + 1 ] = imagePath               -- fill the table
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
    of.drawBitmapString( "IMAGE EXAMPLE", c + glm.vec3( 5,15,0 ) )
    
    ---------------------- draw the images in the top left, center. knob1 cycles through
    --- and crop x and y
    image_index = math.floor( knob1 * (imgDir:size()-1) ) + 1   -- knob1 index
    myImg:load( imgTable[ image_index ] )                       -- load the image
    
    imgW = myImg:getWidth()                     -- get the width
    imgH = myImg:getHeight()                    -- get the height
    myImg:setAnchorPoint( imgW/2, imgH/2 )      -- move anchor point to center of image
    
    cropW = ( knob2 * (imgW-10) ) + 10          -- crop width with knob2
    cropH = ( knob3 * (imgH-10) ) + 10          -- crop height with knob3
    cropX = ( imgW - cropW ) / 2                -- get the relative x posiiton, to center
    cropY = ( imgH - cropH ) / 2                -- get the relative y
    myImg:crop( cropX, cropY, cropW, cropH )    -- crop the image
    
    newW = myImg:getWidth()                     -- get the new width after crop
    newH = myImg:getHeight()                    -- get the new height
     
    of.enableLighting()                         -- enable lighting globally
    of.enableDepthTest()                        -- enable 3D rendering globally
    
    of.setColor( 255 )                          -- make color bright white, so we can see the texture
    myLight:enable()                            -- begin rendering for myLight
    
    of.pushMatrix()                             -- save 0,0 matrix
    of.translate( w4, h4 )                      -- move to the center of the top left
    myImg:setAnchorPoint( newW/2, newH/2 )      -- make the new center anchor point
    myImg:draw( 0, 0 )                          -- draw the images at original size
    
    
    ---------------- bind the same image to a sphere
    of.popMatrix()                              -- recall last matrix
    of.pushMatrix()                             -- save again
    of.translate( w2+w4, h4 )                   -- move to the center of the top right
    
    of.setColor( 255 )
   
    myImg:bind()                                -- bind the image as texture to following shapes
    
    of.drawSphere( 0, 0, h4/2 )                 -- draw a sphere top right
    myImg:unbind()                              -- unbind the image

    of.setColor(90)
    of.drawPlane( 0, 0, w2, h2 )                -- draw a gray plane so we can see the sphere better
    
    ----------------- zoom on the cropped image
    of.popMatrix()                              -- recall last matrix
    of.pushMatrix()                             -- save again
    kSize = (knob4*0.99) + 0.01                 -- knob4 controls the zook
    reSizeX = kSize * w2                        -- max size is quarter window width
    reSizeY = kSize * h2                        -- max quarter height
    myImg:resize( reSizeX, reSizeY )            -- resize image width and height in pixels
    newW = myImg:getWidth()                     -- get the new width after crop
    newH = myImg:getHeight()                    -- get the new height
    myImg:setAnchorPoint( newW/2, newH/2 )      -- make the new center anchor point

    of.translate( w4, h2+h4 )                   -- move matrix to bottom left
    of.setColor( 255 )                          -- set color back to white
    myImg:draw( 0,0 )                           -- draw the image
    
    ----------------- bind to a 3d box
    of.popMatrix()                              -- recall last matrix
    of.pushMatrix()                             -- save again
    
    of.translate( w2+w4, h2+h4 )                -- move matrix to bottom right, center
    of.rotateDeg( knob5*360, 1, 1, 1 )          -- rotate on all 3 axis with knob5
    myImg:bind()                                -- bind latest version of myImg
    
    of.drawBox( glm.vec3( 0, 0, h8/2), h8 )     -- draw a 3D box
    
    myImg:unbind()                              -- unbind
    
    
    ------------------------ disable lighting and depth
    myLight:disable()                           -- end rendering for myLight
    of.disableLighting()                        -- disable lighting globally
    of.disableDepthTest()                       -- enable 3D rendering globally
    of.popMatrix()                              -- recall last matrix
    
end

---------------------------------------------------------------------------
-- the exit function ends the update and draw loops
function exit()
    -- so we know the script is done
    print("script finished")
end