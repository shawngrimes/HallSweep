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

	local mybackground = display.newImageRect("images/title@2x.png",960,640)
	mybackground.x=display.contentCenterX
	mybackground.y=display.contentCenterY
	group:insert(mybackground)
		
local widget = require "widget"

local myButtonEvent = function (event )
	if event.phase == "release" then
		print( "You pressed and released the "..event.target.id.." button!" )
		storyboard.gotoScene("GameScene","fade",1000)
	end
end 

local myButton=widget.newButton{ 
	id = "play button",
	right = 100, 
	top = 200, 
	--width = 120, height = 50, 
	default="images/btn-play-up@2x.png",
	over="images/btn-play-down@2x.png",
	onEvent = myButtonEvent
	}
	
myButton.x= display.contentCenterX
myButton:setReferencePoint (display.BottomRightReferencePoint)
myButton.x= display.contentWidth - myButton.contentWidth/4 
myButton.y= display.contentHeight - myButton.contentHeight/2
group:insert(myButton)

local myButton2=widget.newButton{
	id = "about button",
	left = 100, 
	top = 200, 
	--width = 120, height = 50, 
	default="images/btn-about-up@2x.png",
	over="images/btn-about-down@2x.png",
	onEvent = myButtonEvent
	}
	
myButton2.x= display.contentCenterX
myButton2:setReferencePoint (display.BottomLeftReferencePoint)
myButton2.x= 0 + myButton2.contentWidth/4
myButton2.y= display.contentHeight - myButton2.contentHeight/2 	
group:insert(myButton2)	
		
end




-- Called BEFORE scene has moved onscreen:
function scene:willEnterScene( event )
        local group = self.view

        -----------------------------------------------------------------------------

        --      This event requires build 2012.782 or later.

        -----------------------------------------------------------------------------
		if(gameBackgroundMusicChannel~=nil) then
			audio.stop(gameBackgroundMusicChannel)
		end
		backgroundMusicChannel=audio.play(titleBackgroundMusicObject, {loops=-1})
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