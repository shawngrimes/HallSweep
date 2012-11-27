-------------------------------------------------
--
-- gameminion.lua
--
-- Official Game Minion Corona SDK Library
--
-- Author: Ali Hamidi, Game Minion
--
-------------------------------------------------

--[[

Copyright (C) 2012 Ali Hamidi. All Rights Reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in the
Software without restriction, including without limitation the rights to use, copy,
modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
and to permit persons to whom the Software is furnished to do so, subject to the
following conditions:

The above copyright notice and this permission notice shall be included in all copies
or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

]]--


local gameminion = {}
local gameminion_mt = { __index = gameminion }	-- metatable

-------------------------------------------------
-- HELPERS
-------------------------------------------------

local GM_URL = "api.gameminion.com"
local GM_ACCESS_KEY = ""
local GM_SECRET_KEY = ""
local authToken = ""

-------------------------------------------------
-- IMPORTS
-------------------------------------------------

local json = require("json")

-------------------------------------------------
-- PRIVATE FUNCTIONS
-------------------------------------------------


-- encoding
function b64enc(data)
    -- character table string
	local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

    return ((data:gsub('.', function(x) 
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end

-- decoding
function b64dec(data)
	-- character table string
	local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
        return string.char(c)
    end))
end

local function createBasicAuthHeader(username, password)
	-- header format is "Basic <base64 encoded username:password>"
	local header = "Basic "

	local authDetails = b64enc(username..":"..password)

	header = header..authDetails

	return header
end

local function postGM(path, parameters, networkListener)
	-- POST call to GM
	if (not parameters) then
		parameters = ""
	end

	local params ={}

	params.body = parameters

	local authHeader = createBasicAuthHeader(GM_ACCESS_KEY, GM_SECRET_KEY)

	local headers = {}
	headers["Authorization"] = authHeader

	params.headers = headers

	local url = "https://"..GM_URL

	print("\n----------------")
	print("-- POST Call ---")
	print("Post URL: "..url)
	print("Post Path: "..path)
	print("Post Parameters: "..parameters)
	print("----------------")

	local hReq = url.."/"..path
	print("\nPost Request: "..hReq)
	network.request(hReq, "POST", networkListener, params)
end

local function getGM(path, parameters, networkListener)
	-- GET call to GM
	local params ={}

	--params.body = parameters

	local authHeader = createBasicAuthHeader(GM_ACCESS_KEY, GM_SECRET_KEY)

	local headers = {}
	headers["Authorization"] = authHeader

	params.headers = headers

	local url = "https://"..GM_URL

	print("\n----------------")
	print("-- GET Call ---")
	print("Get URL: "..url)
	print("Get Path: "..path)
	print("Get Parameters: "..parameters)
	print("----------------")

	local hReq = url.."/"..path.."?"..parameters

	print("\nGet Request: "..hReq)
	network.request(hReq, "GET", networkListener, params)
end

local function putGM(path, parameters, networkListener)
	-- PUT call to GM

	local params = {}


	local authHeader = createBasicAuthHeader(GM_ACCESS_KEY, GM_SECRET_KEY)

	local headers = {}
	headers["Authorization"] = authHeader

	params.headers = headers
	params.body = putData --MH

	local url = "https://"..GM_URL

	print("\n----------------")
	print("-- PUT Call ---")
	print("Put URL: "..url)
	print("Put Path: "..path)
	print("Put Parameters: "..parameters)
	print("----------------")

	local hReq = url.."/"..path.."?"..parameters

	print("\nPut Request: "..hReq)
	network.request(hReq, "PUT", networkListener, params)
end

local function deleteGM(path, parameters, networkListener)
	-- Delete call to GM

	local params = {}


	local authHeader = createBasicAuthHeader(GM_ACCESS_KEY, GM_SECRET_KEY)

	local headers = {}
	headers["Authorization"] = authHeader

	params.headers = headers

	local url = "https://"..GM_URL

	print("\n----------------")
	print("-- DELETE Call ---")
	print("Delete URL: "..url)
	print("Delete Path: "..path)
	print("Delete Parameters: "..parameters)
	print("----------------")

	local hReq = url.."/"..path.."?"..parameters

	print("\nDelete Request: "..hReq)
	network.request(hReq, "DELETE", networkListener, params)
end


-------------------------------------------------
-- PUBLIC FUNCTIONS
-------------------------------------------------

function gameminion.init(accessKey, secretKey)	-- constructor
	-- initialize GM connection

	GM_ACCESS_KEY = accessKey
	GM_SECRET_KEY = secretKey
	
	local newGameminion = {
		authToken = authToken,
		accessKey = GM_ACCESS_KEY,
		secretKey = GM_SECRET_KEY,
		gameminion = gameminion
	}
	
	return setmetatable( newGameminion, gameminion_mt )
end

-------------------------------------------------
-- User
-------------------------------------------------

function gameminion:loginWeb()
	local authToken

	return authToken
end

-------------------------------------------------

function gameminion:loginAPI(username, password)
	local params = "login="..username.."&password="..password

	local path = "user_sessions/user_login.json"

	-- set AuthToken when it gets it
	local function networkListener(event)
		local response = json.decode(event.response)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else

			if (response.auth_token) then
				self.authToken = response.auth_token
				print("User Logged In!")
				print("Auth Token: "..self.authToken)
				Runtime:dispatchEvent({name="LoggedIn"})
				return true
			else
				print("Login Error: "..event.response)
				Runtime:dispatchEvent({name="LoginError", errorMsg=response.errors[1]})
			end
		end
	end

	postGM(path, params, networkListener)

	return true
end

-------------------------------------------------

function gameminion:loginFacebook(facebookID, accessToken)
	local params = "facebook_id="..facebookID.."&access_token="..accessToken

	local path = "facebook_login.json"

	-- set AuthToken when it gets it
	local function networkListener(event)
		local response = json.decode(event.response)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else

			if (response.auth_token) then
				self.authToken = response.auth_token
				print("User Logged In!")
				print("Auth Token: "..self.authToken)
				Runtime:dispatchEvent({name="LoggedIn"})
				return true
			else
				print("Login Error: "..event.response)
				Runtime:dispatchEvent({name="LoginError", errorMsg=response.errors[1]})
			end
		end
	end

	postGM(path, params, networkListener)

	return true
end

-------------------------------------------------

function gameminion:isLoggedIn()
	
	if (self.authToken == "" ) then
		print("GM: User not logged in!")
		return false
	else
		print("GM: User is logged in!")
		return true
	end
end

-------------------------------------------------

function gameminion:getAuthToken()
	return self.authToken
end

-------------------------------------------------

function gameminion:setAuthToken(authToken)
	self.authToken = authToken
end

-------------------------------------------------

function gameminion:getMyProfile()
	local params = "auth_token="..self.authToken

	local path = "my_profile.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("User Profile: "..event.response)
			local response = json.decode(event.response)
			Runtime:dispatchEvent({name="MyProfile", results=response})
		end
	end

	getGM(path, params, networkListener)
end


function gameminion:updateMyProfile(userName,firstName,lastName,passWord,profilePicture,facebookID,facebookEnabled,facebookAccessToken,twitterEnabled,twitterEnabledToken)
	local params = "auth_token="..self.authToken
	
	if userName ~= nil then params = params.."&username="..userName end
	if firstName ~= nil then params = params.."&first_name="..firstName end
	if lastName ~= nil then params = params.."&last_name="..lastName end
	if passWord ~= nil then params = params.."&password="..passWord end
	if profilePicture ~= nil then params = params.."&profile_picture="..profilePicture end
	if facebookID ~= nil then params = params.."&facebook_id="..facebookID end
	if facebookEnabled ~= nil then params = params.."&facebook_enabled="..facebookEnabled end
	if facebookAccessToken ~= nil then params = params.."&facebook_access_token="..facebookAccessToken end
	if twitterEnabled ~= nil then params = params.."&twitter_enabled="..twitterEnabled end
	if twitterEnabledToken ~= nil then params = params.."&twitter_enabled_token="..twitterEnabledToken end
	
	local path = "my_profile.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("My Profile Updated: "..event.response)
			local response = json.decode(event.response)
			Runtime:dispatchEvent({name="MyProfileUpdated", results=response})
		end
	end

	putGM(path, params, networkListener)

end

-------------------------------------------------

function gameminion:registerDevice(deviceToken)
	-- detect current device and populate platform
	local curDevice = system.getInfo("model")
	local platform

	if curDevice == "iPhone" or "iPad" then
		print("Current Device is: "..curDevice)
		platform = "iOS"
	else
		-- Not iOS so much be Android
		print("Current Device is: "..curDevice)
		platform = "Android"
	end

	local params = "auth_token="..self.authToken
	params = params.."&device_id="..deviceToken
	params = params.."&platform="..platform

	local path = "devices.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Device Registered: "..event.response)
			local response = json.decode(event.response)
			Runtime:dispatchEvent({name="DeviceRegistered", results=response})
		end
	end

	postGM(path, params, networkListener)
