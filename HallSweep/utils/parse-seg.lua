local parse={}
local parse_mt = { __index = parse }	-- metatable

local json=require("json")
local url = require("socket.url")

local parseURL="api.parse.com"
local parseAPIversion="1"
local APP_ID=""
local REST_API_KEY=""
local SESSION_TOKEN=""
local USER_OBJECT_ID=""

if(userBox.userObjectID~=nil) then
	USER_OBJECT_ID=userBox.userObjectID
end

local function createBasicAuthHeader(APP_ID, REST_API_KEY)
	local headers={}
	headers["X-Parse-Application-Id"] = APP_ID
	headers["X-Parse-REST-API-Key"] = REST_API_KEY
	headers["Content-Type"]  = "application/json"
	
	return headers
end

local function postParse(path, parameters, networkListener)
	if (not parameters) then
		parameters = ""
	end

	local params ={}

	params.body = parameters

	local headers = createBasicAuthHeader(APP_ID, REST_API_KEY)

	params.headers = headers

	local url = "https://"..parseURL.."/"..parseAPIversion

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

local function getParse(path, parameters, networkListener)
	local params ={}

	--params.body = parameters

	local headers = createBasicAuthHeader(APP_ID, REST_API_KEY)

	params.headers = headers

	local url = "https://"..parseURL.."/"..parseAPIversion

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

local function putParse(path, parameters, networkListener)


	local params = {}


	local headers = createBasicAuthHeader(APP_ID, REST_API_KEY)

	params.headers = headers

	local url = "https://"..parseURL.."/"..parseAPIversion	
	
	
	params.body = parameters

	print("\n----------------")
	print("-- PUT Call ---")
	print("Put URL: "..url)
	print("Put Path: "..path)
	print("Put Parameters: "..parameters)
	print("----------------")

	--local hReq = url.."/"..path.."?"..parameters
	local hReq = url.."/"..path
	
	print("\nPut Request: "..hReq)
	network.request(hReq, "PUT", networkListener, params)
end

local function deleteParse(path, parameters, networkListener)

	local params = {}


	local headers = createBasicAuthHeader(APP_ID, REST_API_KEY)

	params.headers = headers

	local url = "https://"..parseURL.."/"..parseAPIversion

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


function parse.init(appID, restKey)	-- constructor

	APP_ID = appID
	REST_API_KEY = restKey
	
	local newParse = {
		authToken = authToken,
		accessKey = APP_ID,
		secretKey = REST_API_KEY,
		gameminion = parse
	}
	
	return setmetatable( newParse, parse_mt )
end

function parse:recoverPassword(email)
	local params='{"email":"'..email..'"}'
	local path = "requestPasswordReset"
	
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			local response = json.decode(event.response)
			if(response["error"]) then
				Runtime:dispatchEvent({name="PasswordRecovery", type="ResetFailed",results=response})
			else
				Runtime:dispatchEvent({name="PasswordRecovery", type="Success",results=response})
			end
		end
	end

	postParse(path, params, networkListener)
end

function parse:register(username,password,email)
	local params = '{"username":"'..username..'","password":"'..password..'","email":"'..email..'"}'
	local path = "users"
	
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("New User Details: "..event.response)
			local response = json.decode(event.response)
			if(response["error"]) then
				Runtime:dispatchEvent({name="UserRegistered", type="RegistrationFailed",results=response})
			else
				SESSION_TOKEN=response["sessionToken"]
				USER_OBJECT_ID=response["objectId"]
				Runtime:dispatchEvent({name="UserRegistered", type="UserRegistered",results=response})
			end
		end
	end

	postParse(path, params, networkListener)
end

function parse:registerFB(facebookID,access_token,expiration_date,fb_username)
	local params = '{"fbusername":"'..fb_username..'","authData":{"id":"'..facebookID..'","access_token":"'..access_token..'","expiration_date":"'..expiration_date..'"}}'
	local path = "users"
	
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("New User Details: "..event.response)
			local response = json.decode(event.response)
			if(response["error"]) then
				Runtime:dispatchEvent({name="UserRegistered", type="RegistrationFailed",results=response})
			else
				SESSION_TOKEN=response["sessionToken"]
				USER_OBJECT_ID=response["objectId"]
				Runtime:dispatchEvent({name="UserRegistered", type="UserRegistered",results=response})
			end
		end
	end

	postParse(path, params, networkListener)
