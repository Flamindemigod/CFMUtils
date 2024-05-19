function cfmutils.secondsToMinSecString(inputSecs)
    local min = math.floor(inputSecs/60)
    local secs = inputSecs%60
    return string.format("%01d:%02d",min, secs)
end

function table.removeKey(table, key)
    local element = table[key]
    table[key] = nil
    return element
end

function cfmutils.SetMarker()
    cfmutils.RemoveMarker(true)
	if not cfmutils.savedVars.enabled then
        cfmutils.Chat:Print("Cannot Place Marker as Addon is not enabled")
		return
	end
	local zone, wX, wY, wZ = GetUnitRawWorldPosition( "player" )
	cfmutils.marker = OSI.CreatePositionIcon( 
		wX, 
		wY, 
		wZ,
		cfmutils.savedVars.MarkerStyle,
		OSI.GetIconSize() * cfmutils.savedVars.MarkerSize, -- optional icon size
		cfmutils.savedVars.MarkerColor, -- optional icon color {r,g,b}
		cfmutils.savedVars.MarkerOffset, -- optional icon offset in meters
		function(data) -- optional callback function
			-- simple bounce animation along the y-axis
            data.texture = cfmutils.savedVars.MarkerStyle
			data.color = cfmutils.savedVars.MarkerColor
			data.size= OSI.GetIconSize() * cfmutils.savedVars.MarkerSize
			data.offset = cfmutils.savedVars.MarkerOffset + cfmutils.savedVars.MarkerBob*math.sin( GetGameTimeMilliseconds() / 1000 * 2 )
			-- the data object passed to the callback function contains:
			-- texture, size, color, offset
		end)
    cfmutils.Chat:Print("Marker Placed")

end

function cfmutils.RemoveMarker(ignore)
    local ignore = ignore or false
	if cfmutils.marker then
        OSI.DiscardPositionIcon(cfmutils.marker)
        cfmutils.marker = nil
        if not ignore then
            cfmutils.Chat:Print("Marker Removed")
        end
        else
        if not ignore then
            cfmutils.Chat:Print("Marker doesnt exist. Ignoring command")
        end
    end
end

function cfmutils.Debug(message)
    if (cfmutils.savedVars.debugEnabled) then
        cfmutils.Chat:Print(message)
        table.insert(cfmutils.savedVars.debugLog, string.format("[%d / %d / %s] %s", GetTimeStamp(), GetGameTimeMilliseconds(), LocalizeString("<<C:1>>", GetZoneNameByIndex(GetUnitZoneIndex("player"))), message))
    end
end

function cfmutils.split (inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end