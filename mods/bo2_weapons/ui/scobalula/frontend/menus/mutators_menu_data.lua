-- /////////////////////////////////////////////////////////////////////////////////////////
--                             	Utility Functions
-- /////////////////////////////////////////////////////////////////////////////////////////

-- Sets Dvar Setting
local function SetDvarSetting(Arg0, DvarSetting, Arg2, DvarName, Arg4)
	UpdateInfoModels(DvarSetting)
	-- Have to validate value otherwise we keep notifying
	if DvarSetting.value ~= Engine.DvarInt(nil, DvarName) then
		Engine.SetDvar(DvarName, DvarSetting.value)
		Engine.ForceNotifyModelSubscriptions(Engine.CreateModel(Engine.CreateModel(Engine.GetGlobalModel(), "GametypeSettings"), "Update"))
	end
end

-- Builds a ranged setting
-- Min - Minimum Value
-- Max - Maximum Value
-- Prefix - Prefix to show on the UI (i.e. Round 1 instead of just 1) (Optional)
-- Suffix - Suffix to show on the UI (i.e. 5 Minutes instead of just 5) (Optional)
-- Initial - Initial Value (i.e. "Off" ) If set, 0 is used to indicate it (Optional)
-- Step - The step for each value (i.e. 5, 10, 15, 20, ....) (Optional)
-- Example: BuildRangedSetting(1, 100, "Round ", "", "Off")
local function BuildRangedSetting(Min, Max, Prefix, Suffix, Initial, Step)
	local Results = {}

	if Initial ~= nil then
		table.insert(
			Results,
			{
				option = Initial,
				value = 0,
				default = true
			})
	end

	for i = Min, Max, Step or 1 do
		table.insert(
			Results,
			{
				option = (Prefix or "") .. tostring(i) .. (Suffix or ""),
				value = i,
				default = (i == Min and Initial == nil)
			})
	end

	return Results
end

-- Builds a list of string settings
-- Values - A list of values (i.e. {"Test", "Interesting", "Cool"}) Must be an indexed table
-- Default Value - The default value in the table
-- Example - BuildStringSettings({"On", "Off"}, "On")
local function BuildStringSettings(Values, Default)
    local Results = {}

    for Index, Value in ipairs(Values) do
		table.insert(
			Results,
			{
				option = Value,
				value = Index,
				default = Value == Default
			})
    end

	return Results
end

local function BuildBoolSettings(Values, Default)
    local Results = {}
	
	table.insert(
			Results,
			{
				option = Values[1],
				value = 0,
				default = Values[1] == Default
			})
	table.insert(
			Results,
			{
				option = Values[2],
				value = 1,
				default = Values[2] == Default
			})

	return Results
end

-- Updates the Model
local function Update(arg0, arg1, arg2)
	if arg1.updateSubscription then
		arg1:removeSubscription(arg1.updateSubscription)
	end

	arg1.updateSubscription = arg1:subscribeToModel(
		Engine.CreateModel(Engine.CreateModel(Engine.GetGlobalModel(), "GametypeSettings"), "Update"),
		function() arg1:updateDataSource() end,
		false)
end

-- /////////////////////////////////////////////////////////////////////////////////////////
--                              Function Overrides
-- /////////////////////////////////////////////////////////////////////////////////////////


