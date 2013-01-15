module(..., package.seeall)

local MyCharacter={}

--Create the new character
--local MyCharacter=display.newImage("patriot-1-iPad@2x.png")

function MyCharacter.new()
	
	
	--Load animation module
	local movieMachine=require "movieclip";
	
	--Create a new animation, load all the frames
	local newPatriot=display.newGroup()
	local movingPatriot=movieMachine.newAnim( { "images/patriot-1-iPad.png",
										"images/patriot-2-iPad.png",
										"images/patriot-3-iPad.png",
										"images/patriot-4-iPad.png",
										"images/patriot-5-iPad.png",
										"images/patriot-6-iPad.png",
										"images/patriot-7-iPad.png",
										"images/patriot-8-iPad.png",
										"images/patriot-9-iPad.png"} )
										
	newPatriot:insert(movingPatriot)
	newPatriot.patriotBody=movingPatriot
	movingPatriot:setSpeed(0.2) --This is the animation speed
	
	--Play specific frames
	movingPatriot:play({startFrame=1,endFrame=4})
	
	
	--Set the character in the bottom left
	movingPatriot.x=movingPatriot.contentWidth * .75
	movingPatriot.y=display.contentHeight - movingPatriot.contentHeight * .5
	
	movingPatriot.myName="patriotHero"
	physics.addBody( movingPatriot, physicsData:get("patriot-2-iPad") )
	
	
	--This value tells us if the mouse is flying or not
	newPatriot.vy=0
	
	
	
	--This function will be used to control if the mouse should move
	newPatriot.isFlying=false
	local function movePatriot()
		vx, vy = movingPatriot:getLinearVelocity()		
		--print("Pat Y: "..tostring(Patriot.y))
		if(newPatriot.vy<0) then
			--This applies a force to the rocket mouse (pushing him upward)
			newPatriot.isFlying=true
			movingPatriot:stopAtFrame(5)
			movingPatriot:applyForce(0, newPatriot.vy, movingPatriot, movingPatriot.y)
		elseif(vy>0 and newPatriot.isFlying==true) then
			movingPatriot:stopAtFrame(6)
		end
		
		if(movingPatriot.y>625 and newPatriot.isFlying==true) then
			print("Not flying anymore")
			newPatriot.isFlying=false
			movingPatriot:play({startFrame=1,endFrame=4})
		end
	end
	
	--This detects if we touch the screen to start making the mouse fly
	local function onTouch(event)
	--print("Touching")
	  if ( event.phase == "began" ) then
	     newPatriot.vy = -100000 * scaleFactor
	  elseif ( event.phase == "ended" ) then
	     newPatriot.vy = 0
	  end
	end
	
	--This event listener, listens for the screen to be touched
	Runtime:addEventListener("touch", onTouch)
	
	--This event listener will be called every time the frame loads
	Runtime:addEventListener("enterFrame",movePatriot)
	
	
	
	local function crashPatriot()
		movingPatriot:removeEventListener("collision", movingPatriot)
		movingPatriot:play({startFrame=7,endFrame=9,loop=1})
		Runtime:removeEventListener("enterFrame",movePatriot)
		Runtime:removeEventListener("touch", onTouch)
		Runtime:dispatchEvent({name="SignalGameOver"})
	end
	
	
	local function onCollision( self, event )
	        if ( event.phase == "began" ) then
	        	if(event.other.myName == "bully" or event.other.myName=="OfficerRay") then
	        		crashPatriot()
	        	elseif(event.other.myName == "spitball") then
	        		crashPatriot()
	        	else
	                print( self.myName .. ": collision began with " .. event.other.myName )
	            end
	        end
	end
	 
	newPatriot.collision = onCollision
	newPatriot:addEventListener( "collision", newPatriot )
	
	return newPatriot;
end

return MyCharacter;