KA = {}
KA.init = false
KA.isYandir = false
KA.isVrol = false
KA.isFalgravn = false
KA.AbilityIDs = {
    HealingFumes = 140255,
    Infuse = 137289,
    Claw = 132424,
    SanguineGrasp = 136965,
    Frenzy = 136953,
    FirstFloorBreak = 135271,
    SecondFloorBreak = 136727,
    BloodCleave = 136976,
    Hemorrhage = 132934,
    QuickStrike = 136958,
}

KA.LastFrenzy = 0
KA.LastGrasp = 0
KA.LastHemorrhage = 0
KA.InterrptIDs = {}

KA.Positions = {
    [1] = {25297, 14569, 9749}, -- M1
    [2] = {24633, 14569, 9696}, -- M2
    [3] = {25523, 14569, 10679}, -- M3
    [4] = {24507, 14569, 10585}, -- M4
    [5] = {25975, 14569, 9701}, -- R1
    [6] = {24632, 14569, 9188}, -- R2
    [7] = {25429, 14569, 9163}, -- R3
    [8] = {24105, 14569, 9427}, -- R4
    [9] = {25971, 14569, 10308}, -- H1
    [10] = {24002, 14569, 10280} -- H2

}

KA.PlayerPos = {
    ["@FlaminDemigod"] = 10,
    ["@Solowith"] = 9,
    ["@FALK24680"] = 5,
    ["@JackRazor"] = 6,
    ["@haruna742"] = 3,
    ["@Noneatza"] = 2,
    ["@para285"] = 7,
    ["@Siegfried24"] = 8,
    ["@Tisi214"] = 1,
    ["@KS_Amt38"] = 4
}

function KA.Reset()
    CFMUtilsKALabel1:SetHidden(true)
    CFMUtilsKALabel1Value:SetHidden(true)
    CFMUtilsKALabel2:SetHidden(true)
    CFMUtilsKALabel2Value:SetHidden(true)
    if KA.Pos then
        OSI.DiscardPositionIcon(KA.Pos)
    end
    KA.Pos = nil
end

function KA.CombatUpdate()
    local currentTargetHP, maxTargetHP, _ = GetUnitPower("boss1", POWERTYPE_HEALTH)
    if not IsUnitInCombat("player") then
        cfmutils.Debug("player out of combat, current boss health percentage at :"..(currentTargetHP/maxTargetHP))
        if not (currentTargetHP/maxTargetHP < 0.98) then
            KA.Reset()
            KA.LastFrenzy = 0
            KA.LastGrasp = 0
            KA.LastHemorrhage = 0
        end
    else
        cfmutils.Debug("player entered combat, current boss health percentage at :"..(currentTargetHP/maxTargetHP))
    end
end