ResetGameSettings = function(arg0, arg1, arg2, arg3)
	Engine.SetGametype(Engine.DvarString(nil, "ui_gametype"))
	Engine.SetDvar("bot_maxFree", 0.000000)
	Engine.SetDvar("bot_maxAllies", 0.000000)
	Engine.SetDvar("bot_maxAxis", 0.000000)
	Engine.SetDvar("bot_difficulty", 1.000000)
	-- TODO: Look into looping over the datasource, or converting to tables,
	-- Treyarch have the luxury of using GameSettings that they can add to and then
	-- set it like above, we don't have that luxury, so this seems best way for now

	-- Reset Mutators Values
	Engine.SetDvar("mutator_double_packapunch", 0)
	Engine.SetDvar("mutator_phd_widows", 0)
	Engine.SetDvar("mutator_widowswine_existence", 0)
	Engine.SetDvar("mutator_bo_perk_icons", 0)
	Engine.SetDvar("mutator_deadshot_price", 0)
	Engine.SetDvar("mutator_enable_gobblegum", 0)
	Engine.SetDvar("mutator_ak47", 0)
	Engine.SetDvar("mutator_uzi", 0)
	Engine.SetDvar("mutator_aug", 0)
	Engine.SetDvar("mutator_claymore", 0)
	Engine.SetDvar("mutator_skorpion", 0)
	Engine.SetDvar("mutator_stoner63", 0)
	Engine.SetDvar("mutator_raygunmkii", 0)
	Engine.SetDvar("mutator_spacemonkey", 0)
	Engine.SetDvar("mutator_bo3_weapons", 0)
	Engine.SetDvar("mutator_bo3_rk5", 0)
	--Engine.SetDvar("mutator_bo3_l4_siege", 0)
	Engine.SetDvar("mutator_bo3_rpk", 0)
	Engine.SetDvar("mutator_bo3_ak74u", 0)
	Engine.SetDvar("mutator_bo3_galil", 0)
	Engine.SetDvar("mutator_bo3_m16", 0)
	Engine.SetDvar("mutator_bo3_m14", 0)
	--Engine.SetDvar("mutator_bo3_mx_garand", 0)
	--Engine.SetDvar("mutator_bo3_hg40", 0)
	Engine.SetDvar("mutator_bo3_mp40", 0)
	--Engine.SetDvar("mutator_bo3_ppsh", 0)
	--Engine.SetDvar("mutator_bo3_bootlegger", 0)
	--Engine.SetDvar("mutator_bo3_peacekeeper", 0)
	--Engine.SetDvar("mutator_bo3_marshal", 0)
	--Engine.SetDvar("mutator_bo3_razorback", 0)
	--Engine.SetDvar("mutator_bo3_banshii", 0)
	Engine.SetDvar("mutator_enfield", 0)
	Engine.SetDvar("mutator_crossbow", 0)
	Engine.SetDvar("mutator_ballistic_knife", 0)
	Engine.SetDvar("mutator_enable_wunderfizz", 0)
	--Engine.SetDvar("mutator_moon_random_char", 0)
	Engine.SetDvar("mutator_camo_disable", 0)
	Engine.SetDvar("mutuator_camo_black_ops", 0)
	Engine.SetDvar("mutator_camo_world_at_war", 0)
	Engine.SetDvar("mutator_camo_dark_matter", 0)
	Engine.SetDvar("mutuator_camo_ritual", 0)
	Engine.SetDvar("mutuator_camo_etching", 0)
	Engine.SetDvar("mutuator_camo_der_eisendrache", 0)
	Engine.SetDvar("mutuator_camo_overgrowth", 0)
	Engine.SetDvar("mutuator_camo_gorod_krovi", 0)
	Engine.SetDvar("mutuator_camo_revelations", 0)
	Engine.SetDvar("mutator_camo_kino", 0)
	Engine.SetDvar("mutuator_camo_origins", 0)
	Engine.SetDvar("mutator_scopeads", 0)
	Engine.SetDvar("mutator_camo_ingame_cycle", 0)
	Engine.SetDvar("mutator_declassified_ppsh", 0)
	Engine.SetDvar("mutator_declassified_mg42", 0)
	Engine.SetDvar("mutator_george_reward", 0)
	Engine.SetDvar("mutator_round_music", 0)
	Engine.SetDvar("mutator_camo_ice", 0)
	Engine.SetDvar("mutator_announcer", 0)
	Engine.SetDvar("mutator_wa2000", 0)
	Engine.SetDvar("mutator_psg1", 0)
	Engine.SetDvar("mutator_mystery_box_fx", 0)
	Engine.SetDvar("mutator_weapon_rest", 0)
	Engine.SetDvar("mutator_redphone", 0)
	Engine.SetDvar("mutator_doubletap", 0)
	Engine.SetDvar("mutator_doubletap_existence", 0)
	Engine.SetDvar("mutator_deadshot_existence", 0)
	Engine.SetDvar("mutator_eye_colour", 0)
	Engine.SetDvar("mutator_camo_weaponized_115", 0)
	Engine.SetDvar("mutator_waw_wall_weapons", 0)
	Engine.SetDvar("mutator_verruckt_springfield", 0)
	Engine.SetDvar("mutator_map_visionset", 0)
	Engine.SetDvar("mutator_shinonuma_perk", 0)
	Engine.SetDvar("mutator_sidestep", 0)
	Engine.SetDvar("mutator_ascension_visionset", 0)
	Engine.SetDvar("mutator_health_difficulty", 0)
	Engine.SetDvar("mutator_startingweapon", 0)
	Engine.SetDvar("mutator_revive_anim", 0)
	Engine.SetDvar("mutator_health_difficulty", 0)
	Engine.SetDvar("mutator_reload_cancel", 0)
	Engine.SetDvar("mutator_sprint_cancel", 0)
	Engine.SetDvar("mutator_deathmachine", 0)
	Engine.SetDvar("mutator_wallbuys_kino_der_toten", 0)
	Engine.SetDvar("mutator_wallbuys_origins", 0)
	Engine.SetDvar("mutator_wallbuys_der_eisendrache", 0)
	Engine.SetDvar("mutator_wallbuys_callofthedead", 0)
	Engine.SetDvar("mutator_freezegun", 0)
	Engine.SetDvar("mutator_bo3_m1927", 0)
	Engine.SetDvar("mutator_bo3_mg08", 0)
	Engine.SetDvar("mutator_bo3_stg", 0)
	Engine.SetDvar("mutator_mac11", 0)
	Engine.SetDvar("mutator_m60", 0)
	--Engine.SetDvar("mutator_bocw_1911", 0)
	--Engine.SetDvar("mutator_bocw_magnum", 0)
	--Engine.SetDvar("mutator_bocw_mp5k", 0)
	--Engine.SetDvar("mutator_bocw_ak74u", 0)
	--Engine.SetDvar("mutator_bocw_pm63", 0)
	--Engine.SetDvar("mutator_bocw_hauer77", 0)
	--Engine.SetDvar("mutator_bocw_gallosa12", 0)
	--Engine.SetDvar("mutator_bocw_m14", 0)
	--Engine.SetDvar("mutator_bocw_m16", 0)
	--Engine.SetDvar("mutator_bocw_galil", 0)
	--Engine.SetDvar("mutator_bocw_hk21", 0)
	--Engine.SetDvar("mutator_bocw_rpk", 0)
	--Engine.SetDvar("mutator_bocw_l96a1", 0)
	--Engine.SetDvar("mutator_bocw_ak47", 0)
	--Engine.SetDvar("mutator_bocw_stoner63", 0)
	--Engine.SetDvar("mutator_bocw_ppsh", 0)
	

	Engine.ForceNotifyModelSubscriptions(Engine.CreateModel(Engine.GetGlobalModel(), "GametypeSettings.Update"))
