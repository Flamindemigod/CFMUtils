--[[
    AS Todo 
Add Sphere location support
Add More visible timers
Add Felms Jump counter
]]--



AS = {}
AS.init = false
AS.isOlms = false
AS.Felms = {
    UnitID = 0,
    HP = 100,
    Enrage = 0,
    Up = false,
    Down = false,
    Timer = 0,
}
AS.Llothis = {
    UnitID = 0,
    HP = 100,
    Enrage = 0,
    Up = false,
    Down = false,
    Timer = 0, 
}
AS.DormantTimer = 45
AS.AbilityIDs = {
    StormOfTheHeavens = 98535,
    FindTurret = 64489,
    Dormant = 99990,
    LlothisTauntImmune = 60312,
    BossEvent = 10298,
    Enrage = 101354,
}
AS.SpawnTimers = {}
AS.standingInAoe = {
    -- { alert_duration, exclude_tanks }
    [98356] = { 600, false }, -- Noxious Gas
    [99131] = { 2000, true }, -- Felms Bleed
    [99133] = { 2000, false }, -- Shrapnel Storm 
}
AS.LaneEnd = false

function AS.SetPlayerPos()
    local playerX, playerY = GetMapPlayerPosition("player")
    d("X: " .. playerX .. ", Y:" .. playerY)

end

AS.Lanes = {
    [1] = {
        Start = {97709, 61450, 101253},
        End = {0.67752784490585, 0.52217781543732}
    },
    [2] = {
        Start = {97808, 61450, 100905},
        End = {0.68930000066757, 0.50241750478745}
    },
    [3] = {
        Start = {98010, 61450, 100721},
        End = {0.70254361629486, 0.48244690895081}
    },
    [4] = {
        Start = {98313, 61450, 100625},
        End = {0.72861045598984, 0.47761192917824}
    },
    [5] = {
        Start = {98716, 61450, 100646},
        End = {0.76035314798355, 0.48412865400314}
    },
    [6] = {
        Start = {99096, 61450, 100776},
        End = {0.78873240947723, 0.4834980070591}
    },
    [7] = {
        Start = {99238, 61450, 101020},
        End = {0.80554974079132, 0.50073575973511}
    },
    [8] = {
        Start = {99308, 61450, 101328},
        End = {0.81101536750793, 0.53352952003479}
    }
}

AS.ProtectorLocations = {
    [32638] = "Exit Back",
    [53954] = "Entrance Front",
    [1663] = "Middle Back",
    [33304] = "Under",
    [43629] = "Exit Front",
} -- Possible that target can have multiple targetUnitId, and its assigned at random

function AS.OnCFMUtilsASMove()
    cfmutils.savedVars.ASLeft = CFMUtilsAS:GetLeft()
    cfmutils.savedVars.ASTop = CFMUtilsAS:GetTop()
end

function AS.RestorePosition()
    if cfmutils.savedVars.ASLeft ~= nil then
        CFMUtilsAS:ClearAnchors()
        CFMUtilsAS:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, cfmutils.savedVars.ASLeft, cfmutils.savedVars.ASTop)
    end
end


function AS.Reset()
    cfmutils.Debug("Resetting AS Module")
    CFMUtilsASLabel1:SetHidden(true)
    CFMUtilsASLabel1Value1:SetHidden(true)
    CFMUtilsASLabel1Value2:SetHidden(true)
    CFMUtilsASLabel1Value3:SetHidden(true)
    CFMUtilsASLabel2:SetHidden(true)
    CFMUtilsASLabel2Value1:SetHidden(true)
    CFMUtilsASLabel2Value2:SetHidden(true)
    CFMUtilsASLabel2Value3:SetHidden(true)
    CFMUtilsASDebugLabel1:SetHidden(true)
    CFMUtilsASDebugLabel2:SetHidden(true)
    AS.SpawnTimers = {}
    AS.Felms = {
        UnitID = 0,
        HP = 100,
        Enrage = 0,
        Up = false,
        Down = false,
        Timer = 0,
    }
    AS.Llothis = {
        UnitID = 0,
        HP = 100,
        Enrage = 0,
        Up = false,
        Down = false,
        Timer = 0,
    } 
    if AS.LaneEnd then
        LibSimpleArrow.HideArrow()
    end
    if AS.LaneStart then
        OSI.DiscardPositionIcon(AS.LaneStart)
    end
    AS.LaneEnd = false
    AS.LaneStart = nil