end

function parse:login(username,password)
	local params = 'username='..username..'&password='..password
	local path="login"
	
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Login Details: "..event.response)
			local response = json.decode(event.response)
			if(response["error"]) then
				Runtime:dispatchEvent({name="LoginError", errorMsg=response["error"]})
			else
				SESSION_TOKEN=response["sessionToken"];
				USER_OBJECT_ID=response["objectId"];
				userBox.userObjectID=USER_OBJECT_ID;
				userBox:save();
				print("Set SESSION_TOKEN: "..SESSION_TOKEN);
				print("Set USER_OBJECT_ID: "..USER_OBJECT_ID);
				Runtime:dispatchEvent({name="LoggedIn",results=response})
			end
		end
	end

	getParse(path, params, networkListener)
	
end

function parse:isLoggedIn()
	local token=parse:getSessionToken()
	if(token~=nil) then
		if(token~="") then
			return true
		else
			return false
		end
	else
		return false
	end
end

function parse:getSessionToken()
	return SESSION_TOKEN
end

function parse:setAuthToken(authToken)
	SESSION_TOKEN=authToken
	userBox.authToken=authToken
	userBox:save()
end

function parse:submitHighScore(leaderboard, score)
	local params = '{"score":'..score..',"leaderboard":{"__op":"AddRelation","objects":[{"__type":"Pointer","className":"Leaderboards","objectId":"'..leaderboard..'"}]},"user":{"__type":"Pointer","className":"_User","objectId":"'..USER_OBJECT_ID..'"}}';
	local path = "classes/Scores/"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			print("Score Details: "..event.response)
			local response = json.decode(event.response)
			--[[local scoreID=response["objectId"];
			local params = '{"requests":[{"method":"PUT", "path":"/1/classes/Scores/'..scoreID..'","body":{"leaderboard":{"__op":"AddRelation","objects":[{"__type":"Pointer","className":"Leaderboards","objectId":"'..leaderboard..
			'"}]}}},{"method":"PUT", "path":"/1/classes/Scores/'..scoreID..
				'","body":{"user":{"__type":"Pointer","className":"_User","objectId":"'..USER_OBJECT_ID..'"}}}]}';
			
			local path = "batch"
			local  function addLeaderboardNetworkListener(event)
				if (event.isError) then
					print("Network Error")
					print("Error: "..event.response)
					return false
				else
					print("Add Score To Leaderboard Details: "..event.response)
					local response = json.decode(event.response)
				end
			end
			postParse(path, params, addLeaderboardNetworkListener)
			]]--
			Runtime:dispatchEvent({name="Leaderboards", type="SendScore",results=response})
		end
	end

	postParse(path, params, networkListener)
end

function parse:getLeaderboardScores(leaderboard)
	local params = url.escape('where={"leaderboard":{"__type":"Pointer","className":"leaderBoards","objectId":"'..leaderboard..'"}}')
	params=params.."&order=-score&limit=10&include=user";

	local path = "classes/Scores"

	-- set currentUser when it gets it
	local  function networkListener(event)
		if (event.isError) then
			print("Network Error")
			print("Error: "..event.response)
			return false
		else
			local scores = json.decode(event.response)
			print("Leaderboard Response: "..event.response)
--			print("HERE")
--			 for i,v in pairs(scores) do print(i,v) end
--			print("AFTER HERE")
--			print("Leaderboard Details: "..# scores)
			local tableScores={}
			tableScores.leaderboard=leaderboard;
			tableScores.scores={};
			local incrementor=1;
				 for i,v in pairs(scores) do 
				 	for d,f in pairs(v) do 
				 		print("Score: "..f["score"]);
				 		local user="";
						local userScore={}
				 		if(f["user"]~=nil) then
				 			user=f["user"];
				 			userScore.user=user["username"];
				 		end
				 		--print("UserName: "..user["username"]);
				 		--tableScores[incrementor]
						--userScore.user=user["username"];
						userScore.score=f["score"];
						tableScores.scores[incrementor]=userScore;
						incrementor=incrementor+1;
				 	end 
				 end
			Runtime:dispatchEvent({name="Leaderboards", type="GetScores",results=tableScores})
		end
	end

	getParse(path, params, networkListener)
end

return parse;