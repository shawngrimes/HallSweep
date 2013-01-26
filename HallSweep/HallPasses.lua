module(..., package.seeall)

local bezier=require('bezier')

local MyCharacter={}


function MyCharacter.new()

	--create hall pass object
	hallpass=display.newImageRect("images/object-pass-iPad.png",102,64)
	
	
	--Move the start position to the far right of the screen
	hallpass.x=display.contentWidth + hallpass.contentWidth
	hallpass.y=display.contentHeight * .5
	
	hallpass.myName="hallpass"
	physics.addBody( hallpass, "static", { density = 1.0, friction = 0.3, bounce = 0.2 } )
	hallpass.isSensor=true
    
    local function onCollision( self, event )
        print("hallpass Collision With: ", event.other.myName)
        if ( event.phase == "began" and event.other.myName=="patriotHero") then
            hallpass.isVisible=false
        end
    end
    hallpass.collision = onCollision
    hallpass:addEventListener( "collision", hallpass )
    
	local path = {}
--Define your path:
--First Stop on Path
--path[1]={}
--path[1].x=display.contentWidth
--path[1].y=display.contentHeight * .5

local curve = bezier:curve({display.contentWidth, 
                            display.contentWidth,
                            display.contentWidth/2,
                            display.contentWidth/4,
                            -hallpass.contentWidth}, 
                            {display.contentHeight, 
                                0,
                                0, 
                                display.contentHeight,
                                0})
 
    print('curve is a ' .. type(curve))
     
    -- see the terminal for the output of the function
    local function removeObject(object)
    	hallpass:removeSelf()
    	hallpass=nil;
    end
    
    local posCount = 0.01
    --NewX:     -73.593524160001
    --NewY: 	57.826959359998
    local yOffset=math.random( -(57 + hallpass.contentHeight * 2),(display.contentHeight - hallpass.contentHeight - 57)/2)
    --moving the object variable named "ball" -- this is where animation takes place
    local function moveObject(event)
        if posCount <= 1 then
            local newX,newY=curve(posCount)
            newY=newY + yOffset
            hallpass.x=newX
            hallpass.y=newY
            --[[
            local newCircle=display.newCircle( newX, newY, 5 )
            newCircle:setFillColor(255,0,0)
            ]]
            posCount=posCount + 0.01
            
         else
             Runtime:removeEventListener("enterFrame",moveObject);
             removeObject(hallPass);
         end
    end
    local function startMoving()
        Runtime:addEventListener("enterFrame",moveObject);
    end
    timer.performWithDelay(1500,startMoving)
    


	return hallpass
end


return MyCharacter;