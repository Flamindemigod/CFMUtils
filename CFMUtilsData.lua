cfmutils = cfmutils or {}

cfmutils.name = "CarriesForMemesGroupUtils"
cfmutils.varsName = "CarriesForMemesGroupUtilsVars"
cfmutils.version = "1.4.1"
cfmutils.variableVersion = 1

cfmutils.damageEvents = {
	[ACTION_RESULT_DAMAGE] = true,
	[ACTION_RESULT_CRITICAL_DAMAGE] = true,
	[ACTION_RESULT_BLOCKED_DAMAGE] = true,
	[ACTION_RESULT_DOT_TICK] = true,
	[ACTION_RESULT_DOT_TICK_CRITICAL] = true,
}

cfmutils.zones = {
	-- TRIALS
	["Hel Ra Citadel"] = 636,
	["Aetherian Archive"] = 638,
	["Sanctum Ophidia"] = 639,
	["Maw of Lorkhaj"] = 725,
	["Halls of Fabrication"] = 975,
	["Asylum Sanctorium"] = 1000,
	["Cloudrest"] = 1051,
	["Sunspire"] = 1121,
	["Kyne's Aegis"] = 1196,
	["Rockgrove"] = 1263,
	["Dreadsail Reef"] = 1344,
}

cfmutils.defaults = {
	enabled = true,
	debugValid = false,
	debugEnabled = false,
	debugLog = {},
	MarkerStyle = "CarriesForMemesGroupUtils/Icons/Misc/arrow0.dds",
	MarkerSize = 1,
	MarkerOffset = 0,
	MarkerBob = 0,
	MarkerColor = { 1, 1, 1 },
	ArrowStyle = "CarriesForMemesGroupUtils/Icons/Misc/invarrow0.dds",
	ArrowSize = 0.3,
	ArrowColor = { 1, 1, 1 },
	AsylumTrackMini = false,
	AsylumShowKite = false,
	AsylumLane = 1,
	AsylumLaneAlwaysShowStart = false,
	KynesTrackInfuse = false,
	KynesTrackHealingFumes = false,
	KynesBloodCleave = false,
	KynesPositionOveride = false,
	KynesPosition = 1,
	KynesTrackMini = false,
	KynesTrackHemorrhage = false,
	customCommands = {},
}

cfmutils.MarkerSelection = {
	"CarriesForMemesGroupUtils/Icons/Misc/arrow0.dds",
	"CarriesForMemesGroupUtils/Icons/Misc/arrow1.dds", --    "CarriesForMemesGroupUtils/Icons/Misc/arrow2.dds",
}
cfmutils.ArrowSelection = {
	"CarriesForMemesGroupUtils/Icons/Misc/invarrow0.dds",
	"CarriesForMemesGroupUtils/Icons/Misc/invarrow1.dds",
}

