---- Path Example
require("eyesy")                    -- include the eyesy library
modeTitle = "Example - Path"    -- name the mode
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
    
    ---------------------- draw the first polyline shape, a circle, using arc()
    myPath = of.Path()                          -- define a polyline class
    circleW = h8
    myPath:arc( glm.vec3(0,0,0), h8, h8, 0, 360, true )
    myPath:close()
    
    ---------------------- draw a complex path, C and G
    h8_3 = h8 / 3                       -- 3rd of h8
    h8_6 = h8 / 6                       -- 6th of h8, helpful for drawing 
    myPath2 = of.Path()                 -- define a new path class, call it myPath2
    
    CandG()                             -- define the vertices for myPath2, see below
    
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
    of.drawBitmapString( "PATH EXAMPLE", c + glm.vec3( 5,-5,0 ) )
    ------------------ draw the circle path
    of.pushMatrix()                             -- store the current matrix
    of.translate( w4, h4)                       -- move to top left, center
    of.rotateDeg( knob1*360, 1,1,1)             -- rotate on all axis with knob1
    sound = (avG() * h) + h8
    myPath:setColor( of.Color(123, 0, 222, 20) )
    myPath:arc( glm.vec3(0,0,0), sound, sound, 0, 360, true ) -- make the circle size respond to the signal
    myPath:draw()
    ------------------ draw the circle path multiple times
    of.popMatrix()                              -- recall stored matrix
    of.pushMatrix()                             -- store the current matrix
    of.translate( w2+w4, h4 )                   -- move to top right, center
    of.rotateDeg( knob2*360, 1,1,1)             -- rotate on all axis with knob2
    rotDeg = 360 / 8
    for i = 0, 7 do
        of.rotateDeg( i*rotDeg, 0, 1, 0 )
        myPath:setColor( of.Color(123, 0, 222, 20) )
        s = (inL[ i+1 ] * h2) + h8
        myPath:arc( glm.vec3(0,0,0), s, s, 0, 360, true ) -- make the circle size respond to the signal

        myPath:draw()
        myPath:clear()
        
    end
    
    
    ------------------ draw the complex path
    of.popMatrix()                              -- recall stored matrix
    of.pushMatrix()                             -- store the current matrix
    of.translate( w4, h2+h4 )                   -- draw to the bottom left, center
    of.rotateDeg( knob3*360, 1,1,1 )            -- rotate with knob3 all axis
    of.translate( -(h8+5), -h16 )               -- center the CG to itself
    
    
    myPath2:setColor( of.Color(123, 0, 222, 244) ) -- set the color
    myPath2:draw()                              -- draw the path
    
    ------------------------ draw myPath2 in the bottom right center
    
    of.popMatrix()                              -- recall stored matrix
    of.pushMatrix()                             -- store the current matrix
    of.translate( w2+w4, h2+h4 )                -- bottom right, center
    of.rotateDeg( knob5*360, 1,1,1 )            -- rotate with knob5, all axis

    scaleMin = (knob4*2) + 0.1                  -- knob4 sets minimum size
    scaleA = (avG() * 4) + scaleMin             -- audio average scales the CG
    myPath2:scale( scaleA, scaleA )             -- scale the entire path
    
    cgW = (h8+5) * scaleA                       -- scale width
    cgH = h16 * scaleA                          -- scale height
    of.translate( -cgW, -cgH )                  -- center the CG to itself
    myPath2:draw()                              -- draw the path
    
    ----- *** the scale changes the vertices permanently, so we need to clear 
    ---- and redefine the points with the CandG() function at the end of the loop
    myPath2:clear()                             -- clear all data from myPath2
    CandG()                                     -- redefine the vertices for myPath2
end

--------------------------------- the c and g vertices as a function, used above
function CandG()
    -------------------- draw a 'C'
    
    myPath2:moveTo( glm.vec2( 0, 0) )                   -- top left of C
    myPath2:lineTo( glm.vec2( h8, 0) )                  -- top right of C
    myPath2:lineTo( glm.vec2( h8, h8_3) )               -- bottom right point
    myPath2:lineTo( glm.vec2( h8_3, h8_3) )             -- top inside
    myPath2:lineTo( glm.vec2( h8_3, h8_3*2) )           -- bottom inside
    myPath2:lineTo( glm.vec2( h8, h8_3*2) )             -- top left of bottom
    myPath2:lineTo( glm.vec2( h8, h8) )                 -- bottom right
    myPath2:lineTo( glm.vec2( 0, h8) )                  -- bottom left
    myPath2:close()                                     -- close the shape, to make a new one
    
    ---------------------------- draw the letter 'G'
    
    space = glm.vec2( h8/35, 0 )            -- define a vec2 with a small x value to make a gap
    myPath2:moveTo( glm.vec2( h8, 0) + space )                           -- top left of G
    myPath2:lineTo( glm.vec2( h4, 0) + space  )                          -- top right of G
    myPath2:lineTo( glm.vec2( h4, h8_3) + space  )                       -- bottom right point
    myPath2:lineTo( glm.vec2( h8+h8_3, h8_3) + space  )                  -- top inside
    myPath2:lineTo( glm.vec2( h8+h8_3, h8_3*2) + space  )                -- bottom inside
    myPath2:lineTo( glm.vec2( h8+(h8_3*2), h8_3*2 ) + space  )           -- bottom left g-hook
    myPath2:lineTo( glm.vec2( h8+(h8_3*2), (h8_3*2)-h8_6 ) + space  )    -- top left g-hook
    myPath2:lineTo( glm.vec2( h4, (h8_3*2)-h8_6 ) + space  )             -- top right g-hook
    myPath2:lineTo( glm.vec2( h4, h8 ) + space  )                        -- bottom right of G
    myPath2:lineTo( glm.vec2( h8, h8 ) + space  )                        -- bottom left of G
    myPath2:close()                                                      -- close the g shape
end

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