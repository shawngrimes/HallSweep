module(..., package.seeall)

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

--Second Stop on Path
path[1]={}
path[1].x=display.contentWidth * .5
path[1].y=0

--Third Stop on Path
path[2]={}
path[2].x=-hallpass.contentWidth
path[2].y=display.contentHeight * .5
 
local animate
local posCount = 1
--moving the object variable named "ball" -- this is where animation takes place
local function moveObject(event)
	print("PosCount: ",posCount)
	print("Path #: ",#path)
     if posCount <= #path then
     	transition.to(hallpass,{ time=1500,x=path[posCount].x,y=path[posCount].y})
--        hallpass.x = path[posCount].x
--        hallpass.y = path[posCount].y
        posCount = posCount + 1
     else
         timer.cancel(animate)
     end
end
 
-- to move ball when we click the animate text
local function move()
	posCount = 1
	animate = timer.performWithDelay( 3000, moveObject, #path )
end
	
	local function removeObject(object)
		hallpass:removeSelf()
		hallpass=nil;
	end
	
	
	move()


	return hallpass
end


return MyCharacter;