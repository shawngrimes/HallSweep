module(..., package.seeall)

local MyCharacter={}


function MyCharacter.new()

    local shouldRepeat=true;

	flyingBook=display.newImageRect("images/book-iPad.png",116,122)
	
	
	--Move the start position to the far right of the screen
	--MyCharacter:setReferencePoint(display.CenterLeftReferencePoint)
	flyingBook.x=display.contentWidth + flyingBook.contentWidth * 3
	
	print("Content Width: "..display.contentWidth)
	print("flyingBook Width: "..flyingBook.contentWidth)
	print("flyingBook Off Screen: "..tostring(-2 * flyingBook.contentWidth))
	flyingBook.myName="flyingBook"
	physics.addBody( flyingBook, "static", physicsData:get("book-iPad") )
	
	flyingBook.isFixedRotation = false
	
	local function spitRotate (event)
		transition.to( flyingBook, { rotation = flyingBook.rotation - 360, time=600 } )
	end
	
	flyingBook.rotateTimer=timer.performWithDelay(600, spitRotate, 0 )
	
	
	function flyingBookOnGameOver( self, event )
		shouldRepeat=false
		Runtime:removeEventListener( "SignalGameOver", flyingBookOnGameOver )
	end
	flyingBook.SignalGameOver = onGameOver
	
	local function removeObject(object)
		timer.cancel(flyingBook.rotateTimer)
		Runtime:removeEventListener( "SignalGameOver", flyingBook )
		flyingBook:removeSelf()
		flyingBook=nil;
	end
	
	--Set your character's speed
	flyingBook.speed=2  -- Try changing this number to adjust the speed
	
	--Calculate the time it takes to travel
	local distanceToTravel=display.contentWidth
	local travelTime=distanceToTravel/(1/flyingBook.speed)
	
	
	local function repeatCharacter()
		if(shouldRepeat) then
			flyingBook.x=display.contentWidth + flyingBook.contentWidth
			flyingBook.y=math.random(flyingBook.contentHeight,display.contentHeight * .5)
			flyingBook.transition=transition.to(flyingBook,{time=travelTime,
									x=-3 * flyingBook.contentWidth,
									onComplete=flyingBook.shouldMoveCharacter})
		end
	end
	
	flyingBook.shouldMoveCharacter = function()
		local randomStartTime=math.random(5000,15000)
		timer.performWithDelay(randomStartTime,repeatCharacter,1)
	end
	
	flyingBook.shouldMoveCharacter()
	
	
	Runtime:addEventListener( "SignalGameOver", flyingBookOnGameOver )

	return flyingBook
end


return MyCharacter;