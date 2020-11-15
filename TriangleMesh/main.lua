---- This is a Mesh Example using the Triangle Mode
require("eyesy")                        -- include the eyesy library
modeTitle = "Example - Triangle Mesh"   -- name the mode
print(modeTitle)                        -- print the mode title

---------------------------------------------------------------------------
-- helpful global variables 
w = of.getWidth()           -- global width  
h = of.getHeight()          -- global height of screen
w2 = w / 2                  -- width half 
h2 = h / 2                  -- height half
w4 = w / 4                  -- width quarter
h4 = h / 4                  -- height quarter
c = glm.vec3( w2, h2, 0 )   -- center in glm vector
                 
---------------------------------------------------------------------------
-- the setup function runs once before the update and draw loops
function setup()
    -------- define font for labels
    myFont = of.TrueTypeFont()
    myFont:load( "arial.ttf", 12 )
    -------- define and set the light source
    myLight = of.Light()                -- define a light class
    myLight:setPointLight( )            -- we'll use a point light for this example
	myLight:setAmbientColor( of.FloatColor( 1, 1, 1 ) ) -- and make the ambient color white
    myLight:setPosition( glm.vec3(w2,0,0) )            -- and set the position in the center, top
   
    ----------------- to draw a mesh we need to define a class first (myMesh) and choose a mode
    myMesh = of.Mesh()                          -- define a Mesh class
    myMesh:setMode( of.PRIMITIVE_TRIANGLES )    -- set the mesh mode to triangles
    
    -- the first step for drawing a mesh from scratch is adding vertices
    -- we can declare vertices by using a 3-point vector x,y,z using the following format
    v1 = glm.vec3( 0, h2, 0)        -- vertex far left, center
    v2 = glm.vec3( w4, 0, 0)        -- vertex center, top
    v3 = glm.vec3( w2, h2, 0)       -- vertex far right, center
    -- add the vertices to the mesh, myMesh
    myMesh:addVertex( v1 )     
    myMesh:addVertex( v2 )     
    myMesh:addVertex( v3 )     
    
    -- now we have to tell the mesh how to connect these vertices, by using index
    -- the vertices are referred to from 0 - max points
    -- the format is three indices to draw the triangle
    -- 0 point will connect to the next two points
    -- here we start with 0 connect it to 1 and then 2
    myMesh:addIndex( 0 )
    myMesh:addIndex( 1 )
    myMesh:addIndex( 2 )  
    ---------- the following code is for labeling the points
    -- here we shift the points by usig the vector glm.vec3 with the variables name.x, name.y, name.z
    p1 = myMesh:getVertex( 0 )      -- define new vec3 called p1 - p3
    p2 = myMesh:getVertex( 1 )
    p3 = myMesh:getVertex( 2 )
    
    p1.x = p1.x + 20                -- move p1 to the right 20 pixels
    p1.y = p1.y + 20                -- move p1 down 20 pixels
    
    p2.x = p2.x + 40                -- move p2 right 40 pixels
    p2.y = p2.y + 20                -- move p2 down 20 pixels
    
    p3.x = p3.x - 80                -- move p3 left 80 pixels
    p3.y = p3.y + 20                -- move p3 down 20 pixels
    --------------------------------------------------------------------------
    -- lets make another more complex mesh called myMesh2
    myMesh2 = of.Mesh()                          -- define a Mesh class
    myMesh2:setMode( of.PRIMITIVE_TRIANGLES )    -- set the mesh mode to triangles
    
    -- draw a pyramid, use v1 and v3 from myMesh
    pyr1 = myMesh:getVertex( 1 )        -- center top, 0
    pyr1.z = pyr1.z - h4
    pyr2 = myMesh:getVertex( 0 )        -- front left 1
    pyr3 = myMesh:getVertex( 2 )        -- front right 2
    pyr4 = myMesh:getVertex( 0 )        -- back left 3
    pyr4.z = pyr4.z - h2
    pyr5 = myMesh:getVertex( 2 )        -- back right 4
    pyr5.z = pyr5.z - h2
    
    -- for loop to add the 5 pyr points to myMesh2
    myMesh2:addVertex( pyr1 )                       -- add first vertex
    myMesh2:addColor( of.FloatColor( 1,0,0 ) )      -- make it blue
    
    myMesh2:addVertex( pyr2 )                       -- add 2 vertex
    myMesh2:addColor( of.FloatColor( 0,1,0 ) )      -- make it green                           
    
    myMesh2:addVertex( pyr3 )                       -- add 3 v
    myMesh2:addColor( of.FloatColor( 0,0,1 ) )      -- make it blue
    
    myMesh2:addVertex( pyr4 )                       -- add 4 v
    myMesh2:addColor( of.FloatColor( 0,1,1 ) )      -- make it yellow    
    
    myMesh2:addVertex( pyr5 )                       -- add 5 v
    myMesh2:addColor( of.FloatColor( 1,1,0 ) )      -- make it cyan
    
    -- now we need to define how the points are connected

    myMesh2:addIndex( 0 )
    myMesh2:addIndex( 1 )
    myMesh2:addIndex( 2 )  
    
    myMesh2:addIndex( 0 )
    myMesh2:addIndex( 1 )
    myMesh2:addIndex( 3 )
    
    myMesh2:addIndex( 0 )
    myMesh2:addIndex( 2 )
    myMesh2:addIndex( 4 )  
    
    myMesh2:addIndex( 0 )
    myMesh2:addIndex( 3 )
    myMesh2:addIndex( 4 )  
    
    -- close the bottom with two right angle triangles
    myMesh2:addIndex( 1 )
    myMesh2:addIndex( 2 )
    myMesh2:addIndex( 3 )
    
    myMesh2:addIndex( 2 )
    myMesh2:addIndex( 3 )
    myMesh2:addIndex( 4 )
    
    -- add color
    
    
    
    
    
    print("done setup")                         -- so we know that the setup was succesful