end

-------------------------------------------------

function gameminion:registerUser(firstName, lastName, username, email, password)
	local params = "auth_token="..self.authToken
	params = params.."&username="..username
	params = params.."&first_name="..firstName
	params = params.."&last_name="..lastName
	params = params.."&email="..email
	params = params.."&password="..password

	local path = "users.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("User Registered: "..event.response)
			local response = json.decode(event.response)
			Runtime:dispatchEvent({name="UserRegistered", results=response})
		end
	end

	postGM(path, params, networkListener)

end

-------------------------------------------------

function gameminion:recoverPassword(email)
	local params = "email="..email

	local path = "users/forgot.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Password Recovery Initiated: "..event.response)
			local response = json.decode(event.response)
			Runtime:dispatchEvent({name="PasswordRecovery", results=response})
		end
	end

	postGM(path, params, networkListener)

end

-------------------------------------------------
-- Leaderboards
-------------------------------------------------

function gameminion:getLeaderboards()
	local params = "auth_token="..self.authToken

	local path = "leaderboards.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Leaderboards"..event.response)
			local response = json.decode(event.response)
			Runtime:dispatchEvent({name="Leaderboards", type="AllLeaderboards", results=response})
		end
	end

	getGM(path, params, networkListener)
end

-------------------------------------------------

