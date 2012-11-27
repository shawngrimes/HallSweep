local MyCharacter={}


local movieMachine=require "movieclip";

MyCharacter=movieMachine.newAnim( { "images/bully-1-iPad.png",
									"images/bully-2-iPad.png",
									"images/bully-3-iPad.png",
									"images/bully-4-iPad.png",
									} )
									
MyCharacter:setSpeed(0.2) --This is the animation speed


--Play all the frames
MyCharacter:play();

local shouldRepeat=true;

--Move the start position to the far right of the screen
MyCharacter:setReferencePoint(display.BottomLeftReferencePoint)
MyCharacter.x=display.contentWidth + MyCharacter.contentWidth
MyCharacter.y=display.contentHeight - MyCharacter.contentHeight * .5

MyCharacter.myName="bully"
physics.addBody( MyCharacter, physicsData:get("bully-2-iPad") )

MyCharacter.isFixedRotation = true

--Set your character's speed
MyCharacter.speed=3  -- Try changing this number to adjust the speed

--Calculate the time it takes to travel
local distanceToTravel=display.contentWidth
local travelTime=distanceToTravel/(1/MyCharacter.speed)

local function repeatCharacter()
	if(shouldRepeat) then
		MyCharacter.x=display.contentWidth + MyCharacter.contentWidth
		MyCharacter.transition=transition.to(MyCharacter,{time=travelTime,
								x=-2 * MyCharacter.contentWidth,
								onComplete=MyCharacter.shouldMoveCharacter})
	end
end

MyCharacter.shouldMoveCharacter = function()
	local randomStartTime=math.random(1000,10000)
	timer.performWithDelay(randomStartTime,repeatCharacter,1)
end

--Animate them to the far left side of the screen
MyCharacter.shouldMoveCharacter()


function onGameOver( self, event )
	shouldRepeat=false
	MyCharacter:removeEventListener( "SignalGameOver", MyCharacter )
end
 
MyCharacter.SignalGameOver = onGameOver
Runtime:addEventListener( "SignalGameOver", MyCharacter )


return MyCharacter;