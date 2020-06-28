local plist_page = 0
local max_plist_pages = 1
local pList = {}
local count_players = 1


--------------------------------------------------------------------
function ManagePlistControls()
	DisableControlAction(1, 246, false)
	DisableControlAction(0, 246, false)
	--[[if IsDisabledControlJustPressed(1, 246) then
		DrawPlist()
	elseif IsDisabledControlJustReleased(1, 246) then
		DrawPlist()
	end]]
	
	if plist_page > 0 then
		DisableControlAction(0, 202, false)
		SetPauseMenuActive(false)
		if IsControlJustReleased(0, 200) then
			--PlaySoundFrontend(-1, "HACKING_CLICK", 0, 1)
			SetPauseMenuActive(false)
			plist_page = 0
		end
	end
	
	if IsControlJustReleased(0, 246) then
		PlaySoundFrontend(-1, "HACKING_SUCCESS", 0, 1)
	end
	
	if IsDisabledControlJustReleased(1, 246) then
		--PlaySoundFrontend(-1, "HACKING_CLICK", 0, 1)
		plist_page = plist_page + 1
		if plist_page > max_plist_pages then
			plist_page = 0
		end
	end
	
end

--------------------------------------------------------------------
RegisterNetEvent("playFrontendSound")
AddEventHandler('playFrontendSound', function(sound, sndset)
	Citizen.Wait(500)
	PlaySoundFrontend(-1, sound, sndset, 1)
end)

--------------------------------------------------------------------
function getPlayersForPlist()
	max_plist_pages = 1
	local count_l = 1
	local count_p = 1
	pList[count_l] = {}
	count_players = 0*5
	for i = 0, 255 do
		if NetworkIsPlayerConnected(i) and NetworkIsPlayerActive(i) then
			pList[count_l][count_p] = GetPlayerServerId(i) -- saving server id
			count_p = count_p + 1
			if count_p > 25 then
				count_p = 1 
				count_l = count_l + 1
				pList[count_l] = {}
			end
			count_players = count_players + 1
		end	
	end
	max_plist_pages = count_l
end

--------------------------------------------------------------------
function drawText(text, x, y, size, center, font, r, g, b, a)
	local resx, resy = GetScreenResolution()
	SetTextFont(font)
	SetTextScale(size, size)
	SetTextProportional(true)
	SetTextColour(119, 146, 173, 255)
	SetTextCentre(center)
	SetTextDropshadow(0, 0, 0, 0, 0)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText((float(x) / 1.5) / resx, ((float(y) - 6) / 1.5) / resy)
end
--------------------------------------------------------------------
function float(num)
	num = num + 0.00001
	return num
end
--------------------------------------------------------------------
function ManageDrawPlist()
	if plist_page > 0 then
		
		getPlayersForPlist()
		
		local resx, resy = GetScreenResolution()
		local xoffs = 0
		local yoffs = 0
		
		--DrawRect(float(1750+xoffs)/1.5, float(674)/resy, float(300)/resx, float(3)/resy, 0, 0, 0, 200)
		DrawRect((float(875+xoffs)/1.5)/resx, (float(674)/1.5)/resy, (float(300)/1.5)/resx, (float(650)/1.5)/resy, 0, 0, 0, 200)
		
		-- title
		drawText("~w~Players  |  ~s~" .. count_players, 749+xoffs, 365, 0.7, false, 0, 119, 146, 173, 255)
		
		
		-- text
		table.sort(pList[plist_page]) -- sort by sid
		local rows = pList[plist_page]
		local yoffs = 0.3
		for k, v in pairs(rows) do
			local col_na = "~c~"
			local pid = GetPlayerFromServerId(v)
			if GetPlayerName(pid) == GetPlayerName(PlayerId()) then
				col_na = "~s~"
			end
			drawText(col_na ..v, 749+xoffs, 435+yoffs, 0.25, true, 0, 119, 146, 173, 255) -- id
			drawText(col_na .. GetPlayerName(pid), 785+xoffs, 435+yoffs, 0.25, false, 0, 119, 146, 173, 255) -- name
			
			
			yoffs = yoffs + 20.0
		end

		-- note
		local text = "~y~P R E S S   X   F O R   N E X T   P A G E"
		if plist_page == max_plist_pages then
			text = "~o~P R E S S   X   T O   E X I T"
		end
		drawText(text, 875+xoffs, 979, 0.2, true, 0, 255, 255, 255, 255)
	
	end
end


----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		
		local player_l = PlayerId()
		local ped_l = GetPlayerPed(-1)
		if DoesEntityExist(ped_l) and not IsEntityDead(ped_l) then
			
			ManagePlistControls()
			ManageDrawPlist()
			
		end			
		Wait(0)
	end
end)