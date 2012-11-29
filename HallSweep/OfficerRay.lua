module(..., package.seeall)

local MyCharacter={}


function MyCharacter.new()

	local movieMachine=require "movieclip";
	
	officerRay=movieMachine.newAnim( { "images/officerray-1-iPad.png",
										"images/officerray-2-iPad.png",
										"images/officerray-3-iPad.png",
										"images/officerray-4-iPad.png",
										} )
	
	officerRay:setSpeed(0.2) --This is the animation speed
	
	
	--Play all the frames
	officerRay:play();
	
	local shouldRepeat=true;
	
	--Move the start position to the far right of the screen
	officerRay:setReferencePoint(display.BottomLeftReferencePoint)
	officerRay.x=display.contentWidth + officerRay.contentWidth
	officerRay.y=display.contentHeight - officerRay.contentHeight * .5
	
	officerRay.myName="OfficerRay"
	physics.addBody( officerRay, physicsData:get("officerray-2-iPad") )
	
	officerRay.isFixedRotation = true
	
	--Set your character's speed
	officerRay.speed=5  -- Try changing this number to adjust the speed
	
	--Calculate the time it takes to travel
	local distanceToTravel=display.contentWidth
	local travelTime=distanceToTravel/(1/officerRay.speed)
	
	
	local function repeatCharacter()
		if(shouldRepeat) then
			officerRay.x=display.contentWidth + officerRay.contentWidth
			officerRay.transition=transition.to(officerRay,{time=travelTime,
									x=-2 * officerRay.contentWidth,
									onComplete=officerRay.shouldMoveCharacter})
		end
	end
	
	officerRay.shouldMoveCharacter = function()
		local randomStartTime=math.random(1000,10000)
		timer.performWithDelay(randomStartTime,repeatCharacter,1)
	end
	
	--Animate them to the far left side of the screen
	officerRay.shouldMoveCharacter()
	
	
	function onGameOver( self, event )
		shouldRepeat=false
		officerRay:removeEventListener( "SignalGameOver", officerRay )
	end
	 
	officerRay.SignalGameOver = onGameOver
	Runtime:addEventListener( "SignalGameOver", officerRay )
	
	return officerRay;
end

return MyCharacter;