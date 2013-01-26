module(..., package.seeall)

local MyCharacter={}


function MyCharacter.newCoin()

	local shouldRepeat=true;
	
	local coin = display.newImageRect( "images/object-coin-iPad.png", 54, 53 )
	coin.myName="coin"
	physics.addBody( coin, "static" , { density = 1.0, friction = 0.3, bounce = 0.2, radius=25} )
    coin.isSensor=true
    coin.isCollected=false
    
    local function onCollision( self, event )
--    	print("Collision With: ", event.other.myName)
--		print("Last Collision With: ",tostring(lastCollisionWith))
        if ( event.phase == "began" and event.other.myName=="patriotHero") then
            coin.isVisible=false
        end
    end
    coin.collision = onCollision
    coin:addEventListener( "collision", coin )
	
		--Move the start position to the far right of the screen
	coin.x=display.contentWidth + coin.contentWidth * 3
	
	--Set your character's speed
	coin.speed=6  -- Try changing this number to adjust the speed
    
    local function coinsOnGameOver( self, event )
    	shouldRepeat=false
        if(coin.transition~=nil) then
            transition.cancel(coin.transition)
            coin.transition=nil
            coin:removeSelf();
        end
		Runtime:removeEventListener( "SignalGameOver", coinsOnGameOver )
	end 
	coin.SignalGameOver = coinsOnGameOver
	Runtime:addEventListener( "SignalGameOver", coinsOnGameOver )
	
	return coin
end


function MyCharacter.newThreeInAColumn()
    local shouldRepeat=true;
    local coins={};
    local tempCoin = MyCharacter.newCoin();
    local topCoinY=math.random(tempCoin.contentHeight * 3, display.contentHeight - tempCoin.contentHeight * 3)
    tempCoin:removeSelf();
    tempCoin=nil;
    
	for counter=1,3 do
		local coin = MyCharacter.newCoin()
	    coin.x=display.contentWidth
		--First Column
		if(counter==1) then
            coin.y=topCoinY
    	else
			topCoinY = topCoinY + coin.contentHeight 
			coin.y=topCoinY
		end
        
		local distanceToTravel=coin.x - (-2 * coin.contentWidth)
        local travelTime=distanceToTravel/(1/coin.speed)
        
        local function removeObject(object)
             if(object.transition~=nil) then
                transition.cancel(object.transition)
                object.transition=nil
            end
            Runtime:removeEventListener( "SignalGameOver", coin )
            if(object~=nil) then
                object:removeSelf();
                object=nil;
            end
        end
        coin.transitionComplete = removeObject
        
        coin.transition=transition.to(coin,{time=travelTime,
            								x=-2 * coin.contentWidth,
        									onComplete=removeObject})
        
        coins[counter]=coin
	end
    
    return coins
	
end

function MyCharacter.newTenColumn()
    local shouldRepeat=true;
    local coins={};
    local tempCoin = MyCharacter.newCoin();
    local topCoinY=math.random(3*tempCoin.contentHeight, display.contentHeight - 3*tempCoin.contentHeight)
    tempCoin:removeSelf();
    tempCoin=nil;
    local lastX=display.contentWidth
    
    for counter=1,10 do
        local coin = MyCharacter.newCoin()
        coin.y=topCoinY
        coin.x=lastX
        lastX=lastX + coin.contentWidth
        
        if((counter%5)==0 and counter>1) then
            topCoinY=topCoinY+coin.contentHeight
            lastX=display.contentWidth
        end
        
        
		
		local distanceToTravel=coin.x - (-2 * coin.contentWidth)
        local travelTime=distanceToTravel/(1/coin.speed)
        
        local function removeObject(object)
             if(object.transition~=nil) then
                transition.cancel(object.transition)
                object.transition=nil
            end
            Runtime:removeEventListener( "SignalGameOver", coin )
            if(object~=nil) then
                object:removeSelf();
                object=nil;
            end
        end
        coin.transitionComplete = removeObject
        
        coin.transition=transition.to(coin,{time=travelTime,
            								x=-2 * coin.contentWidth,
        									onComplete=removeObject})
        
        coins[counter]=coin
	end
    
    return coins
	
