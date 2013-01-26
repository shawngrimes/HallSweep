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
local textFieldFont
local usernameField
local passwordField
local backgroundImage
local widget = require "widget";
 
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
 	
 	
		
	
	
--	local usernameLabel=display.newText("Username:",10,30,native.systemFontBold,48);
--	usernameLabel.x=display.contentCenterX
--	componentsGroup:insert(usernameLabel);

	--[[
	local usernameField=WCandy.NewInput(
	{
	height			= "200",
	width           = "50%",
	theme           = "theme_1",
	name            = "MyWidget",
	caption         = "Username...",
	notEmpty        = true,
	textColor       = {198,198,198},
	inputType       = "default", -- "number" | "password" | "default"
	allowedChars    = "ABCabc1234567890.!?",
	quitCaption     = "Tap screen to finish text input.",
	onChange        = function(EventData) print(EventData.value) end,
	onBlur          = function(EventData) print(EventData.value) end,
	} )
	usernameField.x=backgroundImage.contentBounds.xMin + backgroundImage.contentWidth * .5 - usernameField.contentWidth * .5
	usernameField.y=backgroundImage.contentBounds.yMin + usernameField.contentHeight + usernameField.contentHeight * .5
	componentsGroup:insert(usernameField);
	]]
	
	
	

		
			
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
    --[[
    if(Utils.isIPadRetina()) then
    	textFieldFont = native.newFont( "HVD Comic Serif Pro", 24 )
    elseif(Utils.isIPad()) then
		textFieldFont = native.newFont( "HVD Comic Serif Pro", 16 )
	elseif(Utils.isIPhoneRetina()) then
		if(Utils.isTall) then
			textFieldFont = native.newFont( "HVD Comic Serif Pro", 14 )
		else
			textFieldFont = native.newFont( "HVD Comic Serif Pro", 12 )
		end
	elseif(Utils.isIPhone()) then
		textFieldFont = native.newFont( "HVD Comic Serif Pro", 12 )
	end
	]]
    textFieldFont = native.newFont( "HVD Comic Serif Pro", 16/display.contentScaleY )
    
	function onUsername( event )
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
	
	function onPassword( event )
		print("Here: "..event.phase)
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
			end
		end
	    -- Hide keyboard when the user clicks "Return" in this field
	    if ( "submitted" == event.phase ) then
	        native.setKeyboardFocus( nil )
	    end
	end
	
	usernameField=native.newTextField(10,30,Utils.screenWidth * .5,Utils.screenHeight * .05);
	usernameField.x=display.contentCenterX
	usernameField.y=backgroundImage.contentBounds.yMin + usernameField.contentHeight * 3
	usernameField.font=textFieldFont
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

	local onButtonEvent = function (event )
    	if event.phase == "release" then
	        print( "You pressed and released a button!" )
	        if(event.target.id == "logInButton") then
	        	print("Trying to authenticate");
	        	highScores:loginUser(usernameField.text, passwordField.text)
	        elseif(event.target.id == "forgotPasswordButton") then
	        		usernameField:removeSelf()
					passwordField:removeSelf()
	        	    local options={
						effect="slideDown",
						time=500,
						isModal=true
						}
					storyboard.showOverlay( "utils.ForgotPasswordScene", options);
	
	        elseif(event.target.id == "signUpButton") then
	        	--storyboard.hideOverlay("slideDown")
	        	usernameField:removeSelf()
				passwordField:removeSelf()
	        	local options={
					effect="slideDown",
					time=500,
					isModal=true
					}
				storyboard.showOverlay( "utils.SignUpScene", options);
				print("transition to sign up scene");
			elseif(event.target.id=="facebookButton") then
				-- listener for "fbconnect" events
				local function FBlistener( event )
				    if ( "session" == event.type ) then
				        -- upon successful login, request list of friends of the signed in user
				        if ( "login" == event.phase ) then
				        	print("FB Access Token: "..event.token)
				        	
				            facebook.request( "me" )
				
				            -- Fetch access token for use in Facebook's API
				            fb_access_token = event.token
				            fb_expire=event.expiration
				        end
				    elseif ( "request" == event.type ) then
				        -- event.response is a JSON object from the FB server
				        local response = event.response
				
				        -- if request succeeds, create a scrolling list of friend names
				        if ( not event.isError ) then
				            response = json.decode( event.response )
							print("FB Request Response: "..event.response)
							print("Username: "..response["username"])
							print("Access_token: "..fb_access_token)
							--local tempDate = 
							--yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
							--local newFBExpire=tempDate.year.."-"..tempDate.month.."-"..tempDate.day.."T"..tempDate.hour..":"..tempDate.min..":"..tempDate.sec..".000Z"
							local newFBExpire=os.date("%Y-%m-%dT%H:%M:%s.000Z", fb_expire)
							print("FB_Expire: "..newFBExpire)
							--registerWithFacebook(facebookID,access_token,expiration_date,fb_username)
							highScores:registerWithFacebook(response["id"],fb_access_token,newFBExpire,response["username"])
				        end
				    elseif ( "dialog" == event.type ) then
				        print( "dialog", event.response )
				    end
				end

			
			
				facebook.login( FBAppID, FBlistener, {} )
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
	    default="images/btn-login-up-iPad.png",
		over="images/btn-login-down-iPad.png",	
		onEvent = onButtonEvent
	}
	logInButton.x=Utils.screenWidth * .5
	logInButton.y=passwordField.y + passwordField.contentHeight * .5 + logInButton.contentHeight
	componentsGroup:insert(logInButton);
	
	local orScale
	orScale = .75
	--[[
	local orLabel=TextCandy.CreateText({
			fontName= FontNameToUse,
			text= "OR",
			originX = "CENTER",
			originY= "CENTER",
			showOrigin=false,
		});	
	orLabel:scale(orScale,orScale);
	orLabel:setColor(198,198,198)
	orLabel.x=Utils.screenWidth * .5
	orLabel.y=logInButton.contentBounds.yMax + orLabel.contentHeight
	componentsGroup:insert(orLabel);
	
	local facebookButton = widget.newButton{
	    id = "facebookButton",	
	    default=Utils.getImageNameWithSuffix("btn-facebook-signin-up.png"),
		over=Utils.getImageNameWithSuffix("btn-facebook-signin-down.png"),	
	    onEvent = onButtonEvent
	}
	facebookButton.x = Utils.screenWidth * .5
	facebookButton.y=orLabel.contentBounds.yMax + facebookButton.contentHeight * .75
	componentsGroup:insert(facebookButton);
	]]--
	
	local signUpButton = widget.newButton{
	    id = "signUpButton",	
	    default="images/btn-signup-up-iPad.png",
		over="images/btn-signup-down-iPad.png",	
	    onEvent = onButtonEvent
	}
	signUpButton.x = Utils.screenWidth * .5
	--signUpButton.y=facebookButton.contentBounds.yMax + signUpButton.contentHeight * .75
	signUpButton.y=logInButton.contentBounds.yMax + signUpButton.contentHeight * .75
	componentsGroup:insert(signUpButton);
	
	local forgotScale
	--if(Utils.isIPadRetina()) then
		forgotScale = .5
	--elseif(Utils.isIPad()) then
	--	forgotScale = .5
	--elseif(Utils.isIPhoneRetina()) then
	--	forgotScale = .4
	--elseif(Utils.isIPhone()) then
	--	forgotScale = .2
	--end
	
	local forgotPasswordLabel=TextCandy.CreateText({
			fontName= FontNameToUse,
			text= "Forgot Your Password?",
			originX = "CENTER",
			originY= "CENTER",
			showOrigin=false,
		});	
		forgotPasswordLabel.id="forgotPasswordButton";
		forgotPasswordLabel:scale(forgotScale,forgotScale);
		forgotPasswordLabel:setColor(198,198,198)
		forgotPasswordLabel.x=Utils.screenWidth * .5
		forgotPasswordLabel.y=signUpButton.contentBounds.yMax  + forgotPasswordLabel.contentHeight * 1.5
		componentsGroup:insert(forgotPasswordLabel);

	local forgotPasswordButton = widget.newButton{
	    id = "forgotPasswordButton",
	    height=forgotPasswordLabel.contentHeight * 1.5,
	    width=forgotPasswordLabel.contentWidth,
	    defaultColor={0,0,0,0},
		overColor={0,0,0,0},
		strokeColor={ 0, 0, 0, 0 },
	    onEvent = onButtonEvent
	}
	forgotPasswordButton.x = Utils.screenWidth * .5
	forgotPasswordButton.y=forgotPasswordLabel.y
	componentsGroup:insert(forgotPasswordButton);

        
end
 
 
-- Called when scene is about to move offscreen:
function scene:exitScene( event )
        local group = self.view
        
        -----------------------------------------------------------------------------
        
        --      INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
        
        -----------------------------------------------------------------------------
        --[[
        if(usernameField~=nil) then
        	usernameField:removeSelf()
        	usernameField=nil
       	end
       	if(passwordField~=nil) then
			passwordField:removeSelf()
			passwordField=nil
		end
		]]

end
 
-- Called AFTER scene has finished moving offscreen:
function scene:didExitScene( event )
        local group = self.view
        
        -----------------------------------------------------------------------------
                
        --      This event requires build 2012.782 or later.
        
        -----------------------------------------------------------------------------
        storyboard.purgeScene( "SignUpScene" )
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
        print("Showing Overlay: "..overlay_scene)
 
        -----------------------------------------------------------------------------
                
        --      This event requires build 2012.797 or later.
        
        -----------------------------------------------------------------------------
      
    usernameField=native.newTextField(10,30,Utils.screenWidth * .5,Utils.screenHeight * .05);
	usernameField.x=display.contentCenterX
	usernameField.y=backgroundImage.contentBounds.yMin + usernameField.contentHeight * 1.75
	usernameField.font=textFieldFont
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