end

-- /////////////////////////////////////////////////////////////////////////////////////////
--                              Mutators Tabs
-- /////////////////////////////////////////////////////////////////////////////////////////

DataSources.MutatorsTabs = DataSourceHelpers.ListSetup("MutatorsTabs",
function (arg0, arg1, arg2, arg3, arg4)
    return
    {
        -- Left Shoulder
        {
            models        = { tabIcon = CoD.buttonStrings.shoulderl },
            properties    = { m_mouseDisabled = true }
        },
        {
            models        = { tabName 	= "BO Features", 				tabIcon = "" },
            properties    = { tabId 	= "MutatorSettingsBO", 				dataSourceName 	= "MutatorSettingsBO",	title =	"Black Ops Features Settings" }
        },
		{
            models        = { tabName 	= "Map Features", 				tabIcon = "" },
            properties    = { tabId 	= "MutatorSettingsBOMaps", 				dataSourceName 	= "MutatorSettingsBOMaps",	title =	"Map-based Black Ops Features Settings" }
        },
		{
            models        = { tabName 	= "General", 				        tabIcon = "" },
            properties    = { tabId 	= "MutatorSettingsGeneral", 		dataSourceName 	= "MutatorSettingsGeneral",	title =	"General Game Settings" }
        },
        {
            models        = { tabName 	= "Mystery Box", 				    tabIcon = "" },
            properties    = { tabId 	= "MutatorSettingsMysteryBox", 		dataSourceName 	= "MutatorSettingsMysteryBox",	title =	"Mystery Box Settings" }
        },
		{
			models		  = { tabName	= "PaP Camo",						tabIcon = "" },
			properties	  = { tabId		= "MutatorSettingsPaPCamo",			dataSourceName	= "MutatorSettingsPaPCamo",		title = "Pack-a-Punch Camouflage Settings" }
		},
		{
			models		  = { tabName	= "Custom Maps",						tabIcon = "" },
			properties	  = { tabId		= "MutatorSettingsCustomMaps",			dataSourceName	= "MutatorSettingsCustomMaps",		title = "Custom Map Settings" }
		},
		-- Right Shoulder
        {
            models        = { tabIcon = CoD.buttonStrings.shoulderr },
            properties    = { m_mouseDisabled = true }
        },
    }
end, true)

-- /////////////////////////////////////////////////////////////////////////////////////////
--                              Mutator Data Sources
-- /////////////////////////////////////////////////////////////////////////////////////////

