
local M= {}

local iOSPrefix="images/iOS/";
local androidPrefix="images/android/";

local iPhoneSuffix=""
local iPhone4AltSuffix="-HD.png"
local iPhone4Suffix="@2x.png"
local iPhoneTallSuffix="-568h@2x.png"
local iPadSuffix="-iPad.png"
local iPadRetinaSuffix="-iPad@2x.png"
local NookSuffix="-nook.png"
local NookHDSuffix="-nookHD.png"
local NookHDPlusSuffix="-nookHDPlus.png"

	M.debugOn = true;
	M.scalex = display.contentScaleX
	M.scaley = display.contentScaleY
	M.screenHeight=display.contentHeight;
	M.screenWidth=display.contentWidth;
	if(M.debugOn) then
		--print("scalex", "scaley", scalex, scaley)
	end

	M.isTall = ( "iPhone" == system.getInfo( "model" ) or "iPhone Simulator" == system.getInfo( "model" )) and ( display.pixelHeight > 960 )
	if(M.debugOn) then
		print("Display Pixel Height: "..display.pixelHeight)
		print("Model: "..system.getInfo( "model" ))
		print("Is Tall: ");
		print(M.isTall);
	end
	
	function round(num, idp)
	  local mult = 10^(idp or 0)
	  return math.floor(num * mult + 0.5) / mult
	end
	function M.isIPhone()
		if((M.screenHeight==320 and M.screenWidth==480) or (M.screenHeight==480 and M.screenWidth==320)) then
			if(M.debugOn) then
				print("isIPhone");
			end
			return true
		else
			return false
		end
	end
	function M.isIPhoneRetina()
		if((M.screenHeight==640 and M.screenWidth==960) or (M.screenHeight==960 and M.screenWidth==640) ) then
			if(M.debugOn) then
				print("isIPhoneRetina");
			end
			return true
		elseif(M.isTall) then
			if(M.debugOn) then
				print("isIPhoneRetina-4\"");
			end
			return true
		else
			return false
		end
	end
	function M.isIPhone4()
		--Legacy method, deprecated
		return isIPhoneRetina()
	end
	function M.isIPad()
		if((M.screenHeight==768 and M.screenWidth==1024) or (M.screenHeight==1024 and M.screenWidth==768)) then
			if(M.debugOn) then
				print("isIPad");
			end
			return true
		else
			return false
		end
	end
	function M.isIPadRetina()
		if((M.screenHeight==1536 and M.screenWidth==2048) or (M.screenHeight==2048 and M.screenWidth==1536)) then
			if(M.debugOn) then
				print("isIPadRetina");
			end
			return true
		else
			return false
		end
	end
	function M.isNook()
		if((M.screenHeight==600 and M.screenWidth==1024) or (M.screenHeight==1024 and M.screenWidth==600)) then
			if(M.debugOn) then
				print("isNook");
			end
			return true
		else
			return false
		end
	end
	function M.isNookHD()
		if((M.screenHeight==1356 and M.screenWidth==900) or (M.screenHeight==900 and M.screenWidth==1356)) then
			if(M.debugOn) then
				print("isNookHD");
			end
			return true
		else
			return false
		end
	end
	function M.isNookHDPlus()
		if((M.screenHeight==1836 and M.screenWidth==1280) or (M.screenHeight==1280 and M.screenWidth==1836)) then
			if(M.debugOn) then
				print("isNookHDPlus");
			end
			return true
		else
			return false
		end
	end
	
			
	
	function M.getImageNameWithSuffix(imageName)
		local imageWithSuffixName
		
		local sizeH=M.screenHeight
		local sizeW=M.screenWidth
		if(M.debugOn) then
			print("sizeH","sizeW",sizeH,sizeW)
		end
		
		
		local tempImage
		--iPad: scalex	scaley	0.46875	0.41666665673256
		--iPhone: scalex	scaley	1	1
		--iPhone 4: scalex	scaley	0.5	0.5
		--Nook: scalex	scaley	0.46875	0.53333336114883
		if(M.debugOn) then
			print("Looking for: ", iOSPrefix..imageName)
		end	
		if(M.isIPhone()) then
			imageWithSuffixName=iOSPrefix .. imageName
		elseif(M.isIPhoneRetina()) then
			if(M.isTall) then
				if(M.debugOn) then
					print("IsTall");
				end
				imageWithSuffixName=iOSPrefix..string.gsub(imageName,".png",iPhoneTallSuffix)
				tempImage=display.newImage(imageWithSuffixName,true)
				if(not tempImage) then
					imageWithSuffixName=iOSPrefix..string.gsub(imageName,".png",iPhone4Suffix)
					tempImage=display.newImage(imageWithSuffixName,true)
					if(not tempImage) then
						imageWithSuffixName=iOSPrefix..string.gsub(imageName,".png",iPhone4AltSuffix)
						tempImage=display.newImage(imageWithSuffixName,true)
						if(not tempImage) then
							imageWithSuffixName=iOSPrefix .. imageName
						end
					end
				end
			else
				imageWithSuffixName=iOSPrefix..string.gsub(imageName,".png",iPhone4Suffix)
				tempImage=display.newImage(imageWithSuffixName,true)
				if(not tempImage) then
					imageWithSuffixName=iOSPrefix..string.gsub(imageName,".png",iPhone4AltSuffix)
					tempImage=display.newImage(imageWithSuffixName,true)
					if(not tempImage) then
						imageWithSuffixName=iOSPrefix .. imageName
					end
				end
			end
		elseif(M.isNook()) then
			imageWithSuffixName=androidPrefix..string.gsub(imageName,".png",NookSuffix)
			if(M.debugOn) then
				print("Trying: "..imageWithSuffixName)
			end
			tempImage=display.newImage(imageWithSuffixName,true)
			if(not tempImage) then
				imageWithSuffixName=iOSPrefix..string.gsub(imageName,".png",iPadSuffix)
				tempImage=display.newImage(imageWithSuffixName,true)
				if(not tempImage) then
					imageWithSuffixName=iOSPrefix..string.gsub(imageName,".png",iPhone4Suffix)
					tempImage=display.newImage(imageWithSuffixName,true)
					if(not tempImage) then
						imageWithSuffixName=iOSPrefix..string.gsub(imageName,".png",iPhone4AltSuffix)
						tempImage=display.newImage(imageWithSuffixName,true)
						if(not tempImage) then
							imageWithSuffixName=iOSPrefix..imageName
						end
					end
				end
			end
		elseif(M.isNookHD()) then
			imageWithSuffixName=androidPrefix..string.gsub(imageName,".png",NookHDSuffix)
			if(M.debugOn) then
				print("Trying: "..imageWithSuffixName)
			end
			tempImage=display.newImage(imageWithSuffixName,true)
			if(not tempImage) then
				imageWithSuffixName=iOSPrefix..string.gsub(imageName,".png",iPadSuffix)
				tempImage=display.newImage(imageWithSuffixName,true)
				if(not tempImage) then
					imageWithSuffixName=iOSPrefix..string.gsub(imageName,".png",iPhone4Suffix)
					tempImage=display.newImage(imageWithSuffixName,true)
					if(not tempImage) then
						imageWithSuffixName=iOSPrefix..string.gsub(imageName,".png",iPhone4AltSuffix)
						tempImage=display.newImage(imageWithSuffixName,true)
						if(not tempImage) then
							imageWithSuffixName=iOSPrefix..imageName
						end
					end
				end
			end
		elseif(M.isNookHDPlus()) then
			imageWithSuffixName=androidPrefix..string.gsub(imageName,".png",NookHDPlusSuffix)
			if(M.debugOn) then
				print("Trying: "..imageWithSuffixName)
			end
			tempImage=display.newImage(imageWithSuffixName,true)
			if(not tempImage) then
				imageWithSuffixName=iOSPrefix..string.gsub(imageName,".png",iPadRetinaSuffix)
				tempImage=display.newImage(imageWithSuffixName,true)
				if(not tempImage) then
					imageWithSuffixName=iOSPrefix..string.gsub(imageName,".png",iPhone4Suffix)
					tempImage=display.newImage(imageWithSuffixName,true)
					if(not tempImage) then
						imageWithSuffixName=iOSPrefix..string.gsub(imageName,".png",iPhone4AltSuffix)
						tempImage=display.newImage(imageWithSuffixName,true)
						if(not tempImage) then
							imageWithSuffixName=iOSPrefix..imageName
						end
					end
				end
			end
		elseif(M.isIPad()) then
			imageWithSuffixName=iOSPrefix..string.gsub(imageName,".png",iPadSuffix)
			tempImage=display.newImage(imageWithSuffixName,true)
			if(not tempImage) then
				imageWithSuffixName=iOSPrefix..string.gsub(imageName,".png",iPhone4Suffix)
				tempImage=display.newImage(imageWithSuffixName,true)
				if(not tempImage) then
					imageWithSuffixName=iOSPrefix..string.gsub(imageName,".png",iPhone4AltSuffix)
					tempImage=display.newImage(imageWithSuffixName,true)
					if(not tempImage) then
						imageWithSuffixName=iOSPrefix .. imageName
					end
				end
			end
		elseif(M.isIPadRetina()) then
			imageWithSuffixName=iOSPrefix..string.gsub(imageName,".png",iPadRetinaSuffix)
			tempImage=display.newImage(imageWithSuffixName,true)
			if(not tempImage) then
				imageWithSuffixName=iOSPrefix..string.gsub(imageName,".png",iPadSuffix)
				tempImage=display.newImage(imageWithSuffixName,true)
				if(not tempImage) then
					imageWithSuffixName=iOSPrefix..string.gsub(imageName,".png",iPhone4Suffix)
					tempImage=display.newImage(imageWithSuffixName,true)
					if(not tempImage) then
						imageWithSuffixName=iOSPrefix..string.gsub(imageName,".png",iPhone4AltSuffix)
						tempImage=display.newImage(imageWithSuffixName,true)
						if(not tempImage) then
							imageWithSuffixName=iOSPrefix .. imageName
						end
					end
				end
			end
		end		
		if(tempImage) then
			tempImage:removeSelf()
		end
		tempImage=nil
		if(M.debugOn) then
			print("Using imageName: ",imageWithSuffixName)
		end
		return imageWithSuffixName
	end
	
	function M.getImageNameWithoutSuffix(imageName)
		local imageFileName=M.getImageNameWithSuffix(imageName);
		local returnName=string.gsub(string.gsub(imageFileName,".png",""), iOSPrefix,"");
		returnName=string.gsub(returnName,androidPrefix,"");
		if(M.debugOn) then
			print("Returning Object Name: "..returnName)
		end
		return returnName

	end
	
return M;