end

function MyCharacter.newFifteenColumn()
    local shouldRepeat=true;
    local coins={};
    local tempCoin = MyCharacter.newCoin();
    local topCoinY=math.random(3*tempCoin.contentHeight, display.contentHeight - 3*tempCoin.contentHeight)
    tempCoin:removeSelf();
    tempCoin=nil;
    local lastX=display.contentWidth
    
    for counter=1,15 do
    	local coin = MyCharacter.newCoin()
        coin.y=topCoinY
        coin.x=lastX
        lastX=lastX + coin.contentWidth
        
        if((counter%5)==0 and counter>1) then
            topCoinY=topCoinY+coin.contentHeight
            lastX=display.contentWidth
        end
        
        
		
		local distanceToTravel=coin.x - (-2 * coin.contentWidth)
        local travelTime=distanceToTravel/(1/coin.speed)
        
        local function removeObject(object)
             if(object.transition~=nil) then
                transition.cancel(object.transition)
                object.transition=nil
            end
            Runtime:removeEventListener( "SignalGameOver", coin )
            if(object~=nil) then
                object:removeSelf();
                object=nil;
            end
        end
        coin.transitionComplete = removeObject
        
        coin.transition=transition.to(coin,{time=travelTime,
            								x=-2 * coin.contentWidth,
        									onComplete=removeObject})
        
        coins[counter]=coin
	end
    
    return coins
	
end

function MyCharacter.newFiveInARow()
    local shouldRepeat=true;
    local coins={};
    local tempCoin = MyCharacter.newCoin();
    local topCoinY=math.random(tempCoin.contentHeight, display.contentHeight - tempCoin.contentHeight)
    tempCoin:removeSelf();
    tempCoin=nil;
    
    local lastX=display.contentWidth
    for counter=1,5 do
		local coin = MyCharacter.newCoin()
	    coin.x=lastX
        lastX=lastX + coin.contentWidth
        
        coin.y=topCoinY
		
		local distanceToTravel=coin.x - (-2 * coin.contentWidth)
        local travelTime=distanceToTravel/(1/coin.speed)
        
        local function removeObject(object)
             if(object.transition~=nil) then
                transition.cancel(object.transition)
                object.transition=nil
            end
            Runtime:removeEventListener( "SignalGameOver", coin )
            if(object~=nil) then
                object:removeSelf();
                object=nil;
            end
        end
        coin.transitionComplete = removeObject
        
        coin.transition=transition.to(coin,{time=travelTime,
            								x=-2 * coin.contentWidth,
        									onComplete=removeObject})
        
        coins[counter]=coin
	end
    
    return coins
	
end