cfmutils.ToxicText = {
	"Dies from cringe",
	"Is Solo lagging again??",
	"What about healing?",
	"Skill Issue",
	"Maybe its time for a smokebreak",
	"You die more than *that* necro tank",
	"Maybe you should gold out that gear",
	"Your corpse is para's favorite parsing spot",
	"Another one for the tbag counter",
	"More time to shittalk when you're dead I guess",
	"Do you know how low is low?",
	"Guess Solo couldn't outheal it",
	"Did you try looking at sky?",
	"Did you know res ult is a spammable?",
	"Do it for Sjobacka, or i guess not?",
	"Time to get action points i guess",
	"You cant have sustain if you're dead",
	"Maybe one day you get featured in tisi's meme vid",
	"Fuck this game",
	"Rem is best girl. You cant change my mind",
	"Do i have to add more mechs to the addon?",
	"Is your gear golded? if not thats why you died",
	"If you dont have stamina just dodgeroll",
	"пиздец",
	"Who needs vitality when you have family",
	"Reset Timeeee",
	"When in doubt, Block",
	"Even Scarlet deals more damage than you",
	"Even Scarlet will have more trifectas than you at this rate",
	"If you dont have enough braincells to read the notificationcs, why play with addons?",
	"The day you know how to play this game is the day Solo gets max cp",
	"The difference between a trifecta and reset is you",
	"If its dead it cant enrage",
	"Stop playing like a 3 year old monkey, or play like Harambe at least ppl remember him",
	"Is it taunted? Is it not? Only the game knows",
	"If i wanted to suffer all day i would join DV and argue about spam in the spam channel",
	"When God created the world he put all the misery into you",
	"You gonna blame the taunt again?",
	"Is block bugged for you?",
	"Everytime you die, a tree gets a heartattack",
	"Just block it wym",
	"Fuuuuccccck",
	"Zeit fürn bier",
	"The only reason you can breathe is because your brain takes it over",
	"You're the reason I have to buy pots",
	"If I got a gold for every death, I would still be poor because I have to buy pots",
	"You're just like the luna moth, useless and die instantly",
	"Where is your 100k parse now?",
	"Stop sucking, you aint get paid for this (yet)",
	"You know the goal of a trifecta is to not die, right?",
	"Solo, Bus bauen",
	"Your Mums a ho",
	"Did you try playing Stamplar?",
	"Stamplar looks good on you",
	"With that damage you should join Greenbloods",
	"Do you have the geh?",
	"Why are you geh?",
	"You should join Dragon Void that place is less dead than you",
	"Maybe you should take the dating approach with the Boss atleast then maybe you wont be a burdern. Maybe.",
	"Why are you dying?",
	"Don't stand in the middle of nowhere if you expect to get healed",
	"Blame the healers",
	"The only person to blame here is your parents for having you",
	"Did you block?",
	"Not enough Colos?",
	"Why are you even dd when you're on the ground 24/7. Should have choosen Carpet",
	"Soooo, About that Disband....",
	"You need to dodge that",
	"Its this time again huh",
	"Watch out. Para's headphones are flying again",
	"Why are we raiding again?",
	"Maybe should get Scarlet to Zen next time",
	"Maybe I need to add you to the ignore list",
	"Absolutely Useless",
	"Another Day Another Suffering",
	"Have you tried to play better",
}

cfmutils.ToxicTextAS = {
	"Focus the Kite",
	"Woo Disco Cone",
	"Were the Minis healty bois?",
	"You know it would be faster to kill boss if you killed protectors right?",
	"Maybe you wanna go carpet at the back? atleast then you'd be useful",
	"Did you die to envionmental damage? Doesnt matter just say you did",
	"Maybe 98% Stagger isnt worth the boss break dancing",
	"Shield Weave bis btw",
}

cfmutils.ToxicTextKA = {
	"Kill the Fog",
	"Careful Cleave, oh wait you're already dead",
	"Interrupt the shit",
	"Maybe one day we'd win a 1vX Stormcaller",
	"Damage is the number one killer in vka",
	"If the bulwark can deal damage, why cant you?",
	"rush vrol cyka blyat",
	"Did you lose some braincells during the last cleave?",
	"Interrupt the Apothecary, or dont, idc",
	"Focus Wonka. Wait you cant.",
	"Did the instability roast your brain or something?",
	"The hands from noodle are not your hentai imagination",
}

cfmutils.ToxicTextRG = {
	"BOOM",
	"STRIKE!!",
	"Try to kill the frogs next time",
	"Guess no PB for para",
	"Dodge the shield bruh. You cant do that if you're on the ground",
	"You're never gonna get to Xalvakka at this rate",
	"Did you stand in poison?",
	"Barto managed to get PB, how are you worse than him",
	"Is this a 14min Bahsei?",
	"Even Tonje has RG hm. And you dont",
}

