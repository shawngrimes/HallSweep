module(..., package.seeall)

local MyCharacter={}


function MyCharacter.new()
	local movieMachine=require "movieclip";
	
	bully=movieMachine.newAnim( { "images/bully-1-iPad.png",
										"images/bully-2-iPad.png",
										"images/bully-3-iPad.png",
										"images/bully-4-iPad.png",
										} )
										
	bully:setSpeed(0.2) --This is the animation speed
	
	
	--Play all the frames
	bully:play();
	
	local shouldRepeat=true;
	
	--Move the start position to the far right of the screen
	bully:setReferencePoint(display.BottomLeftReferencePoint)
	bully.x=display.contentWidth + bully.contentWidth
	bully.y=display.contentHeight - bully.contentHeight * .5
	
	bully.myName="bully"
	physics.addBody( bully, physicsData:get("bully-2-iPad") )
	
	bully.isFixedRotation = true
	
	--Set your character's speed
	bully.speed=3  -- Try changing this number to adjust the speed
	
	--Calculate the time it takes to travel
	local distanceToTravel=display.contentWidth
	local travelTime=distanceToTravel/(1/bully.speed)
	
	local function repeatCharacter()
		if(shouldRepeat) then
			bully.x=display.contentWidth + bully.contentWidth
			bully.transition=transition.to(bully,{time=travelTime,
									x=-2 * bully.contentWidth,
									onComplete=bully.shouldMoveCharacter})
		end
	end
	
	bully.shouldMoveCharacter = function()
		local randomStartTime=math.random(1000,10000)
		timer.performWithDelay(randomStartTime,repeatCharacter,1)
	end
	
	--Animate them to the far left side of the screen
	bully.shouldMoveCharacter()
	
	
	function onGameOver( self, event )
		shouldRepeat=false
		bully:removeEventListener( "SignalGameOver", bully )
	end
	 
	bully.SignalGameOver = onGameOver
	Runtime:addEventListener( "SignalGameOver", bully )

	return bully;
end

return MyCharacter;