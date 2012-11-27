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
		
--		local highscoresObject=display.newText("High Scores",0,0,native.systemFontBold,96)
local highscoresObject=display.newImage("images/header-scores@2x.png")
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
 default="images/btn-playagain-up@2x.png",
 --this is the image to use when the button is pressed
 over="images/btn-playagain-down@2x.png",
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
 default="images/btn-menu-up@2x.png",
 --this is the image to use when the button is pressed
 over="images/btn-menu-down@2x.png",
 --this tells it what function to call when you press the button
  onEvent = onButtonEvent
}
		group:insert(mainMenuButton)
mainMenuButton.x = display.contentCenterX
mainMenuButton.y = playAgainButton.y - playAgainButton.contentHeight

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

local myImage = display.newImageRect("images/background1@2x.png",960,640)
myImage.x=display.contentCenterX
myImage.y=display.contentCenterY
		group:insert(myImage)
myImage:toBack()

local myImageMouse = display.newImage( "images/rocketmouse_4_run@2x.png" )
group:insert(myImageMouse)

myImageMouse:setReferencePoint(display.BottomLeftReferencePoint)
--Change the reference point of the object

myImageMouse.x=0
--This will add a buffer of half the objects width, if you want it flush with the
--left, change it to myObject.x=0

myImageMouse.y=display.contentHeight 
--This will add a buffer of half the object's height, if you want it flush
--bottom, change it to myObject.y=display.contentHeight

		
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