end



function AS.CombatUpdate()
    local currentTargetHP, maxTargetHP, _ = GetUnitPower("boss1", POWERTYPE_HEALTH)
    if not IsUnitInCombat("player") then
        if currentTargetHP/maxTargetHP >= 0.9 or currentTargetHP/maxTargetHP == 0 then 
            cfmutils.Debug("Calling AS Reset")
            AS.Reset()
        end
    end
end



function AS.PowerUpdate(eventCode, unitTag, power, powerType, powerValue, powerMax, powerEffectiveMax)
    local unitName = GetUnitName(unitTag)
    if unitName == "Saint Llothis the Pious" then
        AS.Llothis.HP = (powerValue/powerMax)*100
    elseif unitName == "Saint Felms the Bold" then
        AS.Felms.HP = (powerValue/powerMax)*100
    end
    CFMUtilsASLabel1Value1:SetText(tostring(string.format("%.0f", AS.Llothis.HP)))
    CFMUtilsASLabel2Value1:SetText(tostring(string.format("%.0f", AS.Felms.HP)))
end


-- function AS.StormTracker( e, changeType, effectSlot, effectName, unitTag, beginTime, endTime, stackCount, iconName, buffType, effectType, abilityType, statusEffectType, unitName, unitId, abilityId, sourceType)
function AS.AbilityTracker(eventCode, ActionResult, isError, abilityName, abilityGraphic, ActionSlotType, sourceName, sourceType, 
    targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId, overflow)    
    if abilityId == AS.AbilityIDs.StormOfTheHeavens and cfmutils.savedVars.AsylumShowKite then
        if OSI and OSI.CreatePositionIcon then
            if not AS.LaneEnd then
                LibSimpleArrow.SetTarget(AS.Lanes[cfmutils.savedVars.AsylumLane].End)
                LibSimpleArrow.ShowArrow()
                AS.LaneEnd = true
                zo_callLater(function()
                    AS.LaneEnd = false
                    LibSimpleArrow.HideArrow()
                end, 10 * 1000)
            end
            if not AS.LaneStart then
                AS.LaneStart = OSI.CreatePositionIcon(AS.Lanes[cfmutils.savedVars.AsylumLane].Start[1],
                    AS.Lanes[cfmutils.savedVars.AsylumLane].Start[2], AS.Lanes[cfmutils.savedVars.AsylumLane].Start[3],
                    cfmutils.savedVars.MarkerStyle, 
                    OSI.GetIconSize() * cfmutils.savedVars.MarkerSize, 
                    cfmutils.savedVars.MarkerColor, 
                    cfmutils.savedVars.MarkerOffset, 
                    function(data) 
                        data.color = cfmutils.savedVars.MarkerColor
                        data.size= OSI.GetIconSize() * cfmutils.savedVars.MarkerSize
                        data.offset = cfmutils.savedVars.MarkerOffset + cfmutils.savedVars.MarkerBob*math.sin( GetGameTimeMilliseconds() / 1000 * 2 )
                    end)
                zo_callLater(function()
                    AS.LaneEnd = false
                    LibSimpleArrow.HideArrow()
                    if not cfmutils.savedVars.AsylumLaneAlwaysShowStart then
                        OSI.DiscardPositionIcon(AS.LaneStart)
                        AS.LaneStart = nil
                    end
                end, 10 * 1000)
            end
        end
    elseif (cfmutils.damageEvents[ActionResult] and targetType == COMBAT_UNIT_TYPE_PLAYER and AS.standingInAoe[abilityId]) then
        local params = AS.standingInAoe[abilityId]
        if (not (params[2] and CombatAlerts.isTank)) then
			CombatAlerts.AlertBorder(true, params[1])
		end
    elseif abilityId == AS.AbilityIDs.BossEvent and hitValue == 1 then
        AS.SpawnTimers[targetUnitId] = GetGameTimeSeconds()
    elseif abilityId == AS.AbilityIDs.FindTurret then
        if cfmutils.savedVars.debugEnabled then
            CFMUtilsASDebugLabel2:SetHidden(false)
            CFMUtilsASDebugLabel2:SetText(targetUnitId)
            zo_callLater(CFMUtilsASDebugLabel2:SetHidden(true), 20*1000)
        end
        if AS.ProtectorLocations[targetUnitId] then
            cfmutils.Debug("AbilityID = "..abilityId..", Protector Location = "..AS.ProtectorLocations[targetUnitId]..", TargetUnitID = "..targetUnitId)
        else
            cfmutils.Debug("AbilityID = "..abilityId..", Protector Location = Unknown, TargetUnitID = "..targetUnitId)
        end
    end
