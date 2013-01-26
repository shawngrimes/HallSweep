module(..., package.seeall)

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local FontNameToUse="DefaultFont"


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
        local playerScore=event.params.playerScore;
        -----------------------------------------------------------------------------

        --      CREATE display objects and add them to 'group' here.
        --      Example use-case: Restore 'group' from previously saved state.

        -----------------------------------------------------------------------------
		
--		local highscoresObject=display.newText("High Scores",0,0,native.systemFontBold,96)
local highscoresObject=display.newImageRect("images/scores-iPad.png",1024,768)
		group:insert(highscoresObject)
highscoresObject.x = display.contentCenterX
highscoresObject.y = highscoresObject.contentHeight/2

--This adds the widget library to our project
local widget = require "widget"

--This is what is run when we press our button
local onButtonEvent = function (event )
  if event.phase == "release" then
  	print( "You pressed and released a button!" )
  	if(event.target.id=="mainMenuButton") then
	  	storyboard.gotoScene( "MainMenuScene", "fade", 200 )
	elseif(event.target.id=="playAgainButton") then
		storyboard.gotoScene( "GameScene", "fade", 200 )
	end
  end
end

local playAgainButton=widget.newButton{
 id = "playAgainButton",
 --this is the default button image
 default="images/btn-playagain-up-iPad.png",
 --this is the image to use when the button is pressed
 over="images/btn-playagain-down-iPad.png",
 --this tells it what function to call when you press the button
  onEvent = onButtonEvent
}
group:insert(playAgainButton)

--playAgainButton:scale(.5,.5)
playAgainButton.x = display.contentCenterX
playAgainButton.y = display.contentHeight - playAgainButton.contentHeight

local mainMenuButton=widget.newButton{
 id = "mainMenuButton",
 --this is the default button image
 default="images/btn-menu-up-iPad.png",
 --this is the image to use when the button is pressed
 over="images/btn-menu-down-iPad.png",
 --this tells it what function to call when you press the button
  onEvent = onButtonEvent
}
		group:insert(mainMenuButton)
mainMenuButton.x = mainMenuButton.contentWidth * .7 --display.contentCenterX
mainMenuButton.y = mainMenuButton.contentHeight

local nameTitle1=display.newText("Initials",0,0,native.systemFontBold,72)
		group:insert(nameTitle1)
nameTitle1.y=highscoresObject.contentBounds.yMax  + nameTitle1.contentHeight

local scoreTitle1=display.newText("Scores",0,0,native.systemFontBold,72)
		group:insert(scoreTitle1)
scoreTitle1.y=highscoresObject.contentBounds.yMax + scoreTitle1.contentHeight
scoreTitle1.x=display.contentWidth - scoreTitle1.contentWidth/2

local nameObject1=display.newText("1. MC",0,0,native.systemFont,55)
		group:insert(nameObject1)
nameObject1.y=nameTitle1.y + nameObject1.contentHeight

local scoreObject1=display.newText("100 ft",0,0,native.systemFont,55)
		group:insert(scoreObject1)
scoreObject1.y=scoreTitle1.y + scoreObject1.contentHeight
scoreObject1.x=display.contentWidth - scoreObject1.contentWidth

local nameObject2=display.newText("2. SG",0,0,native.systemFont,55)
		group:insert(nameObject2)
nameObject2.y=nameObject1.y + nameObject2.contentHeight

local scoreObject2=display.newText("95 ft",0,0,native.systemFont,55)
		group:insert(scoreObject2)
scoreObject2.y=scoreObject1.y + scoreObject2.contentHeight
scoreObject2.x=display.contentWidth - scoreObject1.contentWidth

local myImagePatriot = display.newImageRect( "images/patriot-5-iPad.png",270,226 )
group:insert(myImagePatriot)

myImagePatriot:setReferencePoint(display.BottomLeftReferencePoint)
--Change the reference point of the object

myImagePatriot.x=0
--This will add a buffer of half the objects width, if you want it flush with the
--left, change it to myObject.x=0