function gameminion:getLeaderboardScores(leaderboard)
	local params = "auth_token="..self.authToken

	local path = "leaderboards/"..leaderboard.."/scores.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Leaderboard Details: "..event.response)
			local response = json.decode(event.response)
			Runtime:dispatchEvent({name="Leaderboards", type="GetScores",results=response})
		end
	end

	getGM(path, params, networkListener)
end

-------------------------------------------------
function gameminion:submitHighScore(leaderboard, score)
	local params = "auth_token="..self.authToken
	params = params.."&value="..score

	local path = "leaderboards/"..leaderboard.."/scores.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Leaderboard Details: "..event.response)
			Runtime:dispatchEvent({name="Leaderboards", type="ScoreSubmitted"})
		end
	end

	postGM(path, params, networkListener)
end

-------------------------------------------------
-- Achievements
-------------------------------------------------

function gameminion:getAllAchievements()
	local params = "auth_token="..self.authToken

	local path = "achievements.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Achievements: "..event.response)
			local response = json.decode(event.response)
			Runtime:dispatchEvent({name="Achievements", type="AllAchievements", results=response})
		end
	end

	getGM(path, params, networkListener)
end

-------------------------------------------------

function gameminion:getStatusOfAchievement(achievementID)
	local params = "auth_token="..self.authToken

	local path = "achievements/"..achievementID..".json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Achievement: "..event.response)
			local response = json.decode(event.response)
			Runtime:dispatchEvent({name="Achievements", type="AchievementStatus", results=response})
		end
	end

	getGM(path, params, networkListener)
end

-------------------------------------------------

function gameminion:getMyUnlockedAchievements(userID)
	local params = "auth_token="..self.authToken

	local path = "achievements/user/"..userID..".json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Achievement: "..event.response)
			local response = json.decode(event.response)
			Runtime:dispatchEvent({name="Achievements", type="UnlockedAchievements", results=response})
		end
	end

	getGM(path, params, networkListener)
end

-------------------------------------------------

function gameminion:unlockAchievement(achievementID, progress)
	local params = "auth_token="..self.authToken
	if progress ~= nil then 
		params = param.."&progress="..progress
	end

	local path = "achievements/unlock/"..achievementID..".json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Achievement Unlocked: "..event.response)
			Runtime:dispatchEvent({name="Achievements", type="AchievementUnlocked"})
		end
	end

	postGM(path, params, networkListener)