-- /////////////////////////////////////////////////////////////////////////////////////////
--                              General Settings
-- /////////////////////////////////////////////////////////////////////////////////////////
DataSources.MutatorSettingsBO = DataSourceHelpers.ListSetup("MutatorSettingsBO",
function (arg0, arg1, arg2, arg3, arg4)
	return
	{
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"HUD",
			"Set Heads-Up Display to that of previous games",
			"MutatorSettings_HUD",
			"mutator_hud",
			BuildStringSettings({"Use Map", "BO II"}, "BO II"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Perk Machine",
			"Which perk machine out of PhD Flopper/Widow's Wine will be spawned in the game.",
			"MutatorSettings_PhDWidows",
			"delayPlayer",
			BuildBoolSettings({"PhD Flopper", "Widow's Wine"}, "PhD Flopper") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Double Tap",
			"Select between Double Tap I from WaW/BO and Double Tap II from BO II/III.",
			"MutatorSettings_DoubleTap",
			"autoDestroyTime",
            BuildStringSettings({"I", "II"}, "I") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Double Tap Perk",
			"If Double Tap (I or II) should exist through Der Wunderfizz, or at all in the map. Intended for maps like Ascension which didn't originally have it.",
			"MutatorSettings_DoubleTapExistence",
			"ballCount",
            BuildStringSettings({"Enabled", "Removed from Wunderfizz", "Removed from Map"}, "Enabled"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Deadshot Daiquiri Perk",
			"If Deadshot Daiquiri should exist through Der Wunderfizz, or at all in the map. Intended for maps like Ascension which didn't originally have it.",
			"MutatorSettings_DeadshotExistence",
			"bombTimer",
            BuildStringSettings({"Enabled", "Removed from Wunderfizz", "Removed from Map"}, "Enabled") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Deadshot Daiquiri Price",
			"1500 - Black Ops III price, 1000 - Black Ops I/II price.",
			"MutatorSettings_Deadshot",
			"disableClassSelection",
            BuildBoolSettings({"1000", "1500"}, "1000") ),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Perk Icons",
			"If the perk icons should be set to Black Ops II, Green Run/Nuketown/Die Rise, or leave it at the map or custom HUD's icons. MAY NOT WORK ON CUSTOM MAPS",
			--"If the perk icons should be set to Black Ops II, Green Run/Nuketown/Die Rise, WaW/BO, BO III with Black Ops colouring, or leave it at the map or custom HUD's icons. MAY NOT WORK ON CUSTOM MAPS",
			"MutatorSettings_BO2PerkIcons",
			"mutator_bo2_perk_icons",
            BuildStringSettings({"Black Ops II", "Green Run", --[["Black Ops", "Recoloured BO III",]] "Use Map/HUD"}, "Black Ops II"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Powerup Icons",
			"If the powerup icons should be set to the Original Black Ops II or leave it at the map or custom HUD's icons.",
			"MutatorSettings_BOPowerupIcons",
			"mutator_bo2_powerup_icons",
            BuildStringSettings({"Black Ops II", "Use Map/HUD"}, "Black Ops II"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Scope ADS",
			"If aiming down scope should be a 2D overlay, 3D viewmodel or changeable mid-game",
			"MutatorSettings_ScopeADS",
			"carrierArmor",
			BuildStringSettings({"2D Overlay", "3D Model", "Changeable"}, "Image Overlay") ),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Round Change Music",
			"Change between the BO III map-specific music and the Black Ops music",
			"MutatorSettings_RoundMusic",
			"mutator_round_music",
			BuildStringSettings({"BO", "BO III"}, "BO"), nil, SetDvarSetting),
		--[[CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Mystery Box FX",
			"Change between BO III Mystery Box FX and previous games' FX",
			"MutatorSettings_MysteryBoxFX",
			"mutator_mystery_box_fx",
			BuildStringSettings({"BO III", "Classic"}, "BO III"), nil, SetDvarSetting),]]
		--[[CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Zombie Dodging",
			"If zombies should side-step and roll like in Ascension.",
			"MutatorSettings_SideStep",
			"disableContracts",
			BuildBoolSettings({"Off", "On"}, "On") ),]]
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Health Difficulty",
			"BO III has 3-hit-down system, All other settings are 2-hit-down.\nRecruit has the longest delay before health regeneration, Hardened/Veteran has the shortest delay\nVeteran shows the critically injured overlay at 50% health (i.e. after a single hit pre-Juggernog)\nHardened is broken in the original game and does not consistently two-hit-down in early rounds when being attacked by a single zombie",
			"MutatorSettings_HealthDifficulty",
			"flagDecayTime",
			BuildStringSettings({"BO III", "Recruit", "Regular", "Hardened", "Veteran"}, "BO III") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Revive Animation",
			"Change between the classic revive animation and the Black Ops III one.",
			"MutatorSettings_ReviveAnimation",
			"disableTacInsert",
			BuildBoolSettings({"Classic", "BO III"}, "Classic") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Death Machine",
			"Enable or disable the Death Machine powerup.",
			"MutatorSettings_DeathMachine",
			"disableThirdPersonSpectating",
			BuildBoolSettings({"Off", "On"}, "Off") )
	}
