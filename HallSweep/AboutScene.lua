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

	local mybackground = display.newImageRect("images/about-iPad.png",1024,768)
	mybackground:setReferencePoint(display.CenterReferencePoint)
	mybackground.x=display.contentCenterX 
	mybackground.y=display.contentCenterY
	group:insert(mybackground)
	
	local widget = require "widget"
	
	local myButtonEvent = function (event)
		if event.phase == "release" then
			print ("You pressed and released the "..event.target.id.."button!")
			if(event.target.id == "twitterButton") then
				system.openURL( "https://twitter.com/APPliedClub" )
			elseif(event.target.id == "facebookButton") then
				system.openURL ( "http://www.facebook.com/APPliedClub" )
			elseif(event.target.id == "websiteButton") then
				system.openURL( "http://www.appliedclub.org/phs/" )
            elseif(event.target.id == "mainMenuButton") then
                storyboard.gotoScene("MainMenuScene","fade",1000)
			end
		end
	end
	
	local twitterButton=widget.newButton{
	id="twitterButton", 
	default="images/btn-twitter-up-iPad.png", 
	over="images/btn-twitter-down-iPad.png", 
	onEvent= twitterButtonEvent 
	}
group:insert(twitterButton)
twitterButton.x=display.contentWidth/1.3
twitterButton.y=display.contentHeight/2 - twitterButton.contentHeight/2

	local facebookButton=widget.newButton{
	id="facebookButton",
	default="images/btn-facebook-up-iPad.png",
	over="images/btn-facebook-down-iPad.png",
	onEvent= facebookButtonEvent
	} 
group:insert(facebookButton)
facebookButton.x=display.contentWidth/1.3
facebookButton.y=display.contentHeight/1.6 - facebookButton.contentHeight/2

	local websiteButton=widget.newButton{
	id="websiteButton",
	default="images/btn-website-up-iPad.png",
	over="images/btn-website-down-iPad.png",
	onEvent= websiteButtonEvent
	} 
group:insert(websiteButton)
websiteButton.x=display.contentWidth/1.3
websiteButton.y=display.contentHeight/1.3 - websiteButton.contentHeight/2

	local mybutton=widget.newButton{
	id="mainMenuButton", 
	default="images/btn-menu-up-iPad.png", 
	over="images/btn-menu-down-iPad.png", 
	onEvent= myButtonEvent 
	}
group:insert(mybutton)
mybutton.x=display.contentWidth/1.3
mybutton.y=display.contentHeight/1.1 - mybutton.contentHeight/2

	
	
	
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