end

-------------------------------------------------
-- Analytics
-------------------------------------------------

function gameminion:submitEvent(eventDetails)
	local params = "auth_token="..self.authToken
	params = params.."&event_type="..eventDetails.event_type
	params = params.."&message="..eventDetails.message
	params = params.."&name="..eventDetails.name

	local path = "analytic_events.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Analytics Event Submitted: "..event.response)
		end
	end

	postGM(path, params, networkListener)
end

-------------------------------------------------
-- Chat
-------------------------------------------------

function gameminion:createChatRoom(chatRoomName)
	local params = "auth_token="..self.authToken
	params = params.."&name="..chatRoomName

	local path = "chats.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Chat Room Created: "..event.response)
		end
	end

	postGM(path, params, networkListener)

end

-------------------------------------------------

function gameminion:deleteChatRoom(chatroomID)
	local params = "auth_token="..self.authToken
	
	local path = "chats/"..chatroomID..".json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Chat Room Deleted: "..event.response)
		end
	end

	deleteGM(path, params, networkListener)

end

-------------------------------------------------

function gameminion:sendMessageToChatRoom(chatroomID,message)
	local params = "auth_token="..self.authToken
	params = params.."&content="..message

	local path = "chats/"..chatroomID.."/send_message.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Message Sent: "..event.response)
		end
	end

	postGM(path, params, networkListener)

end

-------------------------------------------------

function gameminion:addUserToChatRoom(userID,chatroomID)
	local params = "auth_token="..self.authToken
	params = params.."&user_id="..userID

	local path = "chats/"..chatroomID.."/add_user.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("User Added to Chat Room: "..event.response)
		end
	end

	postGM(path, params, networkListener)

end

-------------------------------------------------

function gameminion:removeUserFromChatRoom(userID,chatroomID)
	local params = "auth_token="..self.authToken
	params = params.."&user_id="..userID
	
	local path = "chats/"..chatroomID.."/remove_user.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("User Removed from Chat Room: "..event.response)
		end
	end

	deleteGM(path, params, networkListener)

end
-------------------------------------------------

--Returns all the chat room the user is in
function gameminion:getChatRooms()
	local params = "auth_token="..self.authToken

	local path = "chats.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Chat Rooms: "..event.response)
			local response = json.decode(event.response)
			Runtime:dispatchEvent({name="Chat", results=response})
		end
	end

	getGM(path, params, networkListener)

end

-------------------------------------------------

function gameminion:getChatHistory(chatroomID)
	local params = "auth_token="..self.authToken

	local path = "chats/"..chatroomID.."/get_recent_chats.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Chat Room History: "..event.response)
			local response = json.decode(event.response)
			Runtime:dispatchEvent({name="Chat", results=response})
		end
	end

	getGM(path, params, networkListener)
end

-------------------------------------------------
--Return what users are currently in a chat room
function gameminion:getUsersInChatRoom(chatroomID)
	local params = "auth_token="..self.authToken

	local path = "chats/"..chatroomID.."/members.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Chat Room Members: "..event.response)
			local response = json.decode(event.response)
			Runtime:dispatchEvent({name="Chat", results=response})
		end
	end

	getGM(path, params, networkListener)

end

-------------------------------------------------
-- Friends
-------------------------------------------------

function gameminion:getFriends()
	local params = "auth_token="..self.authToken

	local path = "friends.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Chat Rooms: "..event.response)
			local response = json.decode(event.response)
			Runtime:dispatchEvent({name="Friends", type="Friends", results=response})
		end
	end

	getGM(path, params, networkListener)
end

-------------------------------------------------

function gameminion:addFriend(friendID)
	local params = "auth_token="..self.authToken
	params = params.."&user_id="..friendID

	local path = "friends.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Friend Added: "..event.response)
			local response = json.decode(event.response)
			Runtime:dispatchEvent({name="Friends", type="FriendAdded", results=response})
		end
	end

	postGM(path, params, networkListener)
end

-------------------------------------------------

function gameminion:removeFriend(friendID)
	local params = "auth_token="..self.authToken
	params = params.."&user_id="..friendID

	local path = "friends.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Friend Deleted: "..event.response)
			local response = json.decode(event.response)
			Runtime:dispatchEvent({name="Friends", type="FriendDeleted", results=response})
		end
	end

	deleteGM(path, params, networkListener)
