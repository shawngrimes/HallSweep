module(..., package.seeall)

local MyCharacter={}


function MyCharacter.new()

	local shouldRepeat=true;

	spitball=display.newImageRect("images/spitball-iPad@2x.png",52,52)
	
	
	--Move the start position to the far right of the screen
	--MyCharacter:setReferencePoint(display.CenterLeftReferencePoint)
	spitball.x=display.contentWidth + spitball.contentWidth * 3
	
	print("Content Width: "..display.contentWidth)
	print("Spitball Width: "..spitball.contentWidth)
	print("Spitball Off Screen: "..tostring(-2 * spitball.contentWidth))
	spitball.myName="spitball"
	physics.addBody( spitball, "static", physicsData:get("spitball-iPad") )
	
	spitball.isFixedRotation = false
	
	local function spitRotate (event)
		transition.to( spitball, { rotation = spitball.rotation - 360, time=600 } )
	end
	
	spitball.rotateTimer=timer.performWithDelay(600, spitRotate, 0 )
	
	
	function onGameOver( self, event )
		shouldRepeat=false
		Runtime:removeEventListener( "SignalGameOver", spitball )
	end
	spitball.SignalGameOver = onGameOver
	
	local function removeObject(object)
		timer.cancel(spitball.rotateTimer)
		spitball:removeEventListener( "SignalGameOver", spitball )
		spitball:removeSelf()
		spitball=nil;
	end
	
	--Set your character's speed
	spitball.speed=1.5  -- Try changing this number to adjust the speed
	
	--Calculate the time it takes to travel
	local distanceToTravel=display.contentWidth
	local travelTime=distanceToTravel/(1/spitball.speed)
	
	
	local function repeatCharacter()
		if(shouldRepeat) then
			spitball.x=display.contentWidth + spitball.contentWidth
			spitball.y=math.random(spitball.contentHeight,display.contentHeight * .5)
			spitball.transition=transition.to(spitball,{time=travelTime,
									x=-3 * spitball.contentWidth,
									onComplete=spitball.shouldMoveCharacter})
		end
	end
	
	spitball.shouldMoveCharacter = function()
		local randomStartTime=math.random(1000,5000)
		timer.performWithDelay(randomStartTime,repeatCharacter,1)
	end
	
	spitball.shouldMoveCharacter()
	
	
	Runtime:addEventListener( "SignalGameOver", spitball )

	return spitball
end


return MyCharacter;