end, nil, nil, Update)

DataSources.MutatorSettingsBOMaps = DataSourceHelpers.ListSetup("MutatorSettingsBOMaps",
function (arg0, arg1, arg2, arg3, arg4)
	return
	{
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Mine Wallbuy",
			"If the wallbuy should be Claymores instead of Trip Mines.",
			"MutatorSettings_Claymore",
			"disableVehicleSpawners",
            BuildBoolSettings({"Claymore", "Trip Mines"}, "Claymore") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Space Monkeys",
			"Enable Monkey Rounds on Ascension.",
			"MutatorSettings_SpaceMonkey",
			"flagCanBeNeutralized",
            BuildBoolSettings({"On", "Off"}, "On") ),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Ascension Red Telephone Quotes",
			"Restore FIVE quotes to the Red Telephones in Ascension",
			"MutatorSettings_RedTelephone",
			"mutator_redphone",
			BuildStringSettings({"Call of the Dead", "FIVE"}, "Call of the Dead"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Ascension Black-and-White Vision",
			"If the vision effect before turning on power in Ascension should be sepia (BO III) or black-and-white (BO)",
			"MutatorSettings_AscensionVisionset",
			"mutator_ascension_visionset",
			BuildStringSettings({"BO III", "BO"}, "BO III"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Shi no Numa Starting Room Perk",
			"Which perk out of Mule Kick/Quick Revive will be spawned in Shi no Numa's starting room.",
			"MutatorSettings_ShiNoNumaPerk",
			"flagRespawnTime",
			BuildStringSettings({"Mule Kick", "Quick Revive"}, "Mule Kick") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Kino Zombies Climbing Stage",
			"If zombies can climb up and jump down from the stage or if they have to go round the stairs",
			"MutatorSettings_KinoStageClimb",
			"pregameItemMaxVotes",
			BuildStringSettings({"On", "Off"}, "Off") ),
		--[[CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Starting Weapon",
			"If the starting weapon should be the BO M1911 or leave it at the map's default. For maps like Origins which have unique starting weapons.",
			"MutatorSettings_StartingWeapon",
			"gameAdvertisementRuleScorePercent",
			BuildStringSettings({"M1911", "Use Map"}, "M1911") ),]]
		--[[CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"WaW Wallbuys",
			"Whether WaW map wallbuys should use the original World at War weapons, Black Ops weapons or for Der Riese: Declassified to remain unchanged.",
			"MutatorSettings_WaWWallWeapons",
			"gameAdvertisementRuleTimeLeft",
			BuildStringSettings({"World at War Weapons", "Black Ops Weapons", "Use Custom Map"}, "World at War Weapons") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Verrückt Bolt Action Wallbuy",
			"Whether it should be a Springfield on the American starting room or a Kar98k",
			"MutatorSettings_VerrucktSpringfield",
			"gameAdvertisementRuleRound",
			BuildStringSettings({"Kar98k", "Springfield"}, "Kar98k") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Kino der Toten Wallbuys",
			"WaW Layout 1 is roughly based on Der Riese, WaW Layout 2 is by Conn6orsuper117, WaW Layout 3 is based on rough counterparts to BO weapons with an further option to swap the FG42/BAR (MPL/PM63)",
			"MutatorSettings_WallbuysKinoderToten",
			"gameAdvertisementRuleRoundsWon",
			BuildStringSettings({"WaW Layout 1", "WaW Layout 2", "WaW Layout 3", "WaW Layout 3 (Swapped)", "Black Ops"}, "Black Ops") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Origins Wallbuys",
			"BO Layout 1 is by Conn6orsuper117, WaW Layout 1 is by HzRetro",
			"MutatorSettings_WallbuysOrigins",
			"idleFlagResetTime",
			BuildStringSettings({"BO Layout 1", "WaW Layout 1"}, "BO Layout 2") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Der Eisendrache Wallbuys",
			"WaW Layout 1 is by poyzee, WaW Layout 2 is by Conn6orsuper117",
			"MutatorSettings_WallbuysDerEisendrache",
			"incrementalSpawnDelay",
			BuildStringSettings({"WaW Layout 1", "WaW Layout 2"}, "WaW Layout 3") )]]
		--CoD.OptionsUtility.CreateDvarSettings(
		--	arg0,
		--	"Random Moon Solo Character",
		--	"Randomises character when playing Moon, disables Solo Easter Egg completion",
		--	"MutatorSettings_MoonRandomChar",
		--	"mutator_moon_random_char",
        --    BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting)
	}