function MyCharacter.newMattCoins()

    local shouldRepeat=true;
	local coins={};

	for counter=1,40 do
		local coin = MyCharacter.newCoin()
	
		--First Column
		if(counter==1) then
			coin.x=display.contentWidth
			coin.y=display.contentHeight*.100
		elseif (counter==2) then
			coin.x=display.contentWidth
			coin.y=display.contentHeight*.150
		elseif(counter==3) then
			coin.x=display.contentWidth
			coin.y=display.contentHeight*.200
		elseif(counter==4) then
			coin.x=display.contentWidth
			coin.y=display.contentHeight*.250
		elseif(counter==5) then
			coin.x=display.contentWidth
			coin.y=display.contentHeight*.300
		elseif(counter==6) then
			coin.x=display.contentWidth
			coin.y=display.contentHeight*.350
		elseif(counter==7) then
			coin.x=display.contentWidth
			coin.y=display.contentHeight*.400
		elseif(counter==8) then
			coin.x=display.contentWidth
			coin.y=display.contentHeight*.450
		elseif(counter==9) then
			coin.x=display.contentWidth
			coin.y=display.contentHeight*.500
		elseif(counter==10) then
			coin.x=display.contentWidth
			coin.y=display.contentHeight*.550	
		elseif (counter==11) then
			coin.x=display.contentWidth+30
			coin.y=display.contentHeight*.100
		elseif(counter==12) then
			coin.x=display.contentWidth+50
			coin.y=display.contentHeight*.150
		elseif(counter==13) then
			coin.x=display.contentWidth+70
			coin.y=display.contentHeight*.200
		elseif(counter==14) then
			coin.x=display.contentWidth+90
			coin.y=display.contentHeight*.250
		elseif(counter==15) then
			coin.x=display.contentWidth+110
			coin.y=display.contentHeight*.300
		elseif(counter==16) then
			coin.x=display.contentWidth+130
			coin.y=display.contentHeight*.350
		elseif(counter==17) then
			coin.x=display.contentWidth+150
			coin.y=display.contentHeight*.400
		elseif(counter==18) then
			coin.x=display.contentWidth+170
			coin.y=display.contentHeight*.450
		elseif(counter==19) then
			coin.x=display.contentWidth+190
			coin.y=display.contentHeight*.500
		elseif(counter==20) then
			coin.x=display.contentWidth+210
			coin.y=display.contentHeight*.550
		elseif(counter==21) then
			coin.x=display.contentWidth+230
			coin.y=display.contentHeight*.550	
		elseif (counter==22) then
			coin.x=display.contentWidth+250
			coin.y=display.contentHeight*.500
		elseif(counter==23) then
			coin.x=display.contentWidth+250
			coin.y=display.contentHeight*.450
		elseif(counter==24) then
			coin.x=display.contentWidth+250
			coin.y=display.contentHeight*.400
		elseif(counter==25) then
			coin.x=display.contentWidth+250
			coin.y=display.contentHeight*.350
		elseif(counter==26) then
			coin.x=display.contentWidth+250
			coin.y=display.contentHeight*.300
		elseif(counter==27) then
			coin.x=display.contentWidth+250
			coin.y=display.contentHeight*.250
		elseif(counter==28) then
			coin.x=display.contentWidth+250
			coin.y=display.contentHeight*.200
		elseif(counter==29) then
			coin.x=display.contentWidth+250
			coin.y=display.contentHeight*.150
		elseif(counter==30) then
			coin.x=display.contentWidth+250
			coin.y=display.contentHeight*.100
		elseif(counter==31) then
			coin.x=display.contentWidth+250
			coin.y=display.contentHeight*.50
		elseif(counter==32) then
			coin.x=display.contentWidth+270
			coin.y=display.contentHeight*.100
		elseif(counter==33) then
			coin.x=display.contentWidth+290
			coin.y=display.contentHeight*.150	
		elseif (counter==34) then
			coin.x=display.contentWidth+310
			coin.y=display.contentHeight*.200
		elseif(counter==35) then
			coin.x=display.contentWidth+330
			coin.y=display.contentHeight*.250
		elseif(counter==36) then
			coin.x=display.contentWidth+350
			coin.y=display.contentHeight*.300
		elseif(counter==37) then
			coin.x=display.contentWidth+370
			coin.y=display.contentHeight*.350
		elseif(counter==38) then
			coin.x=display.contentWidth+390
			coin.y=display.contentHeight*.400
		elseif(counter==39) then
			coin.x=display.contentWidth+410
			coin.y=display.contentHeight*.450
		elseif(counter==40) then
			coin.x=display.contentWidth+430
			coin.y=display.contentHeight*.500
		elseif(counter==41) then
			coin.x=display.contentWidth+450
			coin.y=display.contentHeight*.550
		end
    
    	local distanceToTravel=coin.x - (-2 * coin.contentWidth)
        local travelTime=distanceToTravel/(1/coin.speed)
        
        local function removeObject(object)
             if(object.transition~=nil) then
                transition.cancel(object.transition)
                object.transition=nil
            end
            Runtime:removeEventListener( "SignalGameOver", coin )
            if(object~=nil) then
                --[[if pcall(function() object:removeSelf() end) then
                    else
                    object = nil -- just making sure
                end
                ]]
                object:removeSelf();
            end
        end
    	coin.transitionComplete = removeObject
        
        coin.transition=transition.to(coin,{time=travelTime,
            								x=-2 * coin.contentWidth,
        									onComplete=removeObject})
        
        coins[counter]=coin
	end
    
    return coins
