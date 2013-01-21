module(..., package.seeall)

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()



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

        -----------------------------------------------------------------------------

        --      CREATE display objects and add them to 'group' here.
        --      Example use-case: Restore 'group' from previously saved state.

        -----------------------------------------------------------------------------
		
		
		-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Alison McGuire Hall Sweep Project
local brickWall = display.newImage ("images/brick_wall.png")
group:insert(brickWall)
brickWall:scale(2,2)
brickWall.x = display.contentWidth/2
brickWall.y = display.contentHeight/2



local widget = require "widget"
local myButtonEvent = function (event)
	if event.phase == "release" then
		print ("You pressed and released the "..event.target.id.."button!")
		if(event.target.id == "highscoreButton") then
			storyboard.gotoScene("HighScores","flip",500)
		elseif(event.target.id == "mainMenuButton") then
			storyboard.gotoScene("MainMenuScene","flip",500)
		elseif(event.target.id == "playAgain") then
			storyboard.gotoScene("GameScene","flip",500)
		end
	end
end 
	
local mybutton=widget.newButton{id="mainMenuButton", default="images/btn-menu-up@2x.png", over="images/btn-menu-down@2x.png", onEvent= myButtonEvent }
group:insert(mybutton)
mybutton.x=display.contentWidth - mybutton.contentWidth/2
mybutton.y=mybutton.contentHeight/2



local mybutton2=widget.newButton{id="playAgain", default="images/btn-playagain-up@2x.png", over="images/btn-playagain-down@2x.png", onEvent= myButtonEvent }
group:insert(mybutton2)
mybutton2.x=0 + mybutton2.contentWidth/2
mybutton2.y=mybutton2.contentHeight/2






patriot = display.newImage ("images/patriot.png", 10, 20)
group:insert(patriot)

patriot.x= display.contentWidth - patriot.contentWidth/2
patriot.y= display.contentHeight - patriot.contentHeight/2

bully = display.newImage ("images/bully.png", 10, 20)
group:insert(bully)

bully.x= bully.contentWidth/2
bully.y= display.contentHeight - bully.contentHeight/2

title = display.newImage("images/hall_sweep_title@2x.png")
group:insert(title)
title.x=display.contentCenterX
title.y=mybutton2.contentBounds.yMax + title.contentHeight/2

myTextObject2= display.newText ("Score:1500",0,0,native.systemFontbold, 25)
group:insert(myTextObject2)
myTextObject2:setTextColor(0,255,0)

myTextObject2.x= display.contentCenterX
myTextObject2.y= title.contentBounds.yMax + myTextObject2.contentHeight

myTextObject3= display.newText ("Distance:600ft",0,0,native.systemFontbold, 25)
group:insert(myTextObject3)
myTextObject3.x= display.contentCenterX
myTextObject3.y= myTextObject2.contentBounds.yMax + myTextObject3.contentHeight

myTextObject4= display.newText ("Coins: 75",0,0,native.systemFontBold, 25)
group:insert(myTextObject4)
myTextObject4.x= display.contentCenterX
myTextObject4.y= myTextObject3.contentBounds.yMax + myTextObject4.contentHeight
myTextObject4:setTextColor(0,0,255)


local mybutton3=widget.newButton{
	id="highscoreButton", 
	default="images/btn_high_scores_up@2x.png", 
	over="images/btn_high_scores_down@2x.png", 
	onEvent= myButtonEvent 
}

group:insert(mybutton3)

mybutton3.x=display.contentCenterX
mybutton3.y=display.contentHeight - mybutton3.contentHeight


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