end

-------------------------------------------------
-- News
-------------------------------------------------

function gameminion:getNews()
	local params = "auth_token="..self.authToken

	local path = "news.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("News: "..event.response)
			local response = json.decode(event.response)
			Runtime:dispatchEvent({name="News", type="News", results=response})
		end
	end

	getGM(path, params, networkListener)
end

-------------------------------------------------

function gameminion:getUnreadNews()
	local params = "auth_token="..self.authToken

	local path = "news/unread.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("News (Unread): "..event.response)
			local response = json.decode(event.response)
			Runtime:dispatchEvent({name="News", type="UnreadNews", results=response})
		end
	end

	getGM(path, params, networkListener)
end

-------------------------------------------------

function gameminion:getNewsArticle(articleID)
	local params = "auth_token="..self.authToken

	local path = "news/"..articleID..".json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("News Article: "..event.response)
			local response = json.decode(event.response)
			Runtime:dispatchEvent({name="News", type="NewsArticle", results=response})
		end
	end

	getGM(path, params, networkListener)
end
-------------------------------------------------
-- Multiplayer
-------------------------------------------------

function gameminion:createMatch()
	local params = "auth_token="..self.authToken
	
	local path = "matches.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Match Created: "..event.response)
			local response = json.decode(event.response)
			Runtime:dispatchEvent({name="Multiplayer", type="MatchCreated", results=response})
		end
	end

	postGM(path, params, networkListener)
end

-------------------------------------------------

function gameminion:createMatchAndStart()
	local params = "auth_token="..self.authToken
	
	local path = "matches.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Match Created and Started: "..event.response)
			local response = json.decode(event.response)

			-- Start match
			self:startMatch(response._id)
			Runtime:dispatchEvent({name="Multiplayer", type="MatchCreated", results=response})
		end
	end

	postGM(path, params, networkListener)
end

-------------------------------------------------

function gameminion:getMatches()
	
	local params = "auth_token="..self.authToken

	local path = "matches.json"

	-- dispatch matches event with list of matches
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Get Matches: "..event.response)
			local response = json.decode(event.response)
			Runtime:dispatchEvent({name="Multiplayer", type="Matches", results=response})
		end
	end

	getGM(path, params, networkListener)
end

-------------------------------------------------

function gameminion:getMatchDetails(matchID)
	local params = "auth_token="..self.authToken

	local path = "matches/"..matchID..".json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Get Match Details: "..event.response)
			local response = json.decode(event.response)
			Runtime:dispatchEvent({name="Multiplayer", type="MatchDetails", results=response})
		end
	end

	getGM(path, params, networkListener)
end

-------------------------------------------------

function gameminion:deleteMatch(matchID)
	local params = "auth_token="..self.authToken

	local path = "matches/"..matchID..".json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Match Deleted: "..event.response)
			local response = json.decode(event.response)
			Runtime:dispatchEvent({name="Multiplayer", type="MatchDeleted", results=response})
		end
	end

	deleteGM(path, params, networkListener)

end

-------------------------------------------------

function gameminion:resignMatch(matchID)
	local params = "auth_token="..self.authToken

	local path = "matches/"..matchID.."/resign.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Match Resigned: "..event.response)
			local response = json.decode(event.response)
			Runtime:dispatchEvent({name="Multiplayer", type="MatchResigned", results=response})
		end
	end

	deleteGM(path, params, networkListener)

end

-------------------------------------------------

function gameminion:addPlayerToMatch(userID, matchID)
	local params = "auth_token="..self.authToken
	params = params.."&user_id="..userID
	
	local path = "matches/"..matchID.."/add_player.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Player Added to Match: "..event.response)
		end
	end

	postGM(path, params, networkListener)
end

-------------------------------------------------

function gameminion:deletePlayer(matchID,playerID)
	local params = "auth_token="..self.authToken
	params = params.."&player_id="..playerID

	local path = "matches/"..matchID.."/remove_player.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Player Removed: "..event.response)
			local response = json.decode(event.response)
			Runtime:dispatchEvent({name="Multiplayer", type="PlayerDeleted", results=response})
		end
	end

	deleteGM(path, params, networkListener)

end

-------------------------------------------------