end
---------------------------------------------------------------------------
-- update function runs on loop
function update()
end

---------------------------------------------------------------------------
-- the main draw function also runs on loop
function draw()

    -- the above steps have defined a mesh, now we need to draw it
    of.setBackgroundColor( 255 )            -- set background color to white
    --------------------- draw the grid
    of.setColor( 0 )                    -- set color black
    of.drawLine( 0, h2, w, h2 )         -- draw a horizontal line at the center (h2)
    of.drawLine( w2, 0, w2, h )         -- draw a vertical at the center (w2)    
    
    --------------------- draw the title
    of.drawBitmapString( "MESH EXAMPLE", c + glm.vec3( 5,-h2+14,0 ) )
    

    --------------------- draw myMesh, a 2d triangle
    of.setColor( 90 )                       -- set the mesh color to dark grey
    myMesh:draw()                           -- draw myMesh 
    -- label the points
    of.drawBitmapString( "Vertex 1", p1)
    of.drawBitmapString( "Vertex 2", p2 )
    of.drawBitmapString( "Vertex 3", p3 )
    ------------------------------------ draw myMesh2, a 3D pyramid
    
    of.enableLighting()                 -- enable lighting for the scene
    of.enableDepthTest()                -- and depth
    myLight:enable()                    -- start the light

    of.pushMatrix()
    of.translate( w2+w4, 0, -h4 )
    of.rotateDeg( knob1*360, 0, 1, 0 )
    
    of.translate( -w4, 0, h4 )
    myMesh2:draw()                      -- draw myMesh2  
    -------- *** not sure why this isnt working, not responding to the z
    of.drawBitmapString( "Vertex 1", myMesh2:getVertex( 0 ) + glm.vec3(0,-40,0) )
    of.drawBitmapString( "Vertex 2", myMesh2:getVertex( 1 ) + glm.vec3( 0,20,0) )
    of.drawBitmapString( "Vertex 3", myMesh2:getVertex( 2 ) + glm.vec3(-80,20,0) )
    of.drawBitmapString( "Vertex 4", myMesh2:getVertex( 3 ) )
    of.drawBitmapString( "Vertex 5", myMesh2:getVertex( 4 ) )
   
    --------- **NUMBER 3** draw next pyramid and here change the vertex points with knob 2 and 3
    of.popMatrix()
    of.pushMatrix()
    -- store points 
    
    ogP1 = myMesh2:getVertex(0)
    ogP2 = myMesh2:getVertex(1)
    
    myMesh2:setVertex( 0, ogP1 + glm.vec3(0,knob2*h2,0) )
    myMesh2:setVertex( 1, ogP2 + glm.vec3(knob3*w2,0,0) )
   
    
    of.translate( w4, 0, -h4 )
    of.rotateDeg( knob1*360, 0, 1, 0 )
    
    of.translate( -w4, h2, h4 )
    myMesh2:draw()    
    
     -- return the points so they dont count up over the draw loop
    myMesh2:setVertex( 0, ogP1 )
    myMesh2:setVertex( 1, ogP2 )
    
    -------- ***Number 4 draw the next pyramid and the top point is now moved with the audio vertically
    of.popMatrix()                                          -- recall precious pushed matrix
    of.pushMatrix()                                         -- save the matrix again
    ogP1 = myMesh2:getVertex(0)                             -- get the original vertex
             
    move = avG() * w2                                       -- get the amplitude average times by w2
    myMesh2:setVertex( 0, ogP1 + glm.vec3( 0, move, 0 ) )   -- reset the vertex, like this, vector + vector
    
    
    of.translate( w2+w4, h2, -h4 )                          -- translate for rotation axis (center of pyramid)
    of.rotateDeg( knob1*360, 0, 1, 0 )                      -- rotate around the Y axis
    
    of.translate( -w4, 0, h4 )                              -- translate for position
    myMesh2:draw()                                          -- draw myMesh2
    
    myMesh2:setVertex( 0, ogP1 )                            -- reset the vertex back to the original
    
    of.popMatrix()                          -- end of our draw loop, recall original matrix                                           
    myLight:disable()                       -- end the light
    of.disableDepthTest()                   -- disable depth    
    of.disableLighting()                    -- and disable light
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

------------------------ the exit function, draw loop ends and do the following
function exit()
    print("script finished")
end