
----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------
 
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local FontNameToUse="DefaultFont"
local backgroundImage

local usernameField
local passwordField
local confirmPasswordField
local emailField
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
 
-- Called when the scene's view does not exist:
function scene:createScene( event )
   local group = self.view

	local usernameField
   local passwordField
   local confirmPasswordField
   local emailField
   local mismatchLabel

   local background=display.newRect(group, 0,0,display.contentWidth,display.contentHeight);
   background:setFillColor(0,0,0);
   background:setStrokeColor(255,255,255);
   background.alpha=0.5
   
   backgroundImage=display.newImageRect("images/login-iPad.png",622,652)
   backgroundImage.x=Utils.screenWidth * .5
   backgroundImage.y=Utils.screenHeight * .5
   group:insert(backgroundImage)
 
 	
	
	
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
        local componentsGroup=display.newGroup();
 	group:insert(componentsGroup)
 
	local function onUsername( event )
    	if ( "began" == event.phase ) then
    		print("text: "..event.target.text)
    		if(event.target.text=="Username...") then
				event.target.text = ""
			end
	        -- Note: this is the "keyboard appearing" event
	        -- In some cases you may want to adjust the interface while the keyboard is open.
		elseif ("ended" == event.phase) then
			if(event.target.text=="") then
				event.target.text="Username..."
			end
	    elseif ( "submitted" == event.phase ) then
	        -- Automatically tab to password field if user clicks "Return" on iPhone keyboard (convenient!)
	        native.setKeyboardFocus( passwordField )
	    end
	end
	
	local function onPassword( event )
		if(event.phase=="began") then
			if(passwordField.isSecure==false) then
				passwordField.isSecure = true
				native.setKeyboardFocus( passwordField )
			end
			if(passwordField.text=="Password...") then
				passwordField.text = ""
			end
		elseif(event.phase=="ended") then
			if(passwordField.text=="") then
				if(passwordField.isSecure==true) then
					passwordField.isSecure = false
					passwordField.text="Password..."
				end
			else
				passwordField.isSecure=true;
			end
			if(confirmPasswordField.text~="Confirm Password...") then
				if(confirmPasswordField.text~=passwordField.text) then
					mismatchLabel.isVisible=true
				else
					mismatchLabel.isVisible=false
				end
			end
		end
	    -- Hide keyboard when the user clicks "Return" in this field
	    if ( "submitted" == event.phase ) then
	        native.setKeyboardFocus( confirmPasswordField )
	    end
	end
	
	local function onConfirmPassword(event)
		print("Phase: "..event.phase)
		if(event.phase=="began") then
			if(event.target.isSecure==false) then
				event.target.isSecure = true
				native.setKeyboardFocus( event.target )
			end
			if(event.target.text=="Confirm Password...") then
				event.target.text = ""
			end
		elseif(event.phase=="editing") then
			if(event.target.text~=passwordField.text) then
				mismatchLabel.isVisible=true
			else
				mismatchLabel.isVisible=false
			end
		elseif(event.phase=="ended") then
			if(event.target.text=="") then
				if(event.target.isSecure==true) then
					event.target.isSecure = false
					event.target.text="Confirm Password..."
				end
			else
				passwordField.isSecure=true;
			end
			if(event.target.text~=passwordField.text) then
				mismatchLabel.isVisible=true
			else
				mismatchLabel.isVisible=false
			end
		end
	    -- Hide keyboard when the user clicks "Return" in this field
	    if ( "submitted" == event.phase ) then
	        native.setKeyboardFocus( emailField )
	    end
	
	end
	
	local function onEmail(event)
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
	usernameField.font = textFieldFont
	usernameField.text = "Username..."
	usernameField:setTextColor( 198,198,198, 255 )
	usernameField:addEventListener('userInput', onUsername);
	componentsGroup:insert(usernameField);

	passwordField=native.newTextField(10,150,Utils.screenWidth * .5,Utils.screenHeight * .05);
	passwordField:addEventListener('userInput', onPassword);
	passwordField.x=display.contentCenterX
	passwordField.y=usernameField.y + usernameField.contentHeight + passwordField.contentHeight * .5
	passwordField.font = textFieldFont
	passwordField.text = "Password..."
	passwordField.isSecure = false
	passwordField:setTextColor( 198,198,198, 255 )
	componentsGroup:insert(passwordField);
	
	confirmPasswordField=native.newTextField(10,150,Utils.screenWidth * .5,Utils.screenHeight * .05);
	confirmPasswordField:addEventListener('userInput', onConfirmPassword);
	confirmPasswordField.x=display.contentCenterX
	confirmPasswordField.y=passwordField.y + passwordField.contentHeight + confirmPasswordField.contentHeight * .5
	confirmPasswordField.font = textFieldFont
	confirmPasswordField.text = "Confirm Password..."
	confirmPasswordField.isSecure = false
	confirmPasswordField:setTextColor( 198,198,198, 255 )
	componentsGroup:insert(confirmPasswordField);
	
	emailField=native.newTextField(10,150,Utils.screenWidth * .5,Utils.screenHeight * .05);
	emailField:addEventListener('userInput', onEmail);
	emailField.x=display.contentCenterX
	emailField.y=confirmPasswordField.y + confirmPasswordField.contentHeight + emailField.contentHeight * .5
	emailField.font = textFieldFont
	emailField.text = "Email..."
	emailField:setTextColor( 198,198,198, 255 )
	componentsGroup:insert(emailField);
	
	local onButtonEvent = function (event )
    	if event.phase == "release" then
	        print( "You pressed and released a button!" )
	        if(event.target.id == "signUpButton") then
	        	if(usernameField.text~="") then
	        		if(passwordField.text~="") then
	        			if(confirmPasswordField.text==passwordField.text) then
	        				if(emailField.text~="") then
	        					highScores:registerUser(usernameField.text,passwordField.text,emailField.text);
	        				else
	        					local alert = native.showAlert( "Error", "Email can not be blank.  This is only used to reset your password.  We will never spam you.", { "OK"} )
	        				end
	        			
	        			else
	        				local alert = native.showAlert( "Error", "Passwords do not match.", { "OK"} )
	        			end
	        		
	        		else
	        			local alert = native.showAlert( "Error", "Password can not be blank.", { "OK"} )
	        		end
	        	
	        	else
	        		local alert = native.showAlert( "Error", "Username can not be blank.", { "OK"} )
	        	end
	        elseif(event.target.id == "cancelButton") then
				storyboard.hideOverlay("slideDown")
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
	
	local orScale
		orScale = .75
	
	mismatchLabel=TextCandy.CreateText({
			fontName= FontNameToUse,
			text= "X",
			originX = "LEFT",
			originY= "TOP",
			showOrigin=false,
		});	
	mismatchLabel:scale(orScale,orScale);
	mismatchLabel:setColor(198,0,0)
	mismatchLabel.x=confirmPasswordField.contentBounds.xMax
	mismatchLabel.y=confirmPasswordField.contentBounds.yMin
	mismatchLabel.isVisible=false
	componentsGroup:insert(mismatchLabel);
		
	local signUpButton = widget.newButton{
	    id = "signUpButton",	
	    default="images/btn-signup-up-iPad.png",
		over="images/btn-signup-down-iPad.png",	
	    onEvent = onButtonEvent
	}
	signUpButton.x = Utils.screenWidth * .5
	signUpButton.y=emailField.y + emailField.contentHeight + signUpButton.contentHeight
	componentsGroup:insert(signUpButton);
	
end
 
 
-- Called when scene is about to move offscreen:
function scene:exitScene( event )
        local group = self.view
        
        -----------------------------------------------------------------------------
        
        --      INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
        
        -----------------------------------------------------------------------------
        
        
        usernameField:removeSelf()
		passwordField:removeSelf()
		confirmPasswordField:removeSelf()
		emailField:removeSelf()
        
        
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