end

function AS.EffectUpdate(_, changeType, effectSlot, effectName, unitTag, beginTime, endTime, stackCount, iconName, buffType, effectType, abilityType, statusEffectType, unitName, unitId, abilityId, sourceType)
    if unitName:find("Llothis") or unitName:find("ロシス") or unitName:find("ллотис") then
        if not (AS.Llothis.Up or AS.Llothis.Down) and IsUnitInCombat("player") then
            if cfmutils.savedVars.AsylumTrackMini then
                CFMUtilsASLabel1:SetHidden(false)
                CFMUtilsASLabel1Value1:SetHidden(false)
                CFMUtilsASLabel1Value3:SetHidden(false)
            end
            AS.Llothis.Up = true
            AS.Llothis.Down = false
            AS.Llothis.UnitID = unitId
            AS.Llothis.Timer = GetGameTimeSeconds()
        elseif abilityId == AS.AbilityIDs.Dormant and changeType == EFFECT_RESULT_GAINED then
            AS.Llothis.Down = true
            AS.Llothis.Up = false
            AS.Llothis.Timer = GetGameTimeSeconds() - AS.DormantTimer 
            AS.Llothis.Enrage = 0
        elseif abilityId == AS.AbilityIDs.Dormant and changeType == EFFECT_RESULT_FADED then
            AS.Llothis.Up = true
            AS.Llothis.Down = false
            AS.Llothis.Timer = GetGameTimeSeconds()
        elseif abilityId == AS.AbilityIDs.Enrage then
            AS.Llothis.Enrage = stackCount
        end
    elseif unitName:find("Felms") or unitName:find("フェルムス") or unitName:find("фелмс") then
        if not (AS.Felms.Up or AS.Felms.Down) and IsUnitInCombat("player") then
            if cfmutils.savedVars.AsylumTrackMini then
                CFMUtilsASLabel2:SetHidden(false)
                CFMUtilsASLabel2Value1:SetHidden(false)
                CFMUtilsASLabel2Value3:SetHidden(false)
            end
            AS.Felms.Up = true
            AS.Felms.Down = false
            AS.Felms.UnitID = unitId
            AS.Felms.Timer = GetGameTimeSeconds()
        elseif abilityId == AS.AbilityIDs.Dormant and changeType == EFFECT_RESULT_GAINED then
            AS.Felms.Down = true
            AS.Felms.Up = false
            AS.Felms.Timer = GetGameTimeSeconds() + AS.DormantTimer 
            AS.Felms.Enrage = 0
        elseif abilityId == AS.AbilityIDs.Dormant and changeType == EFFECT_RESULT_FADED then
            AS.Felms.Up = true
            AS.Felms.Down = false
            AS.Felms.Timer = GetGameTimeSeconds()
        elseif abilityId == AS.AbilityIDs.Enrage then
            AS.Felms.Enrage = stackCount
        end
    end
