--Twitter Message
RegisterCommand("tweet", function(source, args, raw)
    if #args <= 0 then return end
    local message = table.concat(args, " ")
	TriggerClientEvent('chatMessage', -1, "^5Twitter ^7: ^7 | ^5" .. GetPlayerName(source) .." ^7 | ^7" ..source.."^0:", { 0, 172, 238 }, message)
end)

--AnTwitter Message
RegisterCommand("antweet", function(source, args, raw)
    if #args <= 0 then return end
    local message = table.concat(args, " ")
	 TriggerClientEvent('chatMessage', -1, "^5Twitter ^7: ^7^5"  .. "^7| ^5 Anonymous" .." ^7| ^7" ..source.."^0:", { 0, 172, 238 }, message)
end)

--911 Message
RegisterCommand("911", function(source, args, raw)
    if #args <= 0 then return end
    local message = table.concat(args, " ")
    TriggerClientEvent('chatMessage', -1, "^3(^3911) ^3^3" .."^3Caller Name | "  .. GetPlayerName(source) .." | ^3Caller ID: " .." ^3 ^3" ..source.."^3" .." | ^3Call Details : ", { 255, 0, 0 }, message)
end)

--AN911 Message
RegisterCommand("an911", function(source, args, raw)
    if #args <= 0 then return end
    local message = table.concat(args, " ")
    TriggerClientEvent('chatMessage', -1, "^3(^3911) ^3^3" .."^3Caller Name | "  .. "^3Anonymous" .." | ^3Caller ID: " .." ^3 ^3" ..source.."^3" .." | ^3Call Details : ", { 255, 0, 0 }, message)
end)

--Dispatch Message
RegisterCommand("dispatch", function(source, args, raw)
    if #args <= 0 then return end
    local message = table.concat(args, " ")
	TriggerClientEvent('chatMessage', -1, "^4Dispatch", { 255, 255, 0 }, message)
end)

--OOC Message
RegisterCommand("ooc", function(source, args, raw)
    if #args <= 0 then return end
    local message = table.concat(args, " ")
	TriggerClientEvent('chatMessage', -1, "^0^7" .."^7(( ".. GetPlayerName(source) .."^7)) " .."^0| ^0" ..source.."^0", { 255, 255, 255 }, message)
end)

--Darkweb Message
RegisterCommand("Darkweb", function(source, args, raw)
    if #args <= 0 then return end
    local message = table.concat(args, " ")
	TriggerClientEvent('chatMessage', -1, "^8(Darkweb) ", { 255, 255, 255 }, message)
end)

--AD Message
RegisterCommand("AD", function(source, args, raw)
    if #args <= 0 then return end
    local message = table.concat(args, " ")
	TriggerClientEvent('chatMessage', -1, "^3(AD) ", { 255, 255, 255 }, message)
end)

--Me Message
RegisterCommand('me', function(source, args, user)
    local name = GetPlayerName(source)
    TriggerClientEvent("sendProxMsgM", -1, source, name, table.concat(args, " "))
end, false)

--Chat Proximity
AddEventHandler('chatMessage', function(source, name, message)
    if string.sub(message, 1, string.len("/")) ~= "/" then
        local name = GetPlayerName(source)
	TriggerClientEvent("sendProxMsg", -1, source, name, message)
    end
    CancelEvent()
end)

--Function
function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

--Console Message
 print "Roleplay Commands - Made by vinnie"