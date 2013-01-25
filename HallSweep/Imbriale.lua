module(..., package.seeall)

local MyCharacter={}


function MyCharacter.new()
    local movieMachine=require "movieclip";
	
	imbriale=movieMachine.newAnim( { "images/imbriale-1-iPad.png",
										"images/imbriale-2-iPad.png",
										"images/imbriale-3-iPad.png",
										"images/imbriale-4-iPad.png",
										} )
										
	imbriale:setSpeed(0.2) --This is the animation speed
	
	
	--Play all the frames
	imbriale:play();
	
	local shouldRepeat=true;
	
	--Move the start position to the far right of the screen
	imbriale:setReferencePoint(display.BottomLeftReferencePoint)
	imbriale.x=display.contentWidth + imbriale.contentWidth
	imbriale.y=display.contentHeight - imbriale.contentHeight * .5
	
	imbriale.myName="imbriale"
	physics.addBody( imbriale, physicsData:get("imbriale-2-iPad") )
	
	imbriale.isFixedRotation = true
	
	--Set your character's speed
	imbriale.speed=4  -- Try changing this number to adjust the speed
	
	--Calculate the time it takes to travel
	local distanceToTravel=display.contentWidth
	local travelTime=distanceToTravel/(1/imbriale.speed)
	
	local function repeatCharacter()
		if(shouldRepeat) then
			imbriale.x=display.contentWidth + imbriale.contentWidth
			imbriale.transition=transition.to(imbriale,{time=travelTime,
									x=-2 * imbriale.contentWidth,
									onComplete=imbriale.shouldMoveCharacter})
		end
	end
	
	imbriale.shouldMoveCharacter = function()
		local randomStartTime=math.random(5000,15000)
		timer.performWithDelay(randomStartTime,repeatCharacter,1)
	end
	
	--Animate them to the far left side of the screen
	imbriale.shouldMoveCharacter()
	
	
	function imbrialeOnGameOver( self, event )
		shouldRepeat=false
		Runtime:removeEventListener( "SignalGameOver", imbrialeOnGameOver )
	end
	 
	imbriale.SignalGameOver = onGameOver
	Runtime:addEventListener( "SignalGameOver", imbrialeOnGameOver )

	return imbriale;
end

return MyCharacter;