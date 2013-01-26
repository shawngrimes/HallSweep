-- require controller module
local storyboard = require "storyboard"

analytics = require "analytics"
if("iPhone OS" == system.getInfo( "platformName" )) then
    -- initialize with proper API key corresponding to your application
	analytics.init( "3JV3N2N6HQ7DSR2WDRR7" )
elseif("Android" == system.getInfo( "platformName" )) then
	-- initialize with proper API key corresponding to your application
	analytics.init( "ZKSX7FHR9DZ6ZH233ZGW" )
end

require "sqlite3"
settings = require("settings")
settings:init()

TextCandy=require("lib_text_candy");
TextCandy.AddCharsetFromGlyphDesigner("DefaultFont","ComicSerifFont")


Utils=require("utils.Helpers")

GGData = require("utils.GGData");
userBox=GGData:new("scores","boxes");

highScores=require("utils.HighScores");


if(userBox:get( "maxHighScore")==nil) then
    print("Max high Scores are nil")
--	userBox:set( "maxHighScore",{});
	userBox.maxHighScore={}
end

if(userBox:get( "promptToSubmitScore")==nil) then
	userBox.promptToSubmitScore=true
end


if(userBox:get( "leaderboards")==nil) then
	print("Leaderboards are nil")
	--userBox:set( "Leaderboards",{});
	userBox.leaderboards={};
end

LEADERBOARD_IDS={standardMode="12HLXkc2O1",}

if(userBox:get( "authToken" ) ~= nil) then
    print("Setting authToken: "..userBox:get( "authToken" ))
	highScores:setAuthToken(userBox.authToken);
else
	print("user auth token is nil.")
end
userBox:save();

if(highScores:isLoggedIn()) then
    --highScores:logOut()
	print("You are logged in as: ",userBox.userObjectID);
else
	--print("You are NOT logged in");
end

highScores:getHighScores();

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
 

require("utils.LetterBoxBoarder")

--local newBox=display.newRect(0,0,50,display.contentHeight)