end


function MyCharacter.newAliCoins()
    local shouldRepeat=true;
    local coins={};

	for counter=1,26 do
		local coin = MyCharacter.newCoin()
        if(counter==1) then
    		coin.x=display.contentWidth + 100
			coin.y=display.contentHeight*.550
		elseif (counter==2) then
			coin.x=display.contentWidth + 120
			coin.y=display.contentHeight*.500
		elseif(counter==3) then
			coin.x=display.contentWidth + 140
			coin.y=display.contentHeight*.450
		elseif(counter==4) then
			coin.x=display.contentWidth + 160
			coin.y=display.contentHeight*.400
		elseif(counter==5) then
			coin.x=display.contentWidth + 180
			coin.y=display.contentHeight*.350
		elseif(counter==6) then
			coin.x=display.contentWidth + 200
			coin.y=display.contentHeight*.300
		elseif(counter==7) then
			coin.x=display.contentWidth + 220
			coin.y=display.contentHeight*.250
		elseif(counter==8) then
			coin.x=display.contentWidth + 240
			coin.y=display.contentHeight*.200
		elseif(counter==9) then
			coin.x=display.contentWidth + 260
			coin.y=display.contentHeight*.150
		elseif(counter==10) then
			coin.x=display.contentWidth + 280
			coin.y=display.contentHeight*.100	
		elseif (counter==11) then
			coin.x=display.contentWidth + 300
			coin.y=display.contentHeight*.100
		elseif(counter==12) then
			coin.x=display.contentWidth + 320
			coin.y=display.contentHeight*.150
		elseif(counter==13) then
			coin.x=display.contentWidth + 340
			coin.y=display.contentHeight*.200
		elseif(counter==14) then
			coin.x=display.contentWidth + 360
			coin.y=display.contentHeight*.250
		elseif(counter==15) then
			coin.x=display.contentWidth + 380
			coin.y=display.contentHeight*.300
		elseif(counter==16) then
			coin.x=display.contentWidth + 400
			coin.y=display.contentHeight*.350
		elseif(counter==17) then
			coin.x=display.contentWidth + 420
			coin.y=display.contentHeight*.400
		elseif(counter==18) then
			coin.x=display.contentWidth + 440
			coin.y=display.contentHeight*.450
		elseif(counter==19) then
			coin.x=display.contentWidth + 460
			coin.y=display.contentHeight*.500
		elseif(counter==20) then
			coin.x=display.contentWidth + 470
			coin.y=display.contentHeight*.550
		elseif(counter==21) then
			coin.x=display.contentWidth + 220
			coin.y=display.contentHeight*.300
		elseif(counter==22) then
			coin.x=display.contentWidth + 250
			coin.y=display.contentHeight*.300
		elseif(counter==23) then
			coin.x=display.contentWidth + 280
			coin.y=display.contentHeight*.300
		elseif(counter==24) then
			coin.x=display.contentWidth + 310
			coin.y=display.contentHeight*.300
		elseif(counter==25) then
			coin.x=display.contentWidth + 340
			coin.y=display.contentHeight*.300
		elseif(counter==26) then
			coin.x=display.contentWidth + 370
			coin.y=display.contentHeight*.300
		end
        
        
        local distanceToTravel=coin.x - (-2 * coin.contentWidth)
        local travelTime=distanceToTravel/(1/coin.speed)
        
        local function removeObject(object)
             if(object.transition~=nil) then
                transition.cancel(object.transition)
                object.transition=nil
            end
            Runtime:removeEventListener( "SignalGameOver", coin )
            if(object~=nil) then
                --[[if pcall(function() object:removeSelf() end) then
                    else
                    object = nil -- just making sure
                end
                ]]
                object:removeSelf();
            end
        end
        coin.transitionComplete = removeObject
        
        coin.transition=transition.to(coin,{time=travelTime,
            								x=-2 * coin.contentWidth,
        									onComplete=removeObject})
        
        coins[counter]=coin
	end
    
    return coins
end



return MyCharacter;