end, nil, nil, Update)

DataSources.MutatorSettingsGeneral = DataSourceHelpers.ListSetup("MutatorSettingsGeneral",
function (arg0, arg1, arg2, arg3, arg4)
	return
	{
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Double Pack-a-Punch",
			"Whether weapons can be pack-a-punched multiple times for attachments, alternate ammo types, both, or not at all.",
			"MutatorSettings_DoublePackaPunch",
			"pointsPerWeaponKill",
            BuildStringSettings({"BO II", "BO III", "Combined", "Off"}, "BO II") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Gobblegum Machines",
			"If Gobblegum Machines should be usable.",
			"MutatorSettings_Gobblegum",
			"leaderBonus",
            BuildStringSettings({"Enabled", "Disabled", "Replaced"}, "Enabled") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Der Wunderfizz",
			"If Der Wunderfizz should be usable.",
			"MutatorSettings_Wunderfizz",
			"maxAllocation",
            BuildStringSettings({"Enabled", "Disabled", "Replaced"}, "Enabled") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Widow's Wine Perk",
			"If Widow's Wine should exist through Der Wunderfizz, or at all in the map.",
			"MutatorSettings_WidowsWine",
			"maxObjectiveEventsPerMinute",
            BuildStringSettings({"Enabled", "Removed from Wunderfizz", "Removed from Map"}, "Enabled") ),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Demonic Announcer",
			"Changes voice used for powerups etc.",
			"MutatorSettings_Announcer",
			"mutator_announcer",
			BuildStringSettings({"Use Map", "Classic Samantha", "Moon Richtofen", "BO II Richtofen", "Origins Samantha", "Shadowman", "Dr Monty"}, "Use Map"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Weapon Holstering",
			"Weapon will lower when nearing an obstruction",
			"MutatorSettings_WeaponRest",
			"mutator_weapon_rest",
			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Fall Damage",
			"Set height values for fall damage to previous games' values",
			"MutatorSetings_FallDamage",
			"flagCaptureCondition",
			BuildBoolSettings({"BO III", "Classic"}, "Classic") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Sprinting movement mechanic",
			"Whether you should dive-to-prone, slide, or do nothing at all when pressing crouch/prone while sprinting",
			"MutatorSettings_SlideDive",
			"maxPlayerOffensive",
			BuildStringSettings({"Dive to Prone", "Sliding", "None"}, "None") ),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Sprinting cancels reloads",
			"Enable reload cancelling",
			"MutatorSettings_ReloadCancel",
			"mutator_reload_cancel",
			BuildStringSettings({"Off", "On"}, "On"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Reloading cancels sprinting",
			"Stop sprinting when you start a reload",
			"MutatorSettings_SprintCancel",
			"mutator_sprint_cancel",
			BuildStringSettings({"Off", "On"}, "On"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Grenade Wallbuy",
			"Set all grenade wallbuys to be frags, semtexes, or leave it at the map's default. For maps like Kino der Toten and Ascension which didn't originally have semtexes.",
			"MutatorSettings_GrenadeWallbuy",
			"objectivePingTime",
			BuildStringSettings({"Default", "Frag", "Semtex"}, "Default") ),
		--[[CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Zombie Eye Colour",
			"Sets the zombies' glowing eyes to a different colour. Eyes on the model itself may still be visible through the glow fx.",
			"MutatorSettings_EyeColour",
			"mutator_eye_colour",
			BuildStringSettings({"Use Map", "Orange", "Blue", "Red", "White", "Green", "Purple", "Pink", "No Glow FX"}, "Use Map"), nil, SetDvarSetting),]]
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Random Perk Machine Locations",
			"Whether perk machine locations are randomised or not for Shadows of Evil, The Giant and Zetsubou no Shima.",
			"MutatorSettings_RandomPerkMachines",
			"idleFlagDecay",
			BuildBoolSettings({"On", "Off"}, "On") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Delayed Power-Ups",
			"Whether the ability to pick up power-up drops should be delayed after spawn-in like Black Ops IIII or should remain instantly collectable like in previous games.",
			"MutatorSettings_DelayedPowerup",
			"cumulativeroundscores",
			BuildBoolSettings({"Off", "On"}, "Off") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Zombie Movement Speed to Barriers",
			"Override how fast zombies should be before they get to barriers. Useful for maps like Nacht der Untoten to make early rounds quicker, or for slowing down zombies in later rounds",
			"MutatorSettings_RunToBarrier",
			"pregamePositionShuffleMethod",
			BuildStringSettings({"Default", "Walk", "Run", "Sprint", "Super Sprint"}, "Default") )
		--CoD.OptionsUtility.CreateDvarSettings(
		--	arg0,
		--	"Remove Map Visionsets",
		--	"Change the look and feel to more subdued tones in Nacht der Untoten, Kino der Toten, Ascension, Shangri-La, Moon ",
		--	"MutatorSettings_MapVisionsets",
		--	"mutator_map_visionsets",
		--	BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting)
	}
