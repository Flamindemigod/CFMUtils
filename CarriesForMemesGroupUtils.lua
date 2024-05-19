cfmutils.EM = EventCallbackManager and EventCallbackManager:New("CFMUtilsManager") or GetEventManager()
cfmutils.Chat = LibChatMessage("|cFF06E6CFM|rUtils", "|cFF06E6CFM|rUtils")
LibChatMessage:SetTagPrefixMode(TAG_PREFIX_SHORT)

function cfmutils.HandleSlashCommand(command)
    command = cfmutils.split(command)
    if command[1] == "placemarker" then
        cfmutils.SetMarker()
    elseif command[1] == "removemarker" then
        cfmutils.RemoveMarker()
    elseif command[1] == "addcommand" and command[2] and command[3] then
        local f = assert(LoadString(command[3]))
        if type(f) == "function" then
            cfmutils.Debug("Add Command String Alias: " .. command[2] .. "Call ".. command[3])
            cfmutils.savedVars.customCommands[command[2]] = command[3]
            cfmutils.Chat:Print("Added Custom Command")

        end
    elseif command[1] == "removecommand" and command[2] then
        if cfmutils.savedVars.customCommands[command[2]] then
            table.removeKey(cfmutils.savedVars.customCommands, command[2])
            cfmutils.Chat:Print("Removed Custom Command")
        end
    elseif cfmutils.savedVars.customCommands[command[1]] then
        local f = LoadString(cfmutils.savedVars.customCommands[command[1]])
        f()
    else
        cfmutils.Chat:Print("/cfm - Opens Addon Menu")
        cfmutils.Chat:Print("/cfmutils placemarker - Place a ground marker. Removes current marker")
        cfmutils.Chat:Print("/cfmutils removemarker - Remove ground marker if exists")
        cfmutils.Chat:Print("/cfmutils addcommand {Alias} {Command} - Adds Command to Custom Execution List")
        cfmutils.Chat:Print("/cfmutils removecommand {Alias} - Removes existing Command from Custom Execution List")
        if cfmutils.savedVars.customCommands then
            for customalias, customCommand in pairs(cfmutils.savedVars.customCommands) do
                if customCommand then
                    cfmutils.Chat:Print("/cfmutils " .. customalias .. " " .. customCommand .. " - Custom Command")
                end
            end
        end
    end
end

function cfmutils.Deactivate()
    cfmutils.KADeactivate()
    cfmutils.ASDeactivate()
    cfmutils.EM:UnregisterForEvent(cfmutils.name .. "bossChanged", EVENT_BOSSES_CHANGED)
    cfmutils.EM:UnregisterForEvent(cfmutils.name .. "CombatUpdate", EVENT_PLAYER_COMBAT_STATE)
    cfmutils.EM:UnregisterForEvent(cfmutils.name .. "AbilityTracker", EVENT_COMBAT_EVENT)
    cfmutils.EM:UnregisterForEvent(cfmutils.name .. "PowerUpdate", EVENT_POWER_UPDATE)
    cfmutils.EM:UnregisterForEvent(cfmutils.name .. "EffectUpdate", EVENT_EFFECT_CHANGED)
    cfmutils.EM:UnregisterForUpdate(cfmutils.name .. "UpdateTick")
end

function cfmutils.zoneCheck()
    cfmutils.GenToxicText()
    zoneId = GetZoneId(GetUnitZoneIndex("player"))
    if cfmutils.savedVars.enabled then
        if zoneId == cfmutils.zones["Kyne's Aegis"] then
            cfmutils.KAActivate()
        elseif zoneId == cfmutils.zones["Asylum Sanctorium"] then
            cfmutils.ASActivate()
        else
            cfmutils.Deactivate()
        end
    end
end

local function DeathRecapChanged(status)
    if HodorReflexes.sv.toxicMode then
        HodorReflexes.sv.toxicMode = false
    end
    if status and ZO_DeathRecapScrollContainerScrollChildHintsContainerHints1Text then
        local text = Toxic[math.random(#Toxic)]
        ZO_DeathRecapScrollContainerScrollChildHintsContainerHints1Text:SetText(text)
    end
end

function cfmutils.GenToxicText()
    DEATH_RECAP:UnregisterCallback("OnDeathRecapAvailableChanged", DeathRecapChanged)
    local metatable = {
        __add = function(t1, t2)
            local ret = {}
            for i, v in ipairs(t1) do
                table.insert(ret, v)
            end
            for i, v in ipairs(t2) do
                table.insert(ret, v)
            end
            return ret
        end
    }
    Toxic = {} -- wipe the current table
    local zoneId = GetZoneId(GetUnitZoneIndex('player'))
    -- Create new table
    Toxic = cfmutils.ToxicText
    setmetatable(Toxic, metatable)
    if zoneId == cfmutils.zones["Kyne's Aegis"] then
        setmetatable(cfmutils.ToxicTextKA, metatable)
        Toxic = Toxic + cfmutils.ToxicTextKA
    elseif zoneId == cfmutils.zones["Asylum Sanctorium"] then
        setmetatable(cfmutils.ToxicTextAS, metatable)
        Toxic = Toxic + cfmutils.ToxicTextAS
    elseif zoneId == cfmutils.zones["Rockgrove"] then
        setmetatable(cfmutils.ToxicTextRG, metatable)
        Toxic = Toxic + cfmutils.ToxicTextRG
    end
    if cfmutils.ToxicTextPlayer[GetDisplayName()] then
        setmetatable(cfmutils.ToxicTextPlayer[GetDisplayName()], metatable)
        Toxic = Toxic + cfmutils.ToxicTextPlayer[GetDisplayName()]
    end
    DEATH_RECAP:RegisterCallback("OnDeathRecapAvailableChanged", DeathRecapChanged)
end

function cfmutils.OnPlayerActivated()
    cfmutils.CheckActivation()
end

function cfmutils.CheckActivation()
    if not cfmutils.savedVars.enabled then
        cfmutils.EM:UnregisterForEvent(cfmutils.name .. "playerActive", EVENT_PLAYER_ACTIVATED)
        cfmutils.RemoveMarker(true)
    else
        cfmutils.EM:RegisterForEvent(cfmutils.name .. "playerActive", EVENT_PLAYER_ACTIVATED, cfmutils.OnPlayerActivated)
        cfmutils.zoneCheck()
    end
end

function cfmutils.UpdateArrowStyle()
    LibSimpleArrow.ApplyStyle(cfmutils.savedVars.ArrowStyle, cfmutils.savedVars.ArrowColor, cfmutils.savedVars.ArrowSize)
end

function cfmutils.OnAddonLoaded(e, addon)
    if addon == cfmutils.name then
        SLASH_COMMANDS["/cfmutils"] = cfmutils.HandleSlashCommand
        cfmutils.savedVars = ZO_SavedVars:NewCharacterIdSettings(cfmutils.varsName, cfmutils.variableVersion,
            cfmutils.name, cfmutils.defaults, GetWorldName())
        cfmutils.EM:UnregisterForEvent(cfmutils.name .. "onLoad", EVENT_ADD_ON_LOADED)
        if not WINDOW_MANAGER:GetControlByName("LibSimpleArrowTexture", "") then
            LibSimpleArrow.CreateTexture()
        end
        cfmutils.UpdateArrowStyle()
        cfmutils.CheckActivation()
        cfmutils.buildMenu()
    end
end

cfmutils.EM:RegisterForEvent(cfmutils.name .. "onLoad", EVENT_ADD_ON_LOADED, cfmutils.OnAddonLoaded)
