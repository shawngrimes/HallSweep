module(..., package.seeall)

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local coinsCollectedLabel
local isOverlayShowing=false;

local coinsCollected
local distanceTraveled
local alert
----------------------------------------------------------------------------------
-- 
--      NOTE:
--      
--      Code outside of listener functions (below) will only be executed once,
--      unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------


-- local forward references should go here --
---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
        local group = self.view
    
    local params=event.params
    coinsCollected=params.coinsCollected
    distanceTraveled=tostring(math.floor(params.distanceTraveled/30))

-- Alison McGuire Hall Sweep Project
local brickWall = display.newImageRect("images/summary-iPad.png",1024,768)
group:insert(brickWall)
brickWall:scale(1,1)
brickWall.x = display.contentWidth/2
brickWall.y = display.contentHeight/2



local widget = require "widget"
local myButtonEvent = function (event)
	if event.phase == "release" then
		print ("You pressed and released the "..event.target.id.."button!")
		if(event.target.id == "highscoreButton") then
            local options={
                effect="fade",
                time=1000,
                params={
                    playerScore=tostring(tonumber(distanceTraveled) + math.floor(.5 * coinsCollected)),
                }
            }
            print("Sending Player Score: ", options.params.playerScore)
			storyboard.gotoScene("HighScores",options)
		elseif(event.target.id == "mainMenuButton") then
			storyboard.gotoScene("MainMenuScene","flip",500)
		elseif(event.target.id == "playAgain") then
			storyboard.gotoScene("GameScene","flip",500)
		end
	end
end 
	
local mybutton=widget.newButton{
    id="mainMenuButton", 
    default="images/btn-menu-up-iPad.png", 
    over="images/btn-menu-down-iPad.png", 
    onEvent= myButtonEvent 
    }
group:insert(mybutton)
mybutton.x=display.contentWidth - mybutton.contentWidth/1
mybutton.y=mybutton.contentHeight/1



local mybutton2=widget.newButton{
    id="highscoreButton", 
    default="images/btn-scores-up-iPad.png",
    over="images/btn-scores-down-iPad.png", 
    onEvent= myButtonEvent 
    }
group:insert(mybutton2)
mybutton2.x=0 + mybutton2.contentWidth/1
mybutton2.y=mybutton2.contentHeight/1

local Patriot=display.newImageRect("images/summary-patriot-iPad.png",140,210) 
group:insert(Patriot)
Patriot.x= Patriot.contentWidth * 1.5
Patriot.y= display.contentHeight - Patriot.contentHeight

local Principal=display.newImageRect("images/imbriale-iPad.png",114,206)
group:insert(Principal)
Principal.x= display.contentWidth - Principal.contentWidth/.5
Principal.y= display.contentHeight - Principal.contentHeight

local mybutton3=widget.newButton{ 
    id="playAgain",
    default="images/btn-playagain-up-iPad.png", 
    over="images/btn-playagain-down-iPad.png", 
    onEvent= myButtonEvent 
    }

group:insert(mybutton3)

