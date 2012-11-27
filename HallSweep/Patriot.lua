local MyCharacter={}

--Create the new character
--local MyCharacter=display.newImage("patriot-1-iPad@2x.png")

--Load animation module
local movieMachine=require "movieclip";

--Create a new animation, load all the frames
MyCharacter=movieMachine.newAnim( { "images/patriot-1-iPad.png",
									"images/patriot-2-iPad.png",
									"images/patriot-3-iPad.png",
									"images/patriot-4-iPad.png",
									"images/patriot-5-iPad.png",
									"images/patriot-6-iPad.png",
									"images/patriot-7-iPad.png",
									"images/patriot-8-iPad.png",
									"images/patriot-9-iPad.png"} )

MyCharacter:setSpeed(0.2) --This is the animation speed


--Play all the frames
MyCharacter:play();

--Play specific frames
MyCharacter:play({startFrame=1,endFrame=4})


--Set the character in the bottom left
MyCharacter.x=MyCharacter.contentWidth * .5
MyCharacter.y=display.contentHeight - MyCharacter.contentHeight * .5

MyCharacter.myName="patriotHero"
physics.addBody( MyCharacter, physicsData:get("patriot-2-iPad") )


--This value tells us if the mouse is flying or not
MyCharacter.vy=0



--This function will be used to control if the mouse should move
local isFlying=false
function movePatriot()
	vx, vy = MyCharacter:getLinearVelocity()
	--print("Pat Y: "..tostring(Patriot.y))
	if(MyCharacter.vy<0) then
		--This applies a force to the rocket mouse (pushing him upward)
		isFlying=true
		MyCharacter:stopAtFrame(5)
		MyCharacter:applyForce(0, MyCharacter.vy, MyCharacter, MyCharacter.y)
	elseif(vy>0 and isFlying==true) then
		MyCharacter:stopAtFrame(6)
	end
	
	if(MyCharacter.y>625 and isFlying==true) then
		isFlying=false
		MyCharacter:play({startFrame=1,endFrame=4})
	end
end

--This detects if we touch the screen to start making the mouse fly
local function onTouch(event)
  if ( event.phase == "began" ) then
     MyCharacter.vy = -100000 * scaleFactor
  elseif ( event.phase == "ended" ) then
     MyCharacter.vy = 0
  end
end

--This event listener, listens for the screen to be touched
Runtime:addEventListener("touch", onTouch)

--This event listener will be called every time the frame loads
Runtime:addEventListener("enterFrame",movePatriot)



local function crashPatriot()
	MyCharacter:removeEventListener("collision", MyCharacter)
	MyCharacter:play({startFrame=7,endFrame=9,loop=1})
	Runtime:dispatchEvent({name="SignalGameOver"})
	Runtime:removeEventListener("enterFrame",movePatriot)
	Runtime:removeEventListener("touch", onTouch)
end


function onCollision( self, event )
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
 
MyCharacter.collision = onCollision
MyCharacter:addEventListener( "collision", MyCharacter )

return MyCharacter;