end, nil, nil, Update)

DataSources.MutatorSettingsMysteryBox = DataSourceHelpers.ListSetup("MutatorSettingsMysteryBox",
function (arg0, arg1, arg2, arg3, arg4)
	return
	{
		--[[CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"AK47",
			"Add AK47 to the mystery box for all maps.",
			"MutatorSettings_AK47",
			"",
            BuildBoolSettings({"Off", "On"}, "Off") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Uzi",
			"Add Uzi to the mystery box.",
			"MutatorSettings_Uzi",
			"pointsPerMeleeKill",
            BuildStringSettings({"Off", "On"}, "Off") ),]]
		--[[CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Ray Gun",
			"Switch between WaW Ray Gun and Improved BO3 Ray Gun",
			"MutatorSettings_RayGun",
			"mutator_ray_gun",
			BuildStringSettings({"WaW", "BO III"}, "WaW"), nil, SetDvarSetting),]]
		--[[CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Winter's Howl",
			"Add Winter's Howl to all maps' mystery boxes.",
			"MutatorSettings_FreezeGun",
			"rebootPlayers",
			BuildBoolSettings({"Off", "On"}, "Off") ),]]
		--[[CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Ray Gun Mark II",
			"Enable Ray Gun Mark II in the mystery box.",
			"MutatorSettings_RayGunMkII",
			"robotShield",
            BuildBoolSettings({"On", "Off"}, "On") ),]]
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Ballistic Knife",
			"Enable or disable Ballistic Knife for all maps' mystery boxes. TURNING OFF MAY CRASH SOME MAPS",
			"MutatorSettings_BallisticKnife",
			"pregamePostStageTime",
            BuildStringSettings({"Map default", "On", "Off"}, "On") ),
	}
end, nil, nil, Update)

DataSources.MutatorSettingsPaPCamo = DataSourceHelpers.ListSetup("MutatorSettingsPaPCamo",
function(arg0, arg1, arg2, arg3, arg4)
	return
	{
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Disable PaP Camo",
			"Weapons do not receive camo upon PaP, OVERRIDES ALL SETTINGS BELOW.",
			"MutatorSettings_CamoDisable",
			"timePausesWhenInZone",
			BuildBoolSettings({"Off", "On"}, "Off") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Wunderwaffe",
			"Whether the Wunderwaffe should have Gold camo or the same PaP camo as everything else.",
			"MutatorSettings_WunderwaffeCamo",
			"vehiclesEnabled",
			BuildBoolSettings({"Gold Camo", "PaP Camo"}, "Gold Camo") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Cycle camos in-game",
			"Cycle through all selected camos every time you pack-a-punch",
			"MutatorSettings_CamoInGameCycle",
			"vehiclesTimed",
			BuildBoolSettings({"Off", "On"}, "Off") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Black Ops",
			"Add Black Ops PaP camo to be randomly selected for the game",
			"MutatorSettings_CamoBlackOps",
			"voipDeadHearKiller",
			BuildBoolSettings({"On", "Off"}, "On") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"World at War",
			"Add World at War PaP camo to be randomly selected for the game",
			"MutatorSettings_CamoWorldAtWar",
			"voipKillersHearVictim",
			BuildBoolSettings({"Off", "On"}, "Off") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Gold",
			"Add Gold PaP camo to be randomly selected for the game",
			"MutatorSettings_CamoGold",
			"robotSpeed",
			BuildStringSettings({"Off", "On"}, "Off") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Dark Matter",
			"Add Dark Matter to be randomly selected as PaP camo for the game",
			"MutatorSettings_CamoDarkMatter",
			"setbacks",
			BuildStringSettings({"Off", "On"}, "Off") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Ice",
			"Add Ice to be randomly selected as PaP camo for the game",
			"MutatorSettings_CamoIce",
			"shutdownDamage",
			BuildStringSettings({"Off", "On"}, "Off") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Ritual",
			"Add Ritual (Shadows of Evil) to be randomly selected as PaP camo for the game",
			"MutatorSettings_CamoRitual",
			"cleanDepositOnlineTime",
			BuildStringSettings({"Off", "On"}, "Off") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Etching",
			"Add Etching (The Giant/Nacht der Untoten/Verrückt/Shi No Numa) to be randomly selected as PaP camo for the game",
			"MutatorSettings_CamoEtching",
			"cleanDepositRotation",
			BuildStringSettings({"Off", "On"}, "Off") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Der Eisendrache Camos",
			"Add Topaz/Garnet/Sapphire/Emerald/Amethyst to be randomly selected as PaP camos for the game",
			"MutatorSettings_CamoDerEisendrache",
			"antiBoostDistance",
			BuildStringSettings({"Off", "On"}, "Off") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Overgrowth",
			"Add Overgrowth (Zetsubou No Shima) to be randomly selected as PaP camo for the game",
			"MutatorSettings_CamoOvergrowth",
			"bootTime",
			BuildStringSettings({"Off", "On"}, "Off") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Gorod Krovi Camos",
			"Add Dragon Fire/Glacies Fire (Blue Gorod Krovi)/Atomic Fire/Everlasting Fire/Arcane Fire to be randomly selected as PaP camos for the game",
			"MutatorSettings_CamoGorodKrovi",
			"crateCaptureTime",
			BuildStringSettings({"Off", "On"}, "Off") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Revelations Camos",
			"Add Cosmos/Cosmic/Infinitus/Into the Void/Universe to be randomly selected as PaP camos for the game",
			"MutatorSettings_CamoRevelations",
			"defuseTime",
			BuildStringSettings({"Off", "On"}, "Off") ),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"SCROLL TO SEE MORE CAMOS",
			"",
			"MutatorSettings_More_Camos",
			"mutator_more_camos",
			BuildStringSettings({""}, ""), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Circuits",
			"Add Circuits (BO III Kino der Toten) to be randomly selected as PaP camo for the game",
			"MutatorSettings_CamoKino",
			"destroyTime",
			BuildStringSettings({"Off", "On"}, "Off") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Origins",
			"Add Origins PaP camo to be randomly selected for the game",
			"MutatorSettings_CamoOrigins",
			"flagCaptureGracePeriod",
			BuildStringSettings({"Off", "On"}, "Off") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Weaponized 115",
			"Add Weaponized 115 to be randomly selected as PaP camo for the game",
			"MutatorSettings_Weaponized115",
			"infectionMode",
			BuildStringSettings({"Off", "On"}, "Off") )
	}