cfmutils.ToxicTextPlayer = {
	["@FlaminDemigod"] = {
		"Imagine having mag",
		"You cant get good uptimes if you're dead you know",
		"You know what damage cant fix? you being carpet",
		"Time to mute yourself?",
	},
	["@FALK24680"] = {
		"Maybe its time to go back into Cyrodiil",
		"How'd you get Emp when you dead so much?",
		"Sorc go brrrrr. oh wait you're dead",
		"Where cleave?",
	},
	["@Rrebz101"] = {
		"Where llothis interrupt?",
		"Time to change to bi stat food?",
		"Next IR when?",
	},
	["@haruna742"] = {
		"Time to read some BL i guess",
		"Where ec uptimes?",
		"Maybe you should have shielded that",
	},
	["@Noneatza"] = {
		"Time to take a shit on the carpet",
		"Get the poland destroyer out and maybe take out ZOS's servers to hide your shame",
		"No sucky sucky for you if you dead",
		"Where MK uptimes with 100k ST?",
		"Do i need to make Jojo memes for you to not be bad?",
		"Shooting Star > Ice Comet",
		"Maybe you should spend more time humping the dummy then the ground",
		"Send a dick pick to ZOS",
	},
	["@para285"] = {
		"Rage after raid okay?",
		"Stop being bad",
		"Go watch some hentai to cool off",
		"What?",
		"Dont smash your keyboard",
		"do /w @flamindemigod okay?",
		"Hallo no sustain para, sustain requires you to be alive",
	},
	["@Siegfried24"] = {
		"Go play Genshin",
		"Stop being mad coz you're German",
		"You dyin is fine. not like you contributed any dmg anyways",
		"No point in doing brittle if you gonna be dead",
		"Should have gotten the major protection ult",
	},
	["@Tisi214"] = {
		"RIP 100k ST parse",
		"Guess you got some time to work on your next meme video",
		"Where Z'en uptimes?",
		"You can run backyard on Z'en DK right?",
	},
	["@HamsterPincher"] = {
		":hamsterclown:",
		"Time to spin the Hamster Wheel",
		"Taken the fookin laser on the fookin sphere",
	},
	["@looc2212"] = {
		"как ты умер?",
		"You shouldn't be dying, but in case you do. Just blame Solo",
		"There cant be damage without a tank you know",
		"Once a tank main always a tank main",
	},
	["@Huku223"] = {
		"One day Huku will be melee. But today he just carpet",
		"KEKW",
		"So much for buffing Huku",
		"Looks like you got nerfed to carpet",
		"Why cant you be normal and just interrupt?",
		"You can never be P2W, if you always lose",
		"Your DPS gets cut in half without ESO+",
		"Maybe you should go back to tanking",
	},
}
local cachedCakeId

local function GetJubileeCakeCollectibleId()
	if not cachedCakeId then
		local categoryData = ZO_COLLECTIBLE_DATA_MANAGER:GetCategoryDataById(TOOLS_CATEGORY_ID)
		local numCollectibles = categoryData:GetNumCollectibles()
		if numCollectibles > 0 then
			cachedCakeId = categoryData:GetCollectibleDataByIndex(numCollectibles):GetId()
		end
	end
	return cachedCakeId
end

local function SlashCollectible(id)
	local HousingBlacklist = {
		--Assistants
		[267] = true, --Tythis Andromo, the Banker
		[300] = true, --Pirharri the Smuggler
		[301] = true, --Nuzhimeh the Merchant
		[396] = true, --Allaria Erwen the Exporter
		[397] = true, --Cassus Andronicus the Mercenary
		[6376] = true, --Ezabi the Banker
		[6378] = true, --Fezez the Merchant
		[8994] = true, --Baron Jangleplume, the Banker
		[8995] = true, --Peddler of Prizes, the Merchant
		[9743] = true, --Factotum Property Steward
		[9744] = true, --Factotum Commerce Delegate
		[11056] = true, --Hoarfrost, Takubar Trader
		[11097] = true, --Pyroclast, Infernace Conservator
		[12413] = true, --Eri, Barking Banker
		[12414] = true, --Xyn, Planar Purveyor
		[13066] = true, --Terilorne, Dibellan Freetrader
		[13517] = true, --Celia Tyde, Lost Fleet Bursar

		--Armory Assistants
		[9745] = true, --Ghrasharog, Armory Assistant
		[10618] = true, --Zuqoth, Armory Advisor
		[13518] = true, --Voko, Carnaval Weapondancer
		--Deconstruction Assistants
		[10184] = true, --Giladil the Ragpicker
		[10617] = true, --Aderene, Fargrave Dregs Dealer
		[11876] = true, --Drinweth, Valenwood Armorer
		[11877] = true, --Tzozabrar, Dwarven Deconstructor
		[13063] = true, --Siluruz, Realm Craftsmaster
		[14018] = true, --Pontius Remus, Lupine Scavenger

		--Companions
		[9245] = true, --Bastian Hallix
		[9353] = true, --Mirri Elendis
		[9911] = true, --Ember
		[9912] = true, --Isobel Veloise
		[11113] = true, --Sharp-as-Night
		[11114] = true, --Azandar al-Cybiades
		[12173] = true, --Zerith-var
		[12172] = true, --Tanlorin
	}
	if id == nil or id == "" or id == 1 then
		cfmutils.Debug("Id provided is not a valid collectible id")
		return
	end
	if IsInImperialCity() or IsPlayerInAvAWorld() or IsActiveWorldBattleground() then
		cfmutils.Debug("Player is currently in a PvP instance. Cannot use collectible")
		return nil
	end
	local currentHouse = GetCurrentZoneHouseId()
	if HousingBlacklist[id] ~= nil and currentHouse ~= nil and currentHouse > 0 then
		cfmutils.Debug(string.format("Cannot use %s within a house", GetCollectibleName(id)))
		return nil
	end
	if not IsCollectibleUnlocked(id) then
		cfmutils.Debug(string.format("Cannot use %s as you dont have it unlocked", GetCollectibleName(id)))
		return nil
	end
	UseCollectible(id, GAMEPLAY_ACTOR_CATEGORY_PLAYER)
