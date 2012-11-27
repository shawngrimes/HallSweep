
local M={};

local GM_ACCESS_KEY = "776332ac1fa9032207d527ee4d0341217cd5900d"
local GM_SECRET_KEY = "311823259a9f4533d6fee5a85879e7c267191844"

local PARSE_APP_ID="oCPjLQt6Hlla0udh1grGkrz50BoCxcU4t0KZN60N"
local REST_KEY="PayDNmv4EV51ZjvOgAW3TXPbot4svteom4kI4Z0U"


local storyboard = require( "storyboard" )

M.gm = require("utils.gameminion")
M.parse = require("utils.parse-seg")
local json = require("json")

M.gm = M.gm.init(GM_ACCESS_KEY, GM_SECRET_KEY)
--M.gm:loginAPI("shawn@campfireapps.com","mine11")

M.parse=M.parse.init(PARSE_APP_ID,REST_KEY);
--M.parse:login("ShawnGrimes","mine11")

function M:isLoggedIn()
	--return M.gm:isLoggedIn();
	return M.parse:isLoggedIn();
end

function M:logOut()
	print("Clearing auth token")
	M.parse:setAuthToken("");
end

function M:registerUser(username, password, email)
	--M.parse:register("ShawnGrimes","mine11","shawn@campfireapps.com");
	M.parse:register(string.lower(username),password,string.lower(email));
--	local result=M.gm:registerUser(firstName, lastName, username, email, password);
	
	if(result==true) then
		
	else
	
	end
end

function M:registerWithFacebook(facebookID,access_token,expiration_date,fb_username)
	--M.parse:register("ShawnGrimes","mine11","shawn@campfireapps.com");
	M.parse:registerFB(facebookID,access_token,expiration_date,fb_username);
--	local result=M.gm:registerUser(firstName, lastName, username, email, password);
	
	if(result==true) then
		
	else
	
	end
end


function M:loginUser(username, password)
	--local result=M.gm:loginAPI(username, password)
	M.parse:login(string.lower(username), password)
end

function M:resetPassword(email)
	local result=M.parse:recoverPassword(email);
	
	if(result==true) then
		
	else
	
	end
end

function M:showLogin()
	local options={
		effect="fromBottom",
		time=500,
		isModal=true
		}
	print("showing login")
	storyboard.showOverlay( "utils.LoginScene", options);
end

function M:submitHighScore(leaderboard, score)
	--M.gm:submitHighScore(leaderboard, score);
	if(M:isLoggedIn()) then
		M.parse:submitHighScore(leaderboard, score);
	end
end

function M:setAuthToken(authToken)
	--AUTH_TOKEN=authToken;
	M.parse:setAuthToken(authToken);
end

function M:getHighScores(leaderboard)
	if(leaderboard==nil) then
		--get all high scores
		for k,v in pairs(LEADERBOARD_IDS) do
			print("Getting Score For: "..v)
			M.parse:getLeaderboardScores(v)
		end
	else
		M.parse:getLeaderboardScores(leaderboard)
	end
end

--As a security measure and standard practice we return an error, but we never reveal if the credencials are incorrect or the user doesn't exist
function M.listenerLogin(event)
        if (event.errorMsg ~= nil) then         
        	print( "Error Message: "..event.errorMsg)
        	local alert = native.showAlert( "Login Error", event.errorMsg, { "OK"} )
        else
   		storyboard.hideOverlay("slideDown")
   		--userBox.authToken = M.gm:getAuthToken();
   		userBox.authToken = M.parse:getSessionToken();
   		userBox:save()
   		print("Just set authToken: "..userBox.authToken);
        	--local alert = native.showAlert( "Login Successful", "Login worked!", { "OK"} );
        	--M.parse:submitHighScore("X7UXBdwmlH","1");
        	--M.parse:getLeaderboardScores("X7UXBdwmlH")
        end
        --gm:getMyProfile()
        --M.gm:getLeaderboards()
end

function M.listenerMyProfile(event)
        if (event.errorMsg ~= nil) then         
        	print( "Error Message: "..event.errorMsg)
        else
        	print("Username: "..event.results.username)
        	print("Email: "..event.results.email)

        end
        --gm:updateMyProfile(nil,nil,"Doe2")
end

function M.listenerLeaderboards(event)
        if (event.errorMsg ~= nil) then         
        	print( "Error Message: "..event.errorMsg)
        else
        	if (event.type == "AllLeaderboards") then
				print( "ID ="..event.results[1]._id)
				print( "Leaderboard Name: "..event.results[1].name)
				--gm:submitHighScore(event.results[1]._id, "99200")
        		M.gm:getLeaderboardScores(event.results[1]._id)
     		elseif(event.type=="SendScore") then
				print("Score was sent")
				M:getHighScores();
			end
        	if (event.type == "GetScores") then --results
        		print("showing results for leader board: "..event.results["leaderboard"])
        		local leaderboardID=event.results["leaderboard"]
				userBox.leaderboards[leaderboardID]=event.results["scores"];
				userBox:save()
        		for i=1,# event.results["scores"] do
        			local score=event.results["scores"][i]
        			--print("Username: "..score["user"].."    Score:"..score["score"])
        		end
        	end
        end
end

function M.listenerUserRegistered(event)
	if (event.errorMsg ~= nil) then         
        	print( "Error Message: "..event.errorMsg)
        else
        	if (event.type == "RegistrationFailed") then
        		local alert = native.showAlert( "Registration Error", event.results["error"], { "OK"} )
        	elseif(event.type=="UserRegistered") then
	        	userBox.authToken=M.parse:getSessionToken();
    	    	userBox:save()
        		print("Token: "..userBox.authToken)
        		storyboard.hideOverlay("slideDown")
       			local alert = native.showAlert( "Registration Successful", "Thank you for registering", { "OK"} )
       		end
        end
end

function M.listenerPasswordRecovery(event)
	if (event.errorMsg ~= nil) then         
        	print( "Error Message: "..event.errorMsg)
        else
        	if (event.type == "Success") then
        		local alert = native.showAlert( "Password Reset Successful", "Password reset email has been sent.  Please check your email to reset your password.", { "OK"} )
        	elseif(event.type=="ResetFailed") then
        		local alert = native.showAlert( "Password Reset Failed", event.results["error"], { "OK"} )
        	end
        end
end

--Here are event listeners that will call the method "listenerLogin" when the response is received
--Please review the gameminion.lua to see the event names that are returned
Runtime:addEventListener("PasswordRecovery", M.listenerPasswordRecovery);
Runtime:addEventListener("UserRegistered", M.listenerUserRegistered);
Runtime:addEventListener( "LoggedIn", M.listenerLogin )
Runtime:addEventListener( "LoginError", M.listenerLogin )
Runtime:addEventListener( "MyProfile", M.listenerMyProfile )
Runtime:addEventListener( "Leaderboards", M.listenerLeaderboards )

return M;