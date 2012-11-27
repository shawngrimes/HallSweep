local MyCharacter={}

	local shouldRepeat=true;

	MyCharacter=display.newImageRect("images/spitball-iPad.png",26,26)
	
	
	--Move the start position to the far right of the screen
	--MyCharacter:setReferencePoint(display.CenterLeftReferencePoint)
	MyCharacter.x=display.contentWidth + MyCharacter.contentWidth * 3
	
	print("Content Width: "..display.contentWidth)
	print("Spitball Width: "..MyCharacter.contentWidth)
	print("Spitball Off Screen: "..tostring(-2 * MyCharacter.contentWidth))
	MyCharacter.myName="spitball"
	physics.addBody( MyCharacter, "static", physicsData:get("spitball-iPad") )
	
	MyCharacter.isFixedRotation = false
	
	local function spitRotate (event)
		transition.to( MyCharacter, { rotation = MyCharacter.rotation - 360, time=600 } )
	end
	
	MyCharacter.rotateTimer=timer.performWithDelay(600, spitRotate, 0 )
	
	
	function onGameOver( self, event )
		shouldRepeat=false
		Runtime:removeEventListener( "SignalGameOver", MyCharacter )
	end
	MyCharacter.SignalGameOver = onGameOver
	
	local function removeObject(object)
		timer.cancel(MyCharacter.rotateTimer)
		MyCharacter:removeEventListener( "SignalGameOver", MyCharacter )
		MyCharacter:removeSelf()
		MyCharacter=nil;
	end
	
	--Set your character's speed
	MyCharacter.speed=1.5  -- Try changing this number to adjust the speed
	
	--Calculate the time it takes to travel
	local distanceToTravel=display.contentWidth
	local travelTime=distanceToTravel/(1/MyCharacter.speed)
	
	
	local function repeatCharacter()
		if(shouldRepeat) then
			MyCharacter.x=display.contentWidth + MyCharacter.contentWidth
			MyCharacter.y=math.random(MyCharacter.contentHeight,display.contentHeight * .5)
			MyCharacter.transition=transition.to(MyCharacter,{time=travelTime,
									x=-3 * MyCharacter.contentWidth,
									onComplete=MyCharacter.shouldMoveCharacter})
		end
	end
	
	MyCharacter.shouldMoveCharacter = function()
		local randomStartTime=math.random(1000,5000)
		timer.performWithDelay(randomStartTime,repeatCharacter,1)
	end
	
	MyCharacter.shouldMoveCharacter()
	
	
	Runtime:addEventListener( "SignalGameOver", MyCharacter )


return MyCharacter;