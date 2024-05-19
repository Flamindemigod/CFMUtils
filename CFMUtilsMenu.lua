cfmutils = cfmutils or { }

function cfmutils.buildMenu()
    local ArrowEnabled = false
    local AsylumShowUI = false
    local KynesShowUI = false
    local LaneConvert = {
        ["Lane 1"] = 1,
        ["Lane 2"] = 2,
        ["Lane 3"] = 3,
        ["Lane 4"] = 4,
        ["Lane 5"] = 5,
        ["Lane 6"] = 6,
        ["Lane 7"] = 7,
        ["Lane 8"] = 8,
    }
    local PositionConvert = {
        ["Melee 1"] = 1,
        ["Melee 2"] = 2,
        ["Melee 3"] = 3,
        ["Melee 4"] = 4,
        ["Ranged 1"] = 5,
        ["Ranged 2"] = 6,
        ["Ranged 3"] = 7,
        ["Ranged 4"] = 8,
        ["Heal 1"] = 9,
        ["Heal 2"] = 10,
        
    }

    
	local panelData = {
		type = "panel",
		name = "CarriesForMemesUtilites",
		displayName = "|cFF06E6Carries For Memes|r Group Utils",
		author = "|cFFA500FlaminDemigod|r",
		version = ""..cfmutils.version,
		registerForDefaults = true,
		registerForRefresh = true,
        slashCommand = "/cfm"
	}

	local options = {
		{
			type = "header",
			name = "Settings",
		},
		{
			type = "checkbox",
			name = "Enabled",
			tooltip = "Toggles the UI",
			default = cfmutils.defaults.enabled,
			getFunc = function() 
				return cfmutils.savedVars.enabled
			end,
			setFunc = function(value)
                cfmutils.Chat:Print("Addon "..(cfmutils.savedVars.enabled and "|caf0000Disabled|r" or "|c00a000Enabled|r" ))
				cfmutils.savedVars.enabled = value
				cfmutils.CheckActivation()
			end,
		},

        {
            type = "submenu",
            name = "Marker",
            controls = {
                {
                    type = "iconpicker",
                    name = "Marker Style",
                    width = "half",
                    maxColumns = 3,
                    visibleRows = 3,
                    iconSize = 56,
                    choices = cfmutils.MarkerSelection,
                    getFunc = function() return cfmutils.savedVars.MarkerStyle end,
                    setFunc = function(var) 
                        cfmutils.savedVars.MarkerStyle = var
                    end,

                },
                {
                    type = "colorpicker",
                    name = "Marker Color",
                    width = "half",
                    getFunc = function() return cfmutils.savedVars.MarkerColor[1], cfmutils.savedVars.MarkerColor[2], cfmutils.savedVars.MarkerColor[3] end,
                    setFunc = function(r, g, b) 
                        cfmutils.savedVars.MarkerColor[1] = r
                        cfmutils.savedVars.MarkerColor[2] = g
                        cfmutils.savedVars.MarkerColor[3] = b
                    end,
                    default = function() return cfmutils.defaults.MarkerColor[1], cfmutils.defaults.MarkerColor[2], cfmutils.defaults.MarkerColor[3] end,
                },
                {
                    type = "slider", 
                    name = "Marker Size",
                    tooltip = "Set Marker Size",
                    min = 0.5,
                    max = 10,
                    step = 0.5,
                    width = "half",
                    getFunc = function()
                        return cfmutils.savedVars.MarkerSize
                    end,
                    setFunc = function(value)
                        cfmutils.savedVars.MarkerSize = value
                    end,
                    default = cfmutils.defaults.MarkerSize,
                },
                {
                type = "slider", 
                name = "Marker Offset",
                tooltip = "Set base Marker Vertical Offset",
                min = 0,
                max = 10,
                step = 0.5,
                width = "half",
                getFunc = function()
                    return cfmutils.savedVars.MarkerOffset
                end,
                setFunc = function(value)
                    cfmutils.savedVars.MarkerOffset = value
                end,
                default = cfmutils.defaults.MarkerOffset,
                },
                {
                    type = "slider", 
                    name = "Marker Bob",
                    tooltip = "Set Marker Bob coefficent",
                    min = 0,
                    max = 1,
                    step = 0.1,
                    width = "half",
                    getFunc = function()
                        return cfmutils.savedVars.MarkerBob
                    end,
                    setFunc = function(value)
                        cfmutils.savedVars.MarkerBob = value
                    end,
                    default = cfmutils.defaults.MarkerBob,
                },
            },
        },
        {
            type = "submenu",
            name = "Arrow",
            controls = {
                {
                    type = "iconpicker",
                    name = "Arrow Style",
                    width = "half",
                    maxColumns = 3,
                    visibleRows = 3,
                    iconSize = 56,
                    choices = cfmutils.ArrowSelection,
                    default = cfmutils.defaults.ArrowStyle,
                    getFunc = function() return cfmutils.savedVars.ArrowStyle end,
                    setFunc = function(var) 
                        cfmutils.savedVars.ArrowStyle = var
                        cfmutils.UpdateArrowStyle()
                    end,
                },
                {
                    type = "colorpicker",
                    name = "Arrow Color",
                    width = "half",
                    getFunc = function() return cfmutils.savedVars.ArrowColor[1], cfmutils.savedVars.ArrowColor[2], cfmutils.savedVars.ArrowColor[3] end,
                    setFunc = function(r, g, b) 
                        cfmutils.savedVars.ArrowColor[1] = r
                        cfmutils.savedVars.ArrowColor[2] = g
                        cfmutils.savedVars.ArrowColor[3] = b
                    end,
                    default = function() return cfmutils.defaults.ArrowColor[1], cfmutils.defaults.ArrowColor[2], cfmutils.defaults.ArrowColor[3] end,
                },
                {
                    type = "slider", 
                    name = "Arrow Size",
                    tooltip = "Set Arrow Size",
                    min = 0.1,
                    max = 1,
                    step = 0.1,
                    width = "half",
                    getFunc = function()
                        return cfmutils.savedVars.ArrowSize
                    end,
                    setFunc = function(value)
                        cfmutils.savedVars.ArrowSize = value
                    end,
                    default = cfmutils.defaults.ArrowSize,
                },
                {
                    type = "button",
                    name = "Toggle Arrow Preview",
                    width = "half",
                    func = function()
                        ArrowEnabled = not ArrowEnabled
                        cfmutils.Chat:Print("Arrow "..(ArrowEnabled and "|c00a000Shown|r" or "|caf0000Hidden|r"))
                        if ArrowEnabled then
                            LibSimpleArrow.ShowArrow()
                        elseif not ArrowEnabled then
                            LibSimpleArrow.HideArrow()
                        end
                        end,
                }
            },
        },
        {
            type = "header",
            name = "Trial Specific",
        },
        {
            type = "submenu",
            name = "Asylum Sanctorium",
            controls = {
                {
                    type = "checkbox",
                    name = "Track Mini Health",
                    tooltip = "Enable/Disable Custom UI Element with Mini Health",
                    width = "half",
                    default = cfmutils.defaults.AsylumTrackMini,
                    getFunc = function() return cfmutils.savedVars.AsylumTrackMini end,
                    setFunc = function (var) 
                        cfmutils.savedVars.AsylumTrackMini = var                         
                    end,
                },
                {
                    type = "checkbox",
                    name = "Move UI",
                    tooltip = "Show/Hide UI Elements for Tracking Mini Health and Timers",
                    width = "half",
                    default = false,
                    getFunc = function() return AsylumShowUI end,
                    setFunc = function (var) 
                        AsylumShowUI = var    
                        if var == true then 
                            AS.RestorePosition()
                            CFMUtilsASLabel1:SetHidden(false)
                            CFMUtilsASLabel1Value1:SetHidden(false)
                            CFMUtilsASLabel1Value2:SetHidden(false)
                            CFMUtilsASLabel1Value3:SetHidden(false)
                            CFMUtilsASLabel2:SetHidden(false)
                            CFMUtilsASLabel2Value1:SetHidden(false)
                            CFMUtilsASLabel2Value2:SetHidden(false)
                            CFMUtilsASLabel2Value3:SetHidden(false) 
                        else 
                            AS.Reset() 
                        end
                    end,
                },
                {
                    type = "checkbox",
                    name = "Enable Kite Lanes",
                    tooltip = "Show Kite Paths",
                    width = "half",
                    default = cfmutils.defaults.AsylumShowKite,
                    getFunc = function() return cfmutils.savedVars.AsylumShowKite end,
                    setFunc = function (var) cfmutils.savedVars.AsylumShowKite = var
                    AS.Reset()
                    end,
                },
                {
                    type = "dropdown",
                    name = "Kite Lane",
                    tooltip = "Choose Storm of the Heavens kiting lane",
                    choices = {"Lane 1",
                    "Lane 2",
                    "Lane 3",
                    "Lane 4",
                    "Lane 5",
                    "Lane 6",
                    "Lane 7",
                    "Lane 8"},
                    width = "half",
                    getFunc = function()
                        for key, val in pairs(LaneConvert) do
                            if val == cfmutils.savedVars.AsylumLane then 
                                return key
                            end
                        end
                    end,
                    setFunc = function(var)
                        cfmutils.savedVars.AsylumLane = LaneConvert[var]
                        AS.Reset()
                    end,
                    default = cfmutils.defaults.AsylumLane
                },
                {
                    type = "checkbox",
                    name = "Always show Lane Start",
                    tooltip = "Always displays Lane start Marker",
                    width = "half",
                    default = cfmutils.defaults.AsylumLaneAlwaysShowStart,
                    getFunc = function() return cfmutils.savedVars.AsylumLaneAlwaysShowStart end,
                    setFunc = function (var) cfmutils.savedVars.AsylumLaneAlwaysShowStart = var
                    AS.Reset()
                    end,
                }
            },
        },
        {
            type = "submenu",
            name = "Kyne's Aegis",
            controls = {
                {
                    type = "header",
                    name = "Trash",
                },
                {
                    type = "checkbox",
                    name = "Track Infuse",
                    tooltip = "Adds interrupt tracker for Infuser's infuse cast",
                    width = "full",
                    default = cfmutils.defaults.KynesTrackInfuse,
                    getFunc = function() return cfmutils.savedVars.KynesTrackInfuse end,
                    setFunc = function (var) cfmutils.savedVars.KynesTrackInfuse = var end,
                },
                {
                    type = "header",
                    name = "Vrol",
                },
                {
                    type = "checkbox",
                    name = "Track Healing Fumes",
                    tooltip = "Adds interrupt tracker for Apothecary's Healing fumes",
                    width = "full",
                    default = cfmutils.defaults.KynesTrackHealingFumes,
                    getFunc = function() return cfmutils.savedVars.KynesTrackHealingFumes end,
                    setFunc = function (var) cfmutils.savedVars.KynesTrackHealingFumes = var end,
                },
                {
                    type = "header",
                    name = "Falgravn",
                },
                {
                    type = "checkbox",
                    name = "Track Mini Timers",
                    tooltip = "Adds Various Timers for Lieutenant Njordal",
                    width = "full",
                    default = cfmutils.defaults.KynesTrackMini,
                    getFunc = function() return cfmutils.savedVars.KynesTrackMini end,
                    setFunc = function (var) cfmutils.savedVars.KynesTrackMini = var
                        if var == false and not KynesShowUI then 
                            KA.Reset()
                        end
                    end,
                },
                {
                    type = "checkbox",
                    name = "Track Hemorrhage",
                    tooltip = "Tracks Blood Hemorrhage",
                    width = "full",
                    default = cfmutils.defaults.KynesTrackHemorrhage,
                    getFunc = function() return cfmutils.savedVars.KynesTrackHemorrhage end,
                    setFunc = function (var) 
                        cfmutils.savedVars.KynesTrackHemorrhage = var
                        if var == false and not cfmutils.savedVars.KynesShowUI then 
                            KA.Reset()
                        end
                        end,
                },
                {
                    type = "checkbox",
                    name = "Move UI",
                    tooltip = "Show/Hide UI Elements for Tracking Mini and Hemorrhage Timers",
                    width = "full",
                    default = false,
                    getFunc = function() return KynesShowUI end,
                    setFunc = function (var) 
                        KynesShowUI = var    
                        if var == true then 
                            KA.RestorePosition()
                            CFMUtilsKALabel1:SetHidden(false)
                            CFMUtilsKALabel1Value:SetHidden(false)
                            CFMUtilsKALabel2:SetHidden(false)
                            CFMUtilsKALabel2Value:SetHidden(false) 
                        else 
                            KA.Reset() 
                        end
                    end,
                },
                {
                    type = "checkbox",
                    name = "Track Blood Cleave",
                    tooltip = "Tracks Mini Blood Cleave Ability",
                    width = "full",
                    default = cfmutils.defaults.KynesBloodCleave,
                    getFunc = function() return cfmutils.savedVars.KynesBloodCleave end,
                    setFunc = function (var) cfmutils.savedVars.KynesBloodCleave = var end,
                },
                {
                    type = "checkbox",
                    name = "Override Default Smart Positioning",
                    tooltip = "Disables default positioning",
                    width = "half",
                    default = cfmutils.defaults.KynesPositionOveride,
                    getFunc = function() return cfmutils.savedVars.KynesPositionOveride end,
                    setFunc = function (var) cfmutils.savedVars.KynesPositionOveride = var
                    KA.Reset()
                    end,
                },
                {
                    type = "dropdown",
                    name = "Position",
                    tooltip = "Choose Position for Falgravn",
                    choices = {"Melee 1",
                    "Melee 2",
                    "Melee 3",
                    "Melee 4",
                    "Ranged 1",
                    "Ranged 2",
                    "Ranged 3",
                    "Ranged 4",
                    "Heal 1",
                    "Heal 2",},
                    width = "half",
                    getFunc = function()
                        for key, val in pairs(PositionConvert) do
                            if val == cfmutils.savedVars.KynesPosition then 
                                return key
                            end
                        end
                    end,
                    setFunc = function(var)
                        cfmutils.savedVars.KynesPosition = PositionConvert[var]
                        KA.Reset()
                    end,
                    default = cfmutils.defaults.KynesPosition
                },
            }
        },
	}
    if cfmutils.savedVars.debugValid then 
        options[#options + 1] = {
            type = "header",
            name = "Debug Settings",
            }
        options[#options + 1] = {
                    type = "checkbox",
                    name = "Debug",
                    tooltip = "Debug Mode",
                    width = "half",
                    default = cfmutils.defaults.debugEnabled,
                    getFunc = function() 
                        return cfmutils.savedVars.debugEnabled
                    end,
                    setFunc = function(value)
                        cfmutils.Chat:Print("Debug mode "..(cfmutils.savedVars.debugEnabled and "|caf0000Disabled|r" or "|c00a000Enabled|r" ))
                        cfmutils.savedVars.debugEnabled = value
                    end
                }
        options[#options + 1] = {
                    type = "button",
                    name = "Clear Debug Log",
                    warning = "Clears full debug log",
                    width = "half",
                    isDangerous =  true,
                    reloadRequired = true,
                    func = function()
                        cfmutils.savedVars.debugLog = {}
                    end
                }
    end
	LibAddonMenu2:RegisterAddonPanel(cfmutils.name.."Options", panelData)
	LibAddonMenu2:RegisterOptionControls(cfmutils.name.."Options", options)
end