mybutton3.x=display.contentCenterX
mybutton3.y=display.contentHeight - mybutton3.contentHeight

    
    coinsCollectedLabel=display.newText(tostring(params.coinsCollected),460,460,native.systemFontBold,72)
    coinsCollectedLabel:setTextColor(0,0,0);
    group:insert(coinsCollectedLabel);    
    
    
    local distanceString=string.format("%s feet", tostring(math.floor(params.distanceTraveled/30)));
    local distanceTraveledLabel=display.newText(distanceString,580,280,native.systemFontBold,30)
    distanceTraveledLabel.x=700;
    distanceTraveledLabel:setTextColor(0,0,0);
    group:insert(distanceTraveledLabel);    

    local scoreString=string.format("%s points", tostring(math.floor(params.distanceTraveled/30) + math.floor(.5 * params.coinsCollected)));
    local scoreLabel=display.newText(scoreString,580,280,native.systemFontBold,30)
    scoreLabel.x=285;
    scoreLabel.y=distanceTraveledLabel.y
    scoreLabel:setTextColor(0,0,0);
    group:insert(scoreLabel);    
    
     local function onComplete( event )
     	userBox.promptToSubmitScore=false
 		userBox:save()
	    if "clicked" == event.action then
	        local i = event.index
	        if 1 == i then
	        	--print("ONE")
	        	
    		    -- Do nothing; dialog will simply dismiss
	        elseif 2 == i then
	        	----print("TWO")
                if(not highScores:isLoggedIn()) then
					highScores:showLogin();
				else
					alert=native.showAlert( "High Score", "Your score has been sent.", { "OK"} )
				end
			end
	    end
	end
		
	if(userBox.promptToSubmitScore) then
		-- Show alert with two buttons
	    alert=native.showAlert( "Submit High Score?", "Would you like to submit your high score?", { "No Thanks","OK" }, onComplete ) 		
        --group:insert(alert)
 	end
    
end




-- Called BEFORE scene has moved onscreen:
function scene:willEnterScene( event )
        local group = self.view

        -----------------------------------------------------------------------------

        --      This event requires build 2012.782 or later.

        -----------------------------------------------------------------------------

end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
        local group = self.view
        -----------------------------------------------------------------------------

        --      INSERT code here (e.g. start timers, load audio, start listeners, etc.)

        -----------------------------------------------------------------------------
        storyboard.removeScene( "GameScene" )
        
        
       
            
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
        local group = self.view

        -----------------------------------------------------------------------------

        --      INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)

        -----------------------------------------------------------------------------
        alert=nil;
        print("Removing Game Over Scene")
        storyboard.removeScene( "GameOverScene" )
        print("Game Over Scene Removed")
end


-- Called AFTER scene has finished moving offscreen:
function scene:didExitScene( event )
        local group = self.view
        -----------------------------------------------------------------------------

        --      This event requires build 2012.782 or later.

        -----------------------------------------------------------------------------
        --coinsCollectedLabel:removeSelf()
        --coinsCollectedLabel=nil
        
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
        local group = self.view
        -----------------------------------------------------------------------------

        --      INSERT code here (e.g. remove listeners, widgets, save state, etc.)

        -----------------------------------------------------------------------------

end


-- Called if/when overlay scene is displayed via storyboard.showOverlay()
function scene:overlayBegan( event )
        local group = self.view
        local overlay_name = event.sceneName  -- name of the overlay scene

        -----------------------------------------------------------------------------

        --      This event requires build 2012.797 or later.

        -----------------------------------------------------------------------------
        isOverlayShowing=true;
end


-- Called if/when overlay scene is hidden/removed via storyboard.hideOverlay()
function scene:overlayEnded( event )
        local group = self.view
        local overlay_name = event.sceneName  -- name of the overlay scene

        -----------------------------------------------------------------------------

        --      This event requires build 2012.797 or later.

        -----------------------------------------------------------------------------
        
    if(highScores:isLoggedIn()) then
		--print("UserScore: "..tostring(userScore))
		--print("Leaderboard: "..tostring(LEADERBOARD_IDS[gameType]))
        local yourScore=tostring(math.floor(distanceTraveled/30) + math.floor(.5 * coinsCollected))
		highScores:submitHighScore(LEADERBOARD_IDS["standardMode"], yourScore)
		local alert = native.showAlert( "High Score", "Your score has been sent.", { "OK"} )
	end
	isOverlayShowing=false;
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "willEnterScene" event is dispatched before scene transition begins
scene:addEventListener( "willEnterScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "didExitScene" event is dispatched after scene has finished transitioning out
scene:addEventListener( "didExitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

-- "overlayBegan" event is dispatched when an overlay scene is shown
scene:addEventListener( "overlayBegan", scene )

-- "overlayEnded" event is dispatched when an overlay scene is hidden/removed
scene:addEventListener( "overlayEnded", scene )

---------------------------------------------------------------------------------

return scene