module(..., package.seeall)

local BackgroundGenerator={}



function BackgroundGenerator:generateBackground()
	
	local backgroundGroup=display.newGroup()

	local foregroundGroup=display.newGroup()

	
	local backgroundType=1

	if(backgroundType==1) then
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
            print("Generating Background Scenere for Type: ",backgroundType)
			local newBackgroundGroup=display.newGroup()
            if(backgroundType==1) then
    			local isThreeLocker=false
    			--print("Min: "..tostring(newBackgroundGroup.contentBounds.xMin))
    			local lastX=0;
    			--Need to make sure we only get one 3 door locker
    			local randomObjectCount=math.random(1,3)
    			randomObjectCount=3
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
    				
                    if(lastX+newBackgroundObject.contentWidth >= display.contentWidth) then
                        newBackgroundObject:removeSelf()
                    else
                        print("Last X: ",lastX + newBackgroundObject.contentWidth)
                        newBackgroundGroup:insert(newBackgroundObject)
        				newBackgroundObject.x=lastX --+ newBackgroundObject.contentWidth
        				lastX=lastX+newBackgroundObject.contentWidth * 1.1
                    end
    			end
            elseif(backgroundType==2) then
                local lastX=110;
        		--Need to make sure we only get one 3 door locker
                local isDoubleDoor=false
    			local randomObjectCount=math.random(2,4)
                for i=1,randomObjectCount do
        			local randomObject=math.random(1,100)
    				if(randomObject>75) then
    					if(isDoubleDoor) then
    						randomObject=2
    					else
    						isDoubleDoor=true
    					end
    				end
    				local newBackgroundObject
    				if(randomObject>75) then
                        print("Adding double door")
    					newBackgroundObject=display.newImageRect("images/door-double-iPad.png",392,377)
    					--newBackgroundObject:setFillColor(0,0,0)
    					newBackgroundObject:setReferencePoint(display.BottomLeftReferencePoint)
    					newBackgroundObject.y=607
    				else
                        print("Adding window")
    					newBackgroundObject=display.newImageRect("images/window-iPad.png",218,291)
    					--newBackgroundObject:setFillColor(0,0,0)
    					newBackgroundObject:setReferencePoint(display.BottomLeftReferencePoint)
    					newBackgroundObject.y=newBackgroundObject.contentHeight + newBackgroundObject.contentHeight * .1
    				end
    				
                    if(lastX+newBackgroundObject.contentWidth > (display.contentWidth - 100)) then
                        newBackgroundObject:removeSelf()
                    else
                        newBackgroundGroup:insert(newBackgroundObject)
            			newBackgroundObject.x=lastX
        				lastX=lastX+newBackgroundObject.contentWidth * 1.1
                    end
    			end
            end
			return newBackgroundGroup;
		end
		
		scene1randomObjects=generateBackgroundScenery()
		scene1:insert(scene1randomObjects)

		scene2randomObjects=generateBackgroundScenery()
		scene2:insert(scene2randomObjects)
				
				
		scene3randomObjects=generateBackgroundScenery()
		scene3:insert(scene3randomObjects)
		
        local scene1FG=display.newGroup()
        local scene2FG=display.newGroup()
        local scene3FG=display.newGroup()
		
		local bgSpeed = -2.5;
		
		local shouldRepeat=true;
		
		local tPrevious = system.getTimer()
		moveBG = function(event)
			if(shouldRepeat) then
				local tDelta = event.time - tPrevious
				tPrevious = event.time	
				
				local xOffset = ( 0.15 * tDelta )
				
				scene1.x=scene1.x - xOffset
                scene1FG.x=scene1.x
                
				scene2.x=scene2.x - xOffset
                scene2FG.x=scene2.x
                
				scene3.x=scene3.x - xOffset
                scene3FG.x=scene3.x
				
				 if(scene2.contentBounds.xMin< 0)  and (scene3.contentBounds.xMin < display.contentWidth)  and (scene1.contentBounds.xMax < 0) then
                    if(backgroundType==3) then
                        print("Resetting scene1 to backgroundType=1")
                        backgroundType=1
                        scene1:removeSelf()
                        scene1=display.newGroup()
                        backgroundGroup:insert(scene1)
                        scene1:toBack()
                        myBackground=display.newImageRect("images/game-1-iPad.png",1024,768)
                        scene1:insert(myBackground)
                        myBackground:toBack()
                        myBackground:setReferencePoint(display.TopLeftReferencePoint)
        	            myBackground.x=0
    		            myBackground.y=0
                        
                        scene1FG:removeSelf()
                        scene1FG=display.newGroup()
                        
                    elseif(backgroundType==1) then
                        print("Resetting scene1 to backgroundType=2")
                        backgroundType=2
                        scene1:removeSelf()
                        scene1=display.newGroup()
                        backgroundGroup:insert(scene1)
                        scene1:toBack()
                        
                        myBackground=display.newImageRect("images/game-2-end-iPad.png",1024,768)
        	            scene1:insert(myBackground)
                        
                        myBackground:toBack()
                        myBackground:setReferencePoint(display.TopLeftReferencePoint)
        	            myBackground.x=0
    		            myBackground.y=0
                        
                        scene1FG:removeSelf()
                        scene1FG=display.newGroup()
                        
                    elseif(backgroundType==2) then
                        print("Resetting scene1 to backgroundType=2")
                        backgroundType=3
                        scene1:removeSelf()
                        scene1=display.newGroup()
                        backgroundGroup:insert(scene1)
                        scene1:toBack()
                        
                        myBackground=display.newImageRect("images/game-3-endleft-background-iPad.png",1024,768)
                        scene1:insert(myBackground)
                        
                        myBackground:toBack()
                        myBackground:setReferencePoint(display.TopLeftReferencePoint)
        	            myBackground.x=0
    		            myBackground.y=0
                        
                        scene1FG:removeSelf()
                        scene1FG=display.newGroup()
                        scene1FG.x=display.contentWidth
                        
                        local scene1FGImage=display.newImageRect("images/game-3-center-foreground-iPad.png",1024,768)
                        scene1FG:insert(scene1FGImage)
                        scene1FGImage:setReferencePoint(display.TopLeftReferencePoint)
                        scene1FGImage.x=0
    		            scene1FGImage.y=0
                        
                        foregroundGroup:insert(scene1FG)
                        
				 	end
                    --Uncomment for testing
                    --[[
                    local myRect=display.newRect(0,0,display.contentWidth,display.contentHeight)
                        myRect:setFillColor(255,0,0)
                        scene1:insert(myRect)
                        myRect:toBack()
                        ]]
                        
				 	--scene1randomObjects:removeSelf();
					scene1randomObjects=display.newGroup()
					
					scene1randomObjects=generateBackgroundScenery()
					scene1:insert(scene1randomObjects)
					
					print("Scene 1 Width: "..tostring(scene1.contentWidth))					
					
					scene1.x=scene3.contentBounds.xMax
				 	--scene1:translate(scene1.contentWidth * 2,0)
				 end
	
				 if(scene3.contentBounds.xMin < 0)  and (scene1.contentBounds.xMin < display.contentWidth)  and (scene2.contentBounds.xMax < 0) then
				 	print("Resetting scene2")
                     print("Background Type: ", tostring(backgroundType))
                     if(backgroundType==1) then
            		 	scene2:removeSelf()
                        scene2=display.newGroup()
                        backgroundGroup:insert(scene2)
                        scene2:toBack()
            
                        myBackground2=display.newImageRect("images/game-1-iPad.png",1024,768)
        	            scene2:insert(myBackground2)
                        myBackground2:toBack()
                        myBackground2:setReferencePoint(display.TopLeftReferencePoint)
        	            myBackground2.x=0
    		            myBackground2.y=0
                        
                        scene2FG:removeSelf()
                        scene2FG=display.newGroup()
                        
                     elseif(backgroundType==2) then
        			 	scene2:removeSelf()
                        scene2=display.newGroup()
                        backgroundGroup:insert(scene2)
                        scene2:toBack()
                        
                        myBackground2=display.newImageRect("images/game-2-center-iPad.png",1024,768)
        	            scene2:insert(myBackground2)

                        myBackground2:toBack()
                        myBackground2:setReferencePoint(display.TopLeftReferencePoint)
        	            myBackground2.x=0
    		            myBackground2.y=0
                    elseif(backgroundType==3) then
            		 	scene2:removeSelf()
                        scene2=display.newGroup()
                        backgroundGroup:insert(scene2)
                        scene2:toBack()
                        
                        myBackground2=display.newImageRect("images/game-3-center-scenery-iPad.png",1024,768)
        	            scene2:insert(myBackground2)
                        
                        myBackground2:toBack()
                        myBackground2:setReferencePoint(display.TopLeftReferencePoint)
        	            myBackground2.x=0
    		            myBackground2.y=0
                        
                        scene2FG:removeSelf()
                        scene2FG=display.newGroup()
                        scene2FG.x=display.contentWidth
                        
                        local scene2FGImage=display.newImageRect("images/game-3-center-foreground-iPad.png",1024,768)
                        scene2FG:insert(scene2FGImage)
                        scene2FGImage:setReferencePoint(display.TopLeftReferencePoint)
                        scene2FGImage.x=0
        	            scene2FGImage.y=0
                        
                        
                        foregroundGroup:insert(scene2FG)
				 	end
                     
                     --Uncomment for testing
                     --[[
                    local myRect=display.newRect(0,0,display.contentWidth,display.contentHeight)
                    myRect:setFillColor(0,255,0)
                    scene2:insert(myRect)
                    myRect:toBack()
				 	]]
                     
				 	--scene2randomObjects:removeSelf()
					scene2randomObjects=display.newGroup()
					
					scene2randomObjects=generateBackgroundScenery()
					scene2:insert(scene2randomObjects)
					
					print("Scene 2 Width: "..tostring(scene2.contentWidth))
					
					scene2.x=scene1.contentBounds.xMax
				 	--scene2:translate(scene2.contentWidth * 2,0)
				 end
				 
				 if(scene1.contentBounds.xMin < 0) and (scene2.contentBounds.xMin < display.contentWidth)  and (scene3.contentBounds.xMax < 0) then
				    print("Resetting scene3")
                    print("Background Type: ", tostring(backgroundType))
                    if(backgroundType==1) then
                	 	scene3:removeSelf()
                        scene3=display.newGroup()
                        backgroundGroup:insert(scene3)
                        scene3:toBack()
                        
                        myBackground3=display.newImageRect("images/game-1-iPad.png",1024,768)
        	            scene3:insert(myBackground3)
                        
                        myBackground3:toBack()
                        myBackground3:setReferencePoint(display.TopLeftReferencePoint)
        	            myBackground3.x=0
    		            myBackground3.y=0
                        
                        scene3FG:removeSelf()
                        scene3FG=display.newGroup()
                        
                    elseif(backgroundType==2) then
            		 	scene3:removeSelf()
                        scene3=display.newGroup()
                        backgroundGroup:insert(scene3)
                        scene3:toBack()
                        
                        myBackground3=display.newImageRect("images/game-2-end-iPad.png",1024,768)
                        --myBackground3:setReferencePoint(display.TopLeftReferencePoint)
                        myBackground3:scale(-1,1)
                        myBackground3:setReferencePoint(display.TopRightReferencePoint)
                        myBackground3.x=0
    		            myBackground3.y=0
        	            scene3:insert(myBackground3)
                        
                        myBackground3:toBack()
                    elseif(backgroundType==3) then
                	 	scene3:removeSelf()
                        scene3=display.newGroup()
                        backgroundGroup:insert(scene3)
                        scene3:toBack()
                        
                        myBackground3=display.newImageRect("images/game-3-endright-background-iPad.png",1024,768)
                        --myBackground3:setReferencePoint(display.TopLeftReferencePoint)
                        myBackground3:setReferencePoint(display.TopLeftReferencePoint)
                        myBackground3.x=0
    		            myBackground3.y=0
        	            scene3:insert(myBackground3)
                        
                        myBackground3:toBack()
                        
                        scene3FG:removeSelf()
                        scene3FG=display.newGroup()
                        scene3FG.x=display.contentWidth
                        
                        local scene3FGImage=display.newImageRect("images/game-3-center-foreground-iPad.png",1024,768)
                        scene3FG:insert(scene3FGImage)
                        scene3FGImage:setReferencePoint(display.TopLeftReferencePoint)
                        scene3FGImage.x=0
        	            scene3FGImage.y=0
                        
                        foregroundGroup:insert(scene3FG)
    			 	end
                    --[[ 
                    local myRect=display.newRect(0,0,display.contentWidth,display.contentHeight)
                    myRect:setFillColor(0,0,255)
                    scene3:insert(myRect)
                    myRect:toBack()
                     ]]--
                 
				 	--scene3randomObjects:removeSelf()
					scene3randomObjects=display.newGroup()
					
					scene3randomObjects=generateBackgroundScenery()
					scene3:insert(scene3randomObjects)
					print("Scene 3 Width: "..tostring(scene3.contentWidth))
										
					scene3.x=scene2.contentBounds.xMax
				 	--scene3:translate(scene3.contentWidth * 2,0)
				 end
			end
		end
		
		Runtime:addEventListener("enterFrame",moveBG)
		
		
		
	elseif(randomBackground==2) then
		
	end
	
	function backgroundOnGameOver( self, event )
		shouldRepeat=false
		Runtime:removeEventListener("enterFrame",moveBG)
		Runtime:removeEventListener( "SignalGameOver", backgroundOnGameOver )
	end
	 
	Runtime:addEventListener( "SignalGameOver", backgroundOnGameOver )

	return backgroundGroup, foregroundGroup
end




return BackgroundGenerator;