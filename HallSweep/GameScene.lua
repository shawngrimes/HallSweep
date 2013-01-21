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
		
		--Show physics drawing lines, for help with debugging
		--physics.setDrawMode( "hybrid" )
		
		--Start Physics
		physics.start()
		physics.setGravity( 0,20 )
		
		--create the floor physics object so we don't fall through
		local ground = display.newRect(-display.contentWidth * .5, display.contentHeight-10, display.contentWidth * 2.0, 10)
		group:insert(ground)
			ground.myName="ground"
			ground:setFillColor( 255, 0, 0 )
			ground.isVisible = false  -- optional
			physics.addBody( ground, "static", { friction=1.0, bounce=0.3, filter={ categoryBits = 3, maskBits = 65535 }})
			
		--create the ceiling so we don't end up in space
		local ceiling = display.newRect(-display.contentWidth * .5,0,display.contentWidth*2,10)
			group:insert(ceiling)
			ceiling.myName="ceiling"
			ceiling:setFillColor( 255, 0, 0 )
			ceiling.isVisible = false  -- optional
			physics.addBody( ceiling, "static", { friction=1.0, bounce=0.3, filter={ categoryBits = 3, maskBits = 65535 }})
		
		
		
		
		local PatriotMachine=require("Patriot")
		local Patriot=PatriotMachine.new()

		group:insert(Patriot)
		
		--We are creating an anchor point so the mouse can only move up and down
		local pistonGroundPoint=display.newRect(0,display.contentHeight,Patriot.contentWidth,Patriot.contentHeight)
		group:insert(pistonGroundPoint)
		pistonGroundPoint.myName="pistonGround"
		pistonGroundPoint:setFillColor( 0, 255, 0 )
		pistonGroundPoint.isVisible = false  -- optional
		pistonGroundPoint.x=Patriot.x
		physics.addBody( pistonGroundPoint, "static", { friction=0.5, bounce=0.3 })
		
		--Now we connect the mouse to the piston point
		myPistonJoint = physics.newJoint( "piston", Patriot.patriotBody, pistonGroundPoint, Patriot.x,Patriot.y, 0,-display.contentHeight )
		
		
		
		local onGameOver=function()
			--[[
			print("First onGameOver: Num Objects in Group: "..tostring(group.numChildren))
			Runtime:removeEventListener( "SignalGameOver", onGameOver )
			print("Creating gameOverText")
		    local gameOverText=display.newText("Game Over",0,0,native.systemFontBold,128)
		    print("gameOverText: "..gameOverText.text)
		    print("onGameOver: Num Objects in Group: "..tostring(group.numChildren))
		    group:insert(gameOverText)
		    
		    gameOverText.x=display.contentCenterX
		    gameOverText.y=display.contentCenterY
		    ]]
		    
		    local changeScene=function()
		    	storyboard.gotoScene("GameOverScene","fade",1000)
		    end
		    
		    timer.performWithDelay(2000,changeScene)

		end

		local BackgroundGenerator=require("BackgroundGenerator")
		local backgroundGroup, foregroundGroup=BackgroundGenerator:generateBackground()
		
		group:insert(backgroundGroup)
		group:insert(foregroundGroup)
		
		--group:insert(BackgroundGenerator.foregroundGroup)
		
		
		local Bully=require("Bully")
		group:insert(Bully.new())
		
		local OfficerRay=require("OfficerRay")
		group:insert(OfficerRay.new())
		
		local Spitball=require("Spitball")
		group:insert(Spitball.new())
		
		backgroundGroup:toBack()
		foregroundGroup:toFront()
		
		
		group:insert(letterboxBorder({r=0,g=0,b=0}))
		
		print("Create Scene: Num Objects in Group: "..tostring(group.numChildren))
	
		Runtime:addEventListener( "SignalGameOver", onGameOver )
		
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
		announcementMusicObject = audio.loadStream("HallSweepAnnouncement.mp3")
		audio.play(announcementMusicObject)
		
		local getToClassLabel=display.newText("You Better Hurry To Class!", 0,0, native.systemFontBold,48)
		group:insert(getToClassLabel)
		getToClassLabel.x=display.contentWidth/2
		getToClassLabel:setTextColor(0,0,255)
		
		local coinlabel=display.newText("0 coins",0,0, native.systemFontBold,72)
		group:insert(coinlabel)
		coinlabel.x=display.contentWidth - coinlabel.contentWidth
		coinlabel.y=display.contentHeight - coinlabel.contentHeight

	    local function removeGetToClassLabel(event)
	        getToClassLabel:removeSelf()
	    end
	
	    timer.performWithDelay(2000, removeGetToClassLabel);
 

        -----------------------------------------------------------------------------

        --      INSERT code here (e.g. start timers, load audio, start listeners, etc.)

        -----------------------------------------------------------------------------

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
        local group = self.view
        
		physics.stop()
end


-- Called AFTER scene has finished moving offscreen:
function scene:didExitScene( event )
        local group = self.view
        
        storyboard.removeScene( "GameScene" )
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
