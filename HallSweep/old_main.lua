-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

--Load Physics Library
local physics = require "physics"

--Show physics drawing lines, for help with debugging
--physics.setDrawMode( "hybrid" )

--Start Physics
physics.start()



local myBackground=display.newImage("background1-iPad@2x.png")
myBackground:setReferencePoint(display.CenterLeftReferencePoint)
myBackground.x=0

local myBackground2=display.newImage("background1-iPad@2x.png")
myBackground2:setReferencePoint(display.CenterLeftReferencePoint)
myBackground2.x=display.contentWidth


moveBackground1=function(object)
	myBackground.x=display.contentWidth
	transition.to(myBackground,{time=3500,x=0})
	transition.to(myBackground2,{time=3500,x=-myBackground2.contentWidth,onComplete=moveBackground2})
end


moveBackground2=function(object)
	myBackground2.x=display.contentWidth
	transition.to(myBackground,{time=3500,x=-myBackground.contentWidth})
	transition.to(myBackground2,{time=3500,x=0,onComplete=moveBackground1})
end


moveBackground2()



--Load rocket mouse physics values
local scaleFactor = 2.0
local physicsData = (require "rocketMousePhysics").physicsData(scaleFactor)

--Create the rocket mouse image
local rocketMouse=display.newImage("rocketmouse_1_run.png")
rocketMouse.myName="rocketMouse"
rocketMouse:scale(scaleFactor,scaleFactor)
rocketMouse:setReferencePoint(display.BottomCenterReferencePoint)
rocketMouse.y=display.contentCenterY
rocketMouse.x=rocketMouse.contentWidth

--Attach the rocket mouse physics body to the image
physics.addBody( rocketMouse, physicsData:get("rocketmouse_1_run") )


--create the floor physics object so we don't fall through
local ground = display.newRect(0, display.contentHeight-50, display.contentWidth, 50)
	ground.myName="ground"
	ground:setFillColor( 255, 0, 0 )
	ground.isVisible = false  -- optional
	physics.addBody( ground, "static", { friction=0.5, bounce=0.3 })
	
--create the ceiling so we don't end up in space
local ceiling = display.newRect(0,0,display.contentWidth,100)
	ceiling.myName="ceiling"
	ceiling:setFillColor( 255, 0, 0 )
	ceiling.isVisible = false  -- optional
	physics.addBody( ceiling, "static", { friction=0.5, bounce=0.3 })

--We are creating an anchor point so the mouse can only move up and down
local pistonGroundPoint=display.newRect(0,display.contentHeight,rocketMouse.contentWidth,rocketMouse.contentHeight)
pistonGroundPoint.myName="pistonGround"
pistonGroundPoint:setFillColor( 0, 255, 0 )
pistonGroundPoint.isVisible = false  -- optional
pistonGroundPoint.x=rocketMouse.x
physics.addBody( pistonGroundPoint, "static", { friction=0.5, bounce=0.3 })


--Now we connect the mouse to the piston point
myPistonJoint = physics.newJoint( "piston", rocketMouse, pistonGroundPoint, rocketMouse.x,rocketMouse.y, 0,-display.contentHeight )


--This value tells us if the mouse is flying or not
rocketMouse.vy=0

--This function will be used to control if the mouse should move
local function moveMouse()
	if(rocketMouse.vy<0) then
		--This applies a force to the rocket mouse (pushing him upward)
		rocketMouse:applyForce(0, rocketMouse.vy, rocketMouse.x, rocketMouse.y)
	end
end

--This detects if we touch the screen to start making the mouse fly
local function onTouch(event)
  if ( event.phase == "began" ) then
     rocketMouse.vy = -4000 * scaleFactor
  elseif ( event.phase == "ended" ) then
     rocketMouse.vy = 0
  end
end

--This event listener, listens for the screen to be touched
Runtime:addEventListener("touch", onTouch)

--This event listener will be called every time the frame loads
Runtime:addEventListener("enterFrame",moveMouse)


local sleepingDog=display.newImage("object_sleepingdog.png")
sleepingDog:scale(2,2)
sleepingDog:setReferencePoint(display.BottomCenterReferencePoint)
sleepingDog.y=display.contentHeight
sleepingDog.x=display.contentWidth
physics.addBody( sleepingDog,"static", physicsData:get("object_sleepingdog") )
sleepingDog.myName="sleepingDog"

moveDog = function()
	sleepingDog.x=display.contentWidth + sleepingDog.contentWidth
	transition.to(sleepingDog, {time=3500, x=-sleepingDog.contentWidth, onComplete=moveDog})
end

moveDog()

local function onDogCollision( self, event )
        if ( event.phase == "began" ) then
                print( self.myName .. ": collision began with " .. event.other.myName )
                local gameOverText=display.newText("Game Over",0,0,native.systemFontBold,128)
                gameOverText.x=display.contentCenterX
                gameOverText.y=display.contentCenterY
                sleepingDog:removeEventListener( "collision", sleepingDog )
        end
end
 
sleepingDog.collision = onDogCollision
sleepingDog:addEventListener( "collision", sleepingDog )