end

function AS.BossesChanged()
    boss = GetUnitName("boss1")
    if boss == "Saint Olms the Just" then
        if not AS.isOlms then 
            AS.isOlms = true
            cfmutils.Debug("At Olms")
            if cfmutils.savedVars.debugEnabled then
                CFMUtilsASDebugLabel1:SetHidden(false)
            end
        end
    elseif boss ~= "Saint Olms the Just" and AS.isOlms then 
        cfmutils.Debug("No Bosses here")
        AS.isOlms = false
        AS.Reset()
    end
end

function AS.UpdateTick(gameTimeMs)
    local LlothisTimer = 0
    local FelmsTimer = 0
    if AS.Llothis.Up then
        LlothisTimer = GetGameTimeSeconds() - AS.Llothis.Timer
    else
        LlothisTimer = AS.Llothis.Timer - GetGameTimeSeconds()
    end
    if AS.Felms.Up then
        FelmsTimer = GetGameTimeSeconds() - AS.Felms.Timer
    else
        FelmsTimer = AS.Felms.Timer - GetGameTimeSeconds()
    end
    CFMUtilsASLabel1Value3:SetText(cfmutils.secondsToMinSecString(LlothisTimer))
    CFMUtilsASLabel2Value3:SetText(cfmutils.secondsToMinSecString(FelmsTimer))
    if AS.Llothis.Enrage > 0 and cfmutils.savedVars.AsylumTrackMini then
        CFMUtilsASLabel1Value2:SetHidden(false)
        CFMUtilsASLabel1Value2:SetText(tostring(AS.Llothis.Enrage))
    else 
        CFMUtilsASLabel1Value2:SetHidden(true)
    end
    if AS.Felms.Enrage > 0 and cfmutils.savedVars.AsylumTrackMini then
        CFMUtilsASLabel2Value2:SetHidden(false)
        CFMUtilsASLabel2Value2:SetText(tostring(AS.Felms.Enrage))
    else 
        CFMUtilsASLabel2Value2:SetHidden(true)
    end
    CFMUtilsASDebugLabel1:SetText(tostring(os.date()))
end

function cfmutils.ASDeactivate()
    if AS.init then
        AS.init = false
        cfmutils.Debug("AS Module Unloaded. Was Felms a healthy boi today?")
        AS.Reset()
    end
end

function cfmutils.ASActivate()
    if not AS.init then
        AS.init = true
        cfmutils.Debug("AS Module Loaded. Remember! Kill the Kite!")
        AS.RestorePosition()
        cfmutils.EM:RegisterForEvent(cfmutils.name .. "bossChanged", EVENT_BOSSES_CHANGED, AS.BossesChanged)
        cfmutils.EM:RegisterForEvent(cfmutils.name .. "AbilityTracker", EVENT_COMBAT_EVENT, AS.AbilityTracker)
        cfmutils.EM:RegisterForEvent(cfmutils.name .. "CombatUpdate", EVENT_PLAYER_COMBAT_STATE, AS.CombatUpdate)
        cfmutils.EM:RegisterForEvent(cfmutils.name .. "EffectUpdate", EVENT_EFFECT_CHANGED, AS.EffectUpdate)
        cfmutils.EM:RegisterForEvent(cfmutils.name .. "PowerUpdate", EVENT_POWER_UPDATE, AS.PowerUpdate)
        cfmutils.EM:AddFilterForEvent(cfmutils.name .. "PowerUpdate", EVENT_POWER_UPDATE, REGISTER_FILTER_POWER_TYPE, POWERTYPE_HEALTH)
        cfmutils.EM:AddFilterForEvent(cfmutils.name .. "PowerUpdate", EVENT_POWER_UPDATE, REGISTER_FILTER_UNIT_TAG, "reticleover")
        cfmutils.EM:RegisterForUpdate(cfmutils.name .. "UpdateTick", 1000 / 10, function(gameTimeMs)
            AS.UpdateTick(gameTimeMs)
        end)

    end
end