myImagePatriot.y=display.contentHeight 
--This will add a buffer of half the object's height, if you want it flush
--bottom, change it to myObject.y=display.contentHeight

    local containerGroup=display.newGroup();
    group:insert(containerGroup)


    local fontScale=.5
    local yourScoreText=TextCandy.CreateText({
		fontName= FontNameToUse,
		text="YOU",
		originX = "CENTER",
		originY= "CENTER",
		showOrigin=false
	});	
	yourScoreText:setColor(178, 19, 24)
	yourScoreText:scale(fontScale,fontScale)
	yourScoreText.y=260
	yourScoreText.x=300
	containerGroup:insert(yourScoreText);
	
	local yourScoreValueText=TextCandy.CreateText({
		fontName= FontNameToUse,
		text= tostring(playerScore),
		originX = "CENTER",
		originY= "CENTER",
		showOrigin=false
	});	
	yourScoreValueText:setColor(178, 19, 24)
	yourScoreValueText:scale(fontScale,fontScale)
	yourScoreValueText.x=710
	yourScoreValueText.y=yourScoreText.y
	containerGroup:insert(yourScoreValueText);
    
    local scrollView = widget.newScrollView{
	    width = 850,
	    height = 320,
	    scrollWidth = 850,
	    scrollHeight = 768,--yourScoreText.contentHeight * 10,
	    hideBackground=true,
	    --maskFile="images/iOS/scrollViewMask-iPad@2x.png",
	    --maskFile="mask-320x320.png",
	    --listener = scrollViewListener
	}
	scrollView.x=100
	scrollView.y=280
	scrollView.maskX=0
	scrollView.maskY=0
	containerGroup:insert(scrollView);
    
    local scoresContainerGroup = display.newGroup()
    containerGroup:insert(scoresContainerGroup)
    local mask = graphics.newMask( "images/scoresMask.png" )
    scoresContainerGroup:insert(scrollView);
		
    scoresContainerGroup:setMask( mask )
    scoresContainerGroup:setReferencePoint( display.CenterReferencePoint )
    
    scoresContainerGroup.maskY=display.contentCenterY
    scoresContainerGroup.maskX=display.contentCenterX
    local leaderBoardID="12HLXkc2O1"
    local highestScoreValueContentWidth=0;
    	if(userBox.leaderboards[leaderBoardID]~=nil) then
	        for i=1,# userBox.leaderboards[leaderBoardID] do
	        	local score=userBox.leaderboards[leaderBoardID][i]
				--		textFieldFont = native.newFont( "HVD Comic Serif Pro", 24 )
				local userScoreText = display.newText("here",0,0,"HVD Comic Serif Pro", 64)
				userScoreText:setTextColor(85,85,85)
				userScoreText:scale(fontScale,fontScale)
				
				local stringMax=30
				if(Utils.isIPadRetina()) then
					stringMax=40
				elseif(Utils.isIPad()) then
					stringMax=27
				elseif(Utils.isIPhoneRetina()) then
					stringMax=21
				elseif(Utils.isIPhone()) then
					stringMax=20
				end
				
				
				if(score["user"]~=nil) then
					--userScoreText.text="Too Long To Show"
					--userScoreText.text=tostring(i)..". ".. "Too Long To Show"
					if(string.len(tostring(i)..". "..score["user"])>stringMax) then
						userScoreText.text=string.sub(tostring(i)..". "..score["user"],1,stringMax).."…"
					else
						userScoreText.text=(tostring(i)..". "..score["user"])	
					end
					--userScoreText.text=(tostring(i)..". "..score["user"])
				else
					userScoreText.text=tostring(i)..". --"
				end
				
				local buffer=25
				userScoreText:setReferencePoint(display.CenterLeftReferencePoint)
				userScoreText.y=i * userScoreText.contentHeight * .5 + (i-1) * userScoreText.contentHeight * .5 + userScoreText.contentHeight * .5
				userScoreText.x=buffer
				scrollView:insert(userScoreText);
				
				local scoreText = display.newText("5",0,0,"HVD Comic Serif Pro", 64)
				scoreText:setTextColor(85,85,85)
				scoreText:scale(fontScale,fontScale)
				scoreText.text=tostring(score["score"]);
				if(i==1) then
					highestScoreValueContentWidth=scoreText.contentWidth
				end
				

				local boundsX,boundsY=scrollView:contentToLocal(scrollView.contentBounds.xMax, 50 )
				--scoreText.x=boundsX - highestScoreValueContentWidth 
				local buffer=25
				scoreText.x=610
				scoreText.y=userScoreText.y
				scrollView:insert(scoreText);
				--scoreText.width=highestScoreValueContentWidth
								
	        	if(tonumber(score["score"])<tonumber(playerScore)) then
	        		--this is a high score
	        		isHighScore=true
	        	end
                --print("Adding Score:")
	        	if(score["user"]~=nil) then
		        	--print("Username: "..score["user"].."    Score:"..score["score"])
		        else
			        --print("Username: ''    Score:"..score["score"])
		        end
	        end
		end
        myImagePatriot:toFront()
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
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
        local group = self.view

        -----------------------------------------------------------------------------

        --      INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)

        -----------------------------------------------------------------------------

end


-- Called AFTER scene has finished moving offscreen:
function scene:didExitScene( event )
        local group = self.view
        -----------------------------------------------------------------------------

        --      This event requires build 2012.782 or later.

        -----------------------------------------------------------------------------
     storyboard.removeScene( "HighScores" )
     highScores:getHighScores();
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

end


-- Called if/when overlay scene is hidden/removed via storyboard.hideOverlay()
function scene:overlayEnded( event )
        local group = self.view
        local overlay_name = event.sceneName  -- name of the overlay scene

        -----------------------------------------------------------------------------

        --      This event requires build 2012.797 or later.

        -----------------------------------------------------------------------------

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