end

cfmutils.SlashCommands = {
	["/home"] = {
		title = "Home",
		desc = "Teleport To Primary Residence",
		help = '/home ["inside" | "outside"]',
		exec = function(option)
			if option and option ~= "" and (option ~= "inside" and option ~= "outside") then
				cfmutils.Debug("Warn: /home [opt] expects `inside` or `outside` as the optional arg. Got " .. option)
				option = nil
			end
			if IsUnitInCombat("player") then
				cfmutils.Debug("Player is currently in combat. Cannot Port")
				return nil
			end
			if IsInImperialCity() or IsPlayerInAvAWorld() or IsActiveWorldBattleground() then
				cfmutils.Debug("Player is currently in a PvP instance. Cannot Port")
				return nil
			end
			local primaryHouse = GetHousingPrimaryHouse()
			if primaryHouse == 0 then
				cfmutils.Debug("Player does not have a primary residence set")
				return nil
			end
			option = option or "inside"
			RequestJumpToHouse(primaryHouse, option == "outside")
			cfmutils.Debug("Porting to Primary Residence " .. (option == "outside" and "(Outside)" or "(Inside)"))
		end,
	},
	["/setprimaryhome"] = {
		title = "Set Primary Home",
		desc = "Sets the current house as the player's primary residence",
		help = "/setprimaryhome",
		exec = function()
			local currentHouse = GetCurrentZoneHouseId()
			if currentHouse == nil or currentHouse <= 0 then
				cfmutils.Debug("Currenltly not in a house")
				return nil
			end
			if not IsOwnerOfCurrentHouse() then
				cfmutils.Debug("This house isnt yours. Cannot set it as primary")
				return nil
			end
			if IsPrimaryHouse(currentHouse) then
				cfmutils.Debug("You already have this house as your primary residence")
				return nil
			end
			SetHousingPrimaryHouse(currentHouse)
			cfmutils.Debug(string.format("Set %s as primary residence", GetPlayerActiveZoneName()))
		end,
	},
	["/trade"] = {
		title = "Trade",
		desc = "Trade with user",
		help = "/trade <@username>",
		exec = function(option)
			if option == nil or option == "" then
				cfmutils.Debug("Warn: /trade <@username> expects a username to be provided")
				return nil
			end
			TradeInviteByName(option)
		end,
	},
	["/banker"] = {
		title = "Banker",
		desc = "Summon Banker",
		help = "/banker",
		exec = function()
			SlashCollectible(6376)
		end,
	},
	["/bank"] = {
		title = "Banker",
		desc = "Summon Banker",
		help = "/bank",
		exec = function()
			SlashCollectible(6376)
		end,
	},
	["/merchant"] = {
		title = "Merchant",
		desc = "Summon Merchant",
		help = "/merchant",
		exec = function()
			SlashCollectible(6378)
		end,
	},
	["/sell"] = {
		title = "Merchant",
		desc = "Summon Merchant",
		help = "/sell",
		exec = function()
			SlashCollectible(6378)
		end,
	},
	["/fence"] = {
		title = "Fence",
		desc = "Summon Pirharri the Smuggler",
		help = "/fence",
		exec = function()
			SlashCollectible(300)
		end,
	},
	["/cake"] = {
		title = "Cake",
		desc = "Spawn Jubilee Cake",
		help = "/cake",
		exec = function()
			SlashCollectible(GetJubileeCakeCollectibleId())
		end,
	},
	["/leavegroup"] = {
		title = "Leave Group",
		desc = "Leave the current group",
		help = "/leavegroup",
		exec = GroupLeave,
	},
	["/eye"] = {
		title = "Antiquarian's Eye",
		desc = "Use the Antiquarian's Eye",
		help = "/eye",
		exec = function()
			SlashCollectible(8006)
		end,
	},
	-- ["/template"] = {
	--     title = "Template",
	--     desc =  "Template Description",
	--     help = "/template ...",
	--     exec = function(option)
	--         return nil
	--     end
	-- },
}