end, nil, nil, Update)

DataSources.MutatorSettingsCustomMaps = DataSourceHelpers.ListSetup("MutatorSettingsCustomMaps",
function(arg0, arg1, arg2, arg3, arg4)
	return
	{
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Der Riese: Declassified PPSh-41",
			"Adds back Black Ops III PPSh-41 to Der Riese: Declassified",
			"MutatorSettings_DeclassifiedPPSh",
			"maxPlayerDefensive",
			BuildStringSettings({"Off", "On"}, "Off") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Der Riese: Declassified MG 42",
			"Adds back CoD: WWII MG 42 to Der Riese: Declassified",
			"MutatorSettings_DeclassifiedMG42",
			"maxPlayerEventsPerMinute",
			BuildStringSettings({"Off", "On"}, "Off") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Call of the Dead Easter Egg Reward",
			"Force spawns Lightning Bolt powerup (Wunderwaffe DG-2) in place of Death Machine when defeating George A. Romero",
			"MutatorSettings_GeorgeReward",
			"objectiveSpawnTime",
			BuildStringSettings({"Off", "On"}, "Off") ),
		--[[CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Call of the Dead Wallbuys",
			"Whether Call of the Dead wallbuys should use the original Black Ops or World at War weapons.",
			"MutatorSettings_CalloftheDead",
			"pointsPerSecondaryKill",
			BuildStringSettings({"Black Ops", "World at War"}, "Black Ops") )]]
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Town Reimagined Ballista",
			"Whether the Ballista can be bought off the wall in Town Reimagined",
			"MutatorSettings_TownBallista",
			"kothMode",
			BuildBoolSettings({"Off", "On"}, "Off") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Town Reimagined PDW-57",
			"Whether the PDW-57 can be bought off the wall in Town Reimagined",
			"MutatorSettings_TownPDW57",
			"OvertimetimeLimit",
			BuildBoolSettings({"Off", "On"}, "Off") ),
		CoD.OptionsUtility.CreateNamedSettings(
			arg0,
			"Cell Block Perk Swap",
			"Swap positions of Mule Kick, Double Tap, Electric Cherry on Hybs' Cell Block Survival so that Mule Kick and Double Tap are in their original positions",
			"MutatorSettings_CellBlockPerks",
			"playerforcerespawn",
			BuildBoolSettings({"On", "Off"}, "Off") )
	}
end, nil, nil, Update)