function gameminion:addPlayerToMatchGroup(userID, groupID, matchID)
	local params = "auth_token="..self.authToken
	params = params.."&user_id="..userID
	params = params.."&group_id="..groupID
	
	local path = "matches/"..matchID.."/add_player_to_group.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Player Added to Match Group: "..event.response)
		end
	end

	postGM(path, params, networkListener)
end

-------------------------------------------------

function gameminion:submitMove(moveContent, targetGroup, targetUser, matchID)
	local params = "auth_token="..self.authToken
	
	-- if targetgroup specified then add parameter
	if (targetGroup ~= nil) then
		params = params.."&group_id="..targetGroup
	end
	
	-- if targetUser specified then add parameter
	if (targetGroup ~= nil) then
		params = params.."&target_user_id="..targetUser
	end

	-- Base64 encode moveContent
	moveContent = b64enc(moveContent)

	params = params.."&content="..moveContent
	
	local path = "matches/"..matchID.."/move.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Move Submitted: "..event.response)
		end
	end

	postGM(path, params, networkListener)
end

-------------------------------------------------

function gameminion:getRecentMoves(matchID, limit)
	local params = "auth_token="..self.authToken

	local path = "matches/"..matchID.."/get_recent_moves.json"

	-- Force get all moves
	params = params.."&criteria=all"

	-- Check if limit provided, if so add param
	if (limit ~= nil) then
		params = params.."&move_count="..limit
	end

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Recent Match Moves: "..event.response)
			local response = json.decode(event.response)

			-- Decode content - Convenient!
			-- TODO: Need to made it iterate through all moves,
			-- not just one.
			if (response[1] ~= nil) then
				print("Decoding Content")
				response[1].content = b64dec(response[1].content)
			end

			Runtime:dispatchEvent({name="Multiplayer", type="RecentMoves", results=response})
		end
	end

	getGM(path, params, networkListener)
end

-------------------------------------------------

function gameminion:startMatch(matchID)
	local params = "auth_token="..self.authToken
	
	local path = "matches/"..matchID.."/start.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Match Started: "..event.response)
			Runtime:dispatchEvent({name="Multiplayer", type="MatchStarted"})
		end
	end

	postGM(path, params, networkListener)
end

-------------------------------------------------

function gameminion:stopMatch(matchID)
	local params = "auth_token="..self.authToken
	
	local path = "matches/"..matchID.."/stop.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Match Stopped: "..event.response)
			Runtime:dispatchEvent({name="Multiplayer", type="MatchStopped"})

		end
	end

	postGM(path, params, networkListener)
end

-------------------------------------------------

function gameminion:acceptChallenge(matchID)
	local params = "auth_token="..self.authToken
	
	local path = "matches/"..matchID.."/accept_request.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Challenge Accepted: "..event.response)
		end
	end

	postGM(path, params, networkListener)
end

-------------------------------------------------

function gameminion:declineChallenge(matchID)
	local params = "auth_token="..self.authToken
	
	local path = "matches/"..matchID.."/reject_request.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Challenge Declined: "..event.response)
		end
	end

	postGM(path, params, networkListener)
end

-------------------------------------------------

function gameminion:createRandomChallenge(matchID,matchType)
	local params = "auth_token="..self.authToken
	
	if matchType ~= nil then 
		params = params.."&match_type="..matchType
	end

	local path = "matches/random_match_up.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Random Challenge Sent: "..event.response)
			Runtime:dispatchEvent({name="Multiplayer", type="RandomChallenge", results=response})
		end
	end

	postGM(path, params, networkListener)
end

-------------------------------------------------

function gameminion:createMPChannel(matchID)
	local params = "auth_token="..self.authToken
	
	local path = "matches/"..matchID.."/create_channel_for_player.json"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("MP Channel Created: "..event.response)
		end
	end

	postGM(path, params, networkListener)
end

-------------------------------------------------

function gameminion:pollMP(playerID)
	local path = "http://mp.gameminion.com/receive"
	path = path.."?player_id="..playerID

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Connecting to MP Server: "..event.response)
			local response = json.decode(event.response)
			Runtime:dispatchEvent({name="Multiplayer", type="Receive", results=response})
		end
	end

	network.request(path, "GET", networkListener)
end

-------------------------------------------------

return gameminion