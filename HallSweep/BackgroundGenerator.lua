module(..., package.seeall)

local BackgroundGenerator={}



function BackgroundGenerator:generateBackground()
	
	local backgroundGroup=display.newGroup()

	local foregroundGroup=display.newGroup()

	
	local randomBackground=1

	if(randomBackground==1) then
		--Generate main hallway background
		local scene1=display.newGroup()
		local myBackground=display.newImageRect("images/game-1-iPad.png",1024,768)
		scene1:insert(myBackground)
		myBackground:setReferencePoint(display.TopLeftReferencePoint)
		myBackground.x=0
		myBackground.y=0
		
		--scene1:setReferencePoint(display.TopLeftReferencePoint)
		scene1.x=0
		scene1.y=0
		backgroundGroup:insert(scene1)
		print("Scene1 X: "..tostring(scene1.contentBounds.xMin))
		
		local sceneSpeed=2;
		
		
		local scene1randomObjects=display.newGroup()
		local scene2randomObjects=display.newGroup()
		local scene3randomObjects=display.newGroup()
		--scene1:insert(scene1randomObjects)
				
		
		local scene2=display.newGroup()
		local myBackground2=display.newImageRect("images/game-1-iPad.png",1024,768)
		myBackground2:setReferencePoint(display.TopLeftReferencePoint)
		myBackground2.x=0
		myBackground2.y=0
		scene2:insert(myBackground2)

		
		--scene2:setReferencePoint(display.TopLeftReferencePoint)
		scene2.x=1 * display.contentWidth
		scene2.y=0
		backgroundGroup:insert(scene2)		
		
		local scene3=display.newGroup()
		local myBackground3=display.newImageRect("images/game-1-iPad.png",1024,768)
		myBackground3:setReferencePoint(display.TopLeftReferencePoint)
		myBackground3.x=0
		myBackground3.y=0
		scene3:insert(myBackground3)
		
		--scene3:setReferencePoint(display.TopLeftReferencePoint)
		scene3.x=2 * display.contentWidth
		scene3.y=0
		backgroundGroup:insert(scene3)		
		
		print("Scene2 xMin: "..tostring(scene2.contentBounds.xMin))
		
		local function generateBackgroundScenery()
			local newBackgroundGroup=display.newGroup()
			local isThreeLocker=false
			--print("Min: "..tostring(newBackgroundGroup.contentBounds.xMin))
			local lastX=0;
			--Need to make sure we only get one 3 door locker
			local randomObjectCount=math.random(1,3)
			randomObjectCount=2
			for i=1,randomObjectCount do
				local randomObject=math.random(1,3)
				if(randomObject==3) then
					if(isThreeLocker) then
						randomObject=math.random(1,2)
					else
						isThreeLocker=true
					end
				end
				local newBackgroundObject
				if(randomObject==1) then
					newBackgroundObject=display.newImageRect("images/locker-2-iPad.png",202,528)
					--newBackgroundObject:setFillColor(0,0,0)
					newBackgroundObject:setReferencePoint(display.BottomLeftReferencePoint)
					newBackgroundObject.y=display.contentHeight
				elseif(randomObject==2) then
					newBackgroundObject=display.newImageRect("images/locker-3-iPad.png",303,529)
					--newBackgroundObject:setFillColor(0,0,0)
					newBackgroundObject:setReferencePoint(display.BottomLeftReferencePoint)
					newBackgroundObject.y=display.contentHeight
				elseif(randomObject==3) then
					newBackgroundObject=display.newImageRect("images/door-iPad.png",197,530)
					newBackgroundObject:setReferencePoint(display.BottomLeftReferencePoint)
					newBackgroundObject.y=display.contentHeight
				end
				newBackgroundGroup:insert(newBackgroundObject)
				newBackgroundObject.x=lastX + newBackgroundObject.contentWidth
				lastX=lastX+newBackgroundObject.contentWidth * 1.5
			end
			return newBackgroundGroup;
		end
		
		scene1randomObjects=generateBackgroundScenery()
		scene1:insert(scene1randomObjects)

		scene2randomObjects=generateBackgroundScenery()
		scene2:insert(scene2randomObjects)
				
				
		scene3randomObjects=generateBackgroundScenery()
		scene3:insert(scene3randomObjects)
				
				
		local bgSpeed = -2.5;
		
		local shouldRepeat=true;
		
		local tPrevious = system.getTimer()
		moveBG = function(event)
			if(shouldRepeat) then
				local tDelta = event.time - tPrevious
				tPrevious = event.time	
				
				local xOffset = ( 0.15 * tDelta )
				
				scene1.x=scene1.x - xOffset
				scene2.x=scene2.x - xOffset
				scene3.x=scene3.x - xOffset
				
				 if(scene2.contentBounds.xMin< 0)  and (scene3.contentBounds.xMin < display.contentWidth)  and (scene1.contentBounds.xMax < 0) then
				 	print("Resetting scene1")
				 	
				 	--[[
				 	print("Scene 1 xMin: "..tostring(scene1.contentBounds.xMin))
				 	print("Scene 1 xMax: "..tostring(scene1.contentBounds.xMax))
				 	
				 	
				 	print("Scene 2 xMin: "..tostring(scene2.contentBounds.xMin))
				 	print("Scene 2 xMax: "..tostring(scene2.contentBounds.xMax))
				 	
				 	
				 	print("Scene 3 xMin: "..tostring(scene3.contentBounds.xMin))
				 	print("Scene 3 xMax: "..tostring(scene3.contentBounds.xMax))
				 	]]
				 	
				 	
				 	
				 	scene1randomObjects:removeSelf();
					scene1randomObjects=display.newGroup()
					
					scene1randomObjects=generateBackgroundScenery()
					scene1:insert(scene1randomObjects)
					
					print("Scene 1 Width: "..tostring(scene1.contentWidth))					
					
					scene1.x=scene3.contentBounds.xMax
				 	--scene1:translate(scene1.contentWidth * 2,0)
				 end
	
				 if(scene3.contentBounds.xMin < 0)  and (scene1.contentBounds.xMin < display.contentWidth)  and (scene2.contentBounds.xMax < 0) then
				 	print("Resetting scene2")
				 	
				 	--[[
				 	print("Scene 1 xMin: "..tostring(scene1.contentBounds.xMin))
				 	print("Scene 1 xMax: "..tostring(scene1.contentBounds.xMax))
				 	
				 	print("Scene 2 xMin: "..tostring(scene2.contentBounds.xMin))
				 	print("Scene 2 xMax: "..tostring(scene2.contentBounds.xMax))
				 	
				 	print("Scene 3 xMin: "..tostring(scene3.contentBounds.xMin))
				 	print("Scene 3 xMax: "..tostring(scene3.contentBounds.xMax))
					]]
				 	
				 	
				 	scene2randomObjects:removeSelf()
					scene2randomObjects=display.newGroup()
					
					scene2randomObjects=generateBackgroundScenery()
					scene2:insert(scene2randomObjects)
					
					print("Scene 2 Width: "..tostring(scene1.contentWidth))
					
					scene2.x=scene1.contentBounds.xMax
				 	--scene2:translate(scene2.contentWidth * 2,0)
				 end
				 
				 if(scene1.contentBounds.xMin < 0) and (scene2.contentBounds.xMin < display.contentWidth)  and (scene3.contentBounds.xMax < 0) then
				 	print("Resetting scene3")
				 	
				 	--[[
				 	print("Scene 1 xMin: "..tostring(scene1.contentBounds.xMin))
				 	print("Scene 1 xMax: "..tostring(scene1.contentBounds.xMax))
				 	
				 	print("Scene 2 xMin: "..tostring(scene2.contentBounds.xMin))
				 	print("Scene 2 xMax: "..tostring(scene2.contentBounds.xMax))
				 	
				 	print("Scene 3 xMin: "..tostring(scene3.contentBounds.xMin))
				 	print("Scene 3 xMax: "..tostring(scene3.contentBounds.xMax))
					]]
				 	
				 	
				 	scene3randomObjects:removeSelf()
					scene3randomObjects=display.newGroup()
					
					scene3randomObjects=generateBackgroundScenery()
					scene3:insert(scene3randomObjects)
					print("Scene 3 Width: "..tostring(scene1.contentWidth))
										
					scene3.x=scene2.contentBounds.xMax
				 	--scene3:translate(scene3.contentWidth * 2,0)
				 end
			end
		end
		
		Runtime:addEventListener("enterFrame",moveBG)
		
		
		
	elseif(randomBackground==2) then
		
	end
	
	function onGameOver( self, event )
		print("here")
		shouldRepeat=false
		Runtime:removeEventListener("enterFrame",moveBG)
		Runtime:removeEventListener( "SignalGameOver", onGameOver )
	end
	 
	Runtime:addEventListener( "SignalGameOver", onGameOver )

	return backgroundGroup, foregroundGroup
end




return BackgroundGenerator;