function KA.AbilityTracker(e, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId, overflow)
    if IsUnitInCombat("player") then
        local _, _, isTank = GetGroupMemberRoles("player")
        --Trash
        if abilityId == KA.AbilityIDs.Infuse then
            cfmutils.Debug("Vampire Infuser casts Infuse. Result = "..result..", HitValue = "..hitValue..", SourceName = "..sourceName)
            if cfmutils.savedVars.KynesTrackInfuse and result == ACTION_RESULT_BEGIN then
                cfmutils.Debug("CCA Tracking infuse")
                local id = CombatAlerts.CastAlertsStart(abilityId, "Vampire Infuser", hitValue, CombatAlerts.vars.maxCastMS, { 1, 0.7, 0, 0.5 }, {hitValue, "Interrupt", 0.8, 0, 0, 0.9, SOUNDS.CHAMPION_POINTS_COMMITTED})
            end
        --Vrol
        elseif abilityId == KA.AbilityIDs.HealingFumes then
            cfmutils.Debug("Apothecary casts Healing Fumes. Result = "..result..", HitValue = "..hitValue..", SourceName = "..sourceName)
            if cfmutils.savedVars.KynesTrackHealingFumes and result == ACTION_RESULT_BEGIN then
                cfmutils.Debug("CCA Tracking Healing Fumes")
                local id = CombatAlerts.CastAlertsStart(abilityId, "Half-Giant Apothecary", hitValue, CombatAlerts.vars.maxCastMS, { 1, 0.7, 0, 0.5 }, {hitValue, "Interrupt", 0.8, 0, 0, 0.9, SOUNDS.CHAMPION_POINTS_COMMITTED})
                KA.InterrptIDs[sourceUnitId] = id 
            elseif cfmutils.savedVars.KynesTrackHealingFumes and result == ACTION_RESULT_EFFECT_FADED then
                cfmutils.Debug("Healing Fumes interrupt registered")
                CombatAlerts.CastAlertsStop(KA.InterrptIDs[sourceUnitId])
                table.remove(KA.InterrptIDs, sourceUnitId)
            end
        -- Falgravn
        elseif abilityId == KA.AbilityIDs.Frenzy then
            local currentTargetHP, maxTargetHP, _ = GetUnitPower("boss1", POWERTYPE_HEALTH)
            if (currentTargetHP/maxTargetHP) > 0.4 then   
                cfmutils.Debug("Lt.Njordal casts Blood Frenzy. Result = "..result..", HitValue = "..hitValue..", SourceName = "..sourceName)
                KA.LastFrenzy = GetGameTimeSeconds()
            end
        elseif abilityId == KA.AbilityIDs.SanguineGrasp then
            cfmutils.Debug("Lt.Njordal casts Sanguine Grasp. Result = "..result..", HitValue = "..hitValue..", SourceName = "..sourceName)
            KA.LastGrasp = GetGameTimeSeconds()
        elseif abilityId == KA.AbilityIDs.BloodCleave and  targetType ~= COMBAT_UNIT_TYPE_PLAYER and cfmutils.savedVars.KynesBloodCleave then
            local options = CombatAlertsData.dodge.ids[abilityId]
            local offset = options.offset or 0
			local id = CombatAlerts.AlertCast(abilityId, sourceName, hitValue + offset, options)
        elseif abilityId == KA.AbilityIDs.FirstFloorBreak then
            cfmutils.Debug("Lord Falgravn casts Channel on the Conduits. Result = "..result..", HitValue = "..hitValue..", SourceName = "..sourceName)
            KA.Reset()
            if cfmutils.savedVars.KynesPositionOveride then
                KA.Pos = OSI.CreatePositionIcon(KA.Positions[cfmutils.savedVars.KynesPosition][1],
                    KA.Positions[cfmutils.savedVars.KynesPosition][2],
                    KA.Positions[cfmutils.savedVars.KynesPosition][3], 
                    cfmutils.savedVars.MarkerStyle,
                    OSI.GetIconSize() * cfmutils.savedVars.MarkerSize, 
                    cfmutils.savedVars.MarkerColor, 
                    cfmutils.savedVars.MarkerOffset, 
                    function(data) 
                        data.color = cfmutils.savedVars.MarkerColor
                        data.size= OSI.GetIconSize() * cfmutils.savedVars.MarkerSize
                        data.offset = cfmutils.savedVars.MarkerOffset + cfmutils.savedVars.MarkerBob*math.sin( GetGameTimeMilliseconds() / 1000 * 2 )
                    end)
            else
                KA.Pos = OSI.CreatePositionIcon(KA.Positions[KA.PlayerPos[GetDisplayName()]][1],
                    KA.Positions[KA.PlayerPos[GetDisplayName()]][2], KA.Positions[KA.PlayerPos[GetDisplayName()]][3],
                    cfmutils.savedVars.MarkerStyle,
                    OSI.GetIconSize() * cfmutils.savedVars.MarkerSize, 
                    cfmutils.savedVars.MarkerColor, 
                    cfmutils.savedVars.MarkerOffset,
                    function(data) 
                        data.color = cfmutils.savedVars.MarkerColor
                        data.size= OSI.GetIconSize() * cfmutils.savedVars.MarkerSize
                        data.offset = cfmutils.savedVars.MarkerOffset + cfmutils.savedVars.MarkerBob*math.sin( GetGameTimeMilliseconds() / 1000 * 2 )
                    end)
            end
        elseif abilityId == KA.AbilityIDs.Hemorrhage then
            cfmutils.Debug("Falgravn casts Hemorrhage. Result = "..result..", HitValue = "..hitValue..", SourceName = "..sourceName)
            KA.LastHemorrhage = GetGameTimeSeconds()
        elseif abilityId == KA.AbilityIDs.SecondFloorBreak then
            cfmutils.Debug("Lord Falgravn casts Floor Break MID. Result = "..result..", HitValue = "..hitValue..", SourceName = "..sourceName)
            KA.LastHemorrhage = 0
            KA.Reset()
        elseif abilityId == KA.AbilityIDs.QuickStrike and targetType == COMBAT_UNIT_TYPE_PLAYER and not isTank then
            cfmutils.Debug("Torturer casts Quick Strike. Result = "..result..", HitValue = "..hitValue..", SourceName = "..sourceName)
            local options = { -2, 2 }
            local offset = 0
			local id = CombatAlerts.AlertCast(abilityId, sourceName, hitValue + offset, options)
        elseif abilityId == KA.AbilityIDs.Claw and targetType == COMBAT_UNIT_TYPE_PLAYER and not isTank then
            cfmutils.Debug("Lord Falgraven casts Claw. Result = "..result..", HitValue = "..hitValue..", SourceName = "..sourceName)
			local id = CombatAlerts.AlertCast(abilityId, sourceName, hitValue)
        end
    end
end

function KA.OnCFMUtilsKAMove()
    cfmutils.savedVars.KALeft = CFMUtilsKA:GetLeft()
    cfmutils.savedVars.KATop = CFMUtilsKA:GetTop()
end

function KA.RestorePosition()
    if cfmutils.savedVars.KALeft ~= nil then
        CFMUtilsKA:ClearAnchors()
        CFMUtilsKA:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, cfmutils.savedVars.KALeft, cfmutils.savedVars.KATop)
    end
end

function KA.UpdateTick(gameTimeMs)
    if not IsUnitInCombat("player") then
        return
    end
    -- Timers
    local timeSec = GetGameTimeSeconds()
    local deltaSanguine = 0
    local deltaFrenzy = 0
    local deltaHemorrhage = 0
    if cfmutils.savedVars.KynesTrackMini then 
        --Sanguine Grasp
        deltaSanguine = 55 - (timeSec - KA.LastGrasp)
        if deltaSanguine < 10 then
            CFMUtilsKALabel1Value:SetColor(1, 0, 0, 1)
        else
            CFMUtilsKALabel1Value:SetColor(0, 0.8, 0.8, 1)
        end
        if deltaSanguine > 0 then
            CFMUtilsKALabel1:SetHidden(false)
            CFMUtilsKALabel1Value:SetHidden(false)
            local txtDuration = tostring(string.format("%.0f", deltaSanguine))
            CFMUtilsKALabel1Value:SetText(txtDuration .. "s")
            CFMUtilsKALabel1:SetText("Next Sanguine Grasp:")
        else
            CFMUtilsKALabel1Value:SetText("Soon")
        end
        --Blood Frenzy
        deltaFrenzy = 55 - (timeSec - KA.LastFrenzy)
        if deltaFrenzy < 10 then
            CFMUtilsKALabel2Value:SetColor(1, 0, 0, 1)
        else
            CFMUtilsKALabel2Value:SetColor(0, 0.8, 0.8, 1)
        end
        if deltaFrenzy > 0 then
            CFMUtilsKALabel2:SetHidden(false)
            CFMUtilsKALabel2Value:SetHidden(false)
            CFMUtilsKALabel2:SetText("Next Blood Frenzy:")
            local txtDuration = tostring(string.format("%.0f", deltaFrenzy))
            CFMUtilsKALabel2Value:SetText(txtDuration .. "s")
        else
            CFMUtilsKALabel2Value:SetText("Soon")
        end
    end
    --Hemorrhage
    if deltaSanguine <= 0 and cfmutils.savedVars.KynesTrackHemorrhage then
        deltaHemorrhage = 80 - (timeSec - KA.LastHemorrhage)
        if deltaHemorrhage < 10 then
            CFMUtilsKALabel1Value:SetColor(1, 0, 0, 1)
        else
            CFMUtilsKALabel1Value:SetColor(0, 0.8, 0.8, 1)
        end
        if deltaHemorrhage > 0 then
            CFMUtilsKALabel1:SetHidden(false)
            CFMUtilsKALabel1Value:SetHidden(false)
            CFMUtilsKALabel1:SetText("Next Blood Hemorrhage:")
            local txtDuration = tostring(string.format("%.0f", deltaHemorrhage))
            CFMUtilsKALabel1Value:SetText(txtDuration .. "s")
        else
            CFMUtilsKALabel1Value:SetText("Soon")
        end
    end
end

function KA.BossDeactivate()
    KA.Reset()
    KA.isYandir = false
    KA.isVrol = false
    KA.isFalgravn = false
end

function KA.BossesChanged()
    boss = GetUnitName("boss1")
    if boss and boss == "Yandir the Butcher" then
        cfmutils.Debug("At Yandir")
        KA.isYandir = true
        --Does Nothing atm
    elseif boss and boss == "Captain Vrol" then
        cfmutils.Debug("At Vrol")
        KA.isVrol = true
        --Does Nothing atm
    elseif boss and boss == "Lord Falgravn" then
        cfmutils.Debug("At Falgravn")
        KA.isFalgravn = true
    elseif not boss then 
        cfmutils.Debug("No Bosses Here")
        KA.BossDeactivate()
    end

end

function cfmutils.KADeactivate() 
    if KA.init then
        cfmutils.Debug("KA Module Unloaded. You live to see another day")
        KA.init = false
        KA.BossDeactivate()
        KA.Reset()
        
    end
end

function cfmutils.KAActivate()
    if not KA.init then
        cfmutils.Debug("KA Module Loaded. Danger ahead")
        KA.init = true
        KA.BossesChanged()
        KA.RestorePosition()
        cfmutils.EM:RegisterForEvent(cfmutils.name .. "bossChanged", EVENT_BOSSES_CHANGED, KA.BossesChanged)
        cfmutils.EM:RegisterForEvent(cfmutils.name .. "CombatUpdate", EVENT_PLAYER_COMBAT_STATE, KA.CombatUpdate)
        cfmutils.EM:RegisterForEvent(cfmutils.name .. "AbilityTracker", EVENT_COMBAT_EVENT, KA.AbilityTracker)
        cfmutils.EM:RegisterForUpdate(cfmutils.name .. "UpdateTick", 1000 / 10, function(gameTimeMs)
            KA.UpdateTick(gameTimeMs)
        end)
    end
end
