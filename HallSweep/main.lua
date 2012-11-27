-- require controller module
local storyboard = require "storyboard"

Utils=require("utils.Helpers")

--backgroundMusicObject = audio.loadStream("backgroundMusic.caf")
--audio.play(backgroundMusicObject)

display.setStatusBar(display.HiddenStatusBar)

titleBackgroundMusicObject = audio.loadStream("TitleTrack.mp3")

backgroundMusicChannel=audio.play(titleBackgroundMusicObject, {loops=-1})
audio.stop(backgroundMusicChannel)

gameBackgroundMusicObject = audio.loadStream("GameBackgroundMusic.mp3")
gameBackgroundMusicChannel=audio.play(gameBackgroundMusicObject, {loops=-1})
audio.stop(gameBackgroundMusicChannel)

physics = require "physics"
scaleFactor = 1.0
physicsData = (require "PatriotPhysics").physicsData(scaleFactor)

--backgroundMusicChannel=audio.play(titleBackgroundMusicObject, {loops=-1})

-- load first scene
storyboard.gotoScene( "MainMenuScene", "fade", 200 )
--storyboard.gotoScene( "HighScores", "fade", 200 )


require("utils.letterBoxBoarder")

--local newBox=display.newRect(0,0,50,display.contentHeight)
