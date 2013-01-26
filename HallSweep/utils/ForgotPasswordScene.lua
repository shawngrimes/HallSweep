----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------
 
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
 
---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

local fb_access_token=""
local fb_expire=""
 
local componentsGroup
local usernameField
local backgroundImage
local usernameField

-- Called when the scene's view does not exist:
function scene:createScene( event )
   local group = self.view

   local background=display.newRect(group, 0,0,display.contentWidth,display.contentHeight);
   background:setFillColor(0,0,0);
   background:setStrokeColor(255,255,255);
   background.alpha=0.5
   
   backgroundImage=display.newImageRect("images/login-iPad.png",622,652)
   backgroundImage.x=Utils.screenWidth * .5
   backgroundImage.y=Utils.screenHeight * .5
   group:insert(backgroundImage)
 
 	componentsGroup=display.newGroup();
 	group:insert(componentsGroup)
		
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
      local function onEmail( event )
    	if ( "began" == event.phase ) then
    		print("text: "..event.target.text)
    		if(event.target.text=="Email...") then
				event.target.text = ""
			end
	        -- Note: this is the "keyboard appearing" event
	        -- In some cases you may want to adjust the interface while the keyboard is open.
		elseif ("ended" == event.phase) then
			if(event.target.text=="") then
				event.target.text="Email..."
			end
	    elseif ( "submitted" == event.phase ) then
	        -- Automatically tab to password field if user clicks "Return" on iPhone keyboard (convenient!)
	        native.setKeyboardFocus( nil )
	    end
	end
		
	local widget = require "widget";
		
    textFieldFont = native.newFont( "HVD Comic Serif Pro", 16/display.contentScaleY )

	usernameField=native.newTextField(10,30,Utils.screenWidth * .5,Utils.screenHeight * .05);
	usernameField.x=display.contentCenterX
	usernameField.y=backgroundImage.contentBounds.yMin + usernameField.contentHeight * 3
	usernameField.font=textFieldFont
	usernameField.text = "Email..."
	usernameField:setTextColor( 198,198,198, 255 )
	usernameField:addEventListener('userInput', onEmail);
	componentsGroup:insert(usernameField);
		
	local onButtonEvent = function (event )
    	if event.phase == "release" then
	        print( "You pressed and released a button!" )
	        if(event.target.id == "logInButton") then
	        	print("Trying to reset password");
	        	highScores:resetPassword(usernameField.text)
			elseif(event.target.id == "cancelButton") then
				storyboard.hideOverlay("slideDown")
			else
				local alert = native.showAlert( "Coming Soon", "That button is still being worked on", { "OK"} )
	        end
	    end
	end
	
	local cancelButton=widget.newButton{
		id="cancelButton",
		default="images/btn-cancel-up-iPad.png",
		over="images/btn-cancel-down-iPad.png",
		onEvent = onButtonEvent
	}
	cancelButton.x=backgroundImage.contentBounds.xMax - cancelButton.contentWidth * .25
	cancelButton.y=backgroundImage.contentBounds.yMin + cancelButton.contentHeight * .25
	componentsGroup:insert(cancelButton)
	
	local logInButton = widget.newButton{
	    id = "logInButton",		
	    default="images/btn-submit-login-up-iPad.png",
		over="images/btn-submit-login-down-iPad.png",	
		onEvent = onButtonEvent
	}
	logInButton.x=Utils.screenWidth * .5
	logInButton.y=usernameField.contentBounds.yMax + logInButton.contentHeight
	componentsGroup:insert(logInButton);  
end
 
 
-- Called when scene is about to move offscreen:
function scene:exitScene( event )
        local group = self.view
        
        -----------------------------------------------------------------------------
        
        --      INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
        
        -----------------------------------------------------------------------------
        usernameField:removeSelf();
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
        local overlay_scene = event.sceneName  -- overlay scene name
        
        -----------------------------------------------------------------------------
                
        --      This event requires build 2012.797 or later.
        
        -----------------------------------------------------------------------------
        
end
 
-- Called if/when overlay scene is hidden/removed via storyboard.hideOverlay()
function scene:overlayEnded( event )
        local group = self.view
        local overlay_scene = event.sceneName  -- overlay scene name
 
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
