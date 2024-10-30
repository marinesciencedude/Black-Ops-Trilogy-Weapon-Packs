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
	Engine.SetDvar("mutator_map_visionset", 0)
	Engine.SetDvar("mutator_shinonuma_perk", 0)
	Engine.SetDvar("mutator_sidestep", 0)
	Engine.SetDvar("mutator_ascension_visionset", 0)
	Engine.SetDvar("mutator_health_difficulty", 0)
	Engine.SetDvar("mutator_startingweapon", 0)
	Engine.SetDvar("mutator_bo3_m1927", 0)
	Engine.SetDvar("mutator_bo3_mg08", 0)
	Engine.SetDvar("mutator_bo3_stg", 0)
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
            models        = { tabName 	= "BO Map Features", 				tabIcon = "" },
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
            models        = { tabName 	= "BOCW Models", 				tabIcon = "" },
            properties    = { tabId 	= "MutatorSettingsBOCWModels", 		dataSourceName 	= "MutatorSettingsBOCWModels",	title =	"Black Ops Cold War Models" }
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
			"Perk Machine",
			"Which perk machine out of PhD Flopper/Widow's Wine will be spawned in the game.",
			"MutatorSettings_PhDWidows",
			"mutator_phd_widows",
            BuildStringSettings({"PhD Flopper", "Widow's Wine"}, "PhD Flopper"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Double Tap",
			"Select between Double Tap I from WaW/BO and Double Tap II from BO II/III.",
			"MutatorSettings_DoubleTap",
			"mutator_doubletap",
            BuildStringSettings({"I", "II"}, "I"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Double Tap Perk",
			"If Double Tap (I or II) should exist through Der Wunderfizz, or at all in the map. Intended for maps like Ascension which didn't originally have it.",
			"MutatorSettings_DoubleTapExistence",
			"mutator_doubletap_existence",
            BuildStringSettings({"Enabled", "Removed from Wunderfizz", "Removed from Map"}, "Enabled"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Deadshot Daiquiri Perk",
			"If Deadshot Daiquiri should exist through Der Wunderfizz, or at all in the map. Intended for maps like Ascension which didn't originally have it.",
			"MutatorSettings_DeadshotExistence",
			"mutator_deadshot_existence",
            BuildStringSettings({"Enabled", "Removed from Wunderfizz", "Removed from Map"}, "Enabled"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Deadshot Daiquiri Price",
			"1500 - Black Ops III price, 1000 - Black Ops I/II price.",
			"MutatorSettings_Deadshot",
			"mutator_deadshot_price",
            BuildStringSettings({"1000", "1500"}, "1000"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Perk Icons",
			"If the perk icons should be set to the Original Black Ops, BO III with Black Ops colouring, or leave it at the map's icons. MAY NOT WORK ON CUSTOM MAPS",
			"MutatorSettings_BOPerkIcons",
			"mutator_bo_perk_icons",
            BuildStringSettings({"Black Ops", "Recoloured BO III", "Use Map"}, "Black Ops"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Mine Wallbuy",
			"If the wallbuy should be Claymores instead of Trip Mines.",
			"MutatorSettings_Claymore",
			"mutator_claymore",
            BuildStringSettings({"Claymore", "Trip Mines"}, "Claymore"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Scope ADS",
			"If aiming down scope should be a 2D overlay, 3D viewmodel or changeable mid-game",
			"MutatorSettings_ScopeADS",
			"mutator_scopeads",
			BuildStringSettings({"2D Overlay", "3D Model", "Changeable"}, "Image Overlay"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Round Change Music",
			"Change between the BO III map-specific music and the Black Ops music",
			"MutatorSettings_RoundMusic",
			"mutator_round_music",
			BuildStringSettings({"BO", "BO III"}, "BO"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Mystery Box FX",
			"Change between BO III Mystery Box FX and previous games' FX",
			"MutatorSettings_MysteryBoxFX",
			"mutator_mystery_box_fx",
			BuildStringSettings({"BO III", "Classic"}, "BO III"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Zombie Dodging",
			"If zombies should side-step and roll like in Ascension.",
			"MutatorSettings_SideStep",
			"mutator_sidestep",
			BuildStringSettings({"Off", "On"}, "On"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Health Difficulty",
			"BO III has 3-hit-down system, All other settings are 2-hit-down.\nRecruit has the longest delay before health regeneration, Hardened/Veteran has the shortest delay\nVeteran shows the critically injured overlay at 50% health (i.e. after a single hit pre-Juggernog)",
			"MutatorSettings_HealthDifficulty",
			"mutator_health_difficulty",
			--BuildStringSettings({"BO III", "Recruit", "Regular", "Hardened", "Veteran"}, "BO III"), nil, SetDvarSetting)
			BuildStringSettings({"BO III", "Recruit", "Regular", "Veteran"}, "BO III"), nil, SetDvarSetting)
	}
end, nil, nil, Update)

DataSources.MutatorSettingsBOMaps = DataSourceHelpers.ListSetup("MutatorSettingsBOMaps",
function (arg0, arg1, arg2, arg3, arg4)
	return
	{
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"AUG Wallbuy",
			"If the Wii AUG wallbuy should exist on Kino der Toten.",
			"MutatorSettings_AUG",
			"mutator_aug",
            BuildStringSettings({"On", "Off"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Ascension Red Telephone Quotes",
			"Restore FIVE quotes to the Red Telephones in Ascension",
			"MutatorSettings_RedTelephone",
			"mutator_redphone",
			BuildStringSettings({"Call of the Dead", "FIVE"}, "Call of the Dead"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Shi no Numa Starting Room Perk",
			"Which perk out of Mule Kick/Quick Revive will be spawned in Shi no Numa's starting room.",
			"MutatorSettings_ShiNoNumaPerk",
			"mutator_shinonuma_perk",
			BuildStringSettings({"Mule Kick", "Quick Revive"}, "Mule Kick"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Ascension Black-and-White Vision",
			"If the vision effect before turning on power in Ascension should be sepia (BO III) or black-and-white (BO)",
			"MutatorSettings_AscensionVisionset",
			"mutator_ascension_visionset",
			BuildStringSettings({"BO III", "BO"}, "BO III"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Starting Weapon",
			"If the starting weapon should be the BO M1911 or leave it at the map's default. For maps like Origins which have unique starting weapons.",
			"MutatorSettings_StartingWeapon",
			"mutator_startingweapon",
			BuildStringSettings({"M1911", "Use Map"}, "M1911"), nil, SetDvarSetting)
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
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Double Pack-a-Punch",
			"Whether weapons can be pack-a-punched multiple times or not.",
			"MutatorSettings_DoublePackaPunch",
			"mutator_double_packapunch",
            BuildStringSettings({"On", "Off"}, "On"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Gobblegum Machines",
			"If Gobblegum Machines should be usable.",
			"MutatorSettings_Gobblegum",
			"mutator_enable_gobblegum",
            BuildStringSettings({"Enabled", "Disabled", "Replaced"}, "Enabled"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Der Wunderfizz",
			"If Der Wunderfizz should be usable.",
			"MutatorSettings_Wunderfizz",
			"mutator_enable_wunderfizz",
            BuildStringSettings({"Enabled", "Disabled", "Replaced"}, "Enabled"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Widow's Wine Perk",
			"If Widow's Wine should exist through Der Wunderfizz, or at all in the map.",
			"MutatorSettings_WidowsWine",
			"mutator_widowswine_existence",
            BuildStringSettings({"Enabled", "Removed from Wunderfizz", "Removed from Map"}, "Enabled"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Space Monkeys",
			"Enable Monkey Rounds on Ascension.",
			"MutatorSettings_SpaceMonkey",
			"mutator_spacemonkey",
            BuildStringSettings({"On", "Off"}, "On"), nil, SetDvarSetting),
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
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Sliding",
			"Enable or disable sliding",
			"MutatorSettings_SlideDive",
			"mutator_slide_dive",
			BuildStringSettings({"On", "Off"}, "On"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Grenade Wallbuy",
			"Set all grenade wallbuys to be frags, semtexes, or leave it at the map's default. For maps like Kino der Toten and Ascension which didn't originally have semtexes.",
			"MutatorSettings_GrenadeWallbuy",
			"mutator_grenade_wallbuy",
			BuildStringSettings({"Default", "Frag", "Semtex"}, "Default"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Zombie Eye Colour",
			"Sets the zombies' glowing eyes to a different colour. Eyes on the model itself may still be visible through the glow fx.",
			"MutatorSettings_EyeColour",
			"mutator_eye_colour",
			BuildStringSettings({"Use Map", "Orange", "Blue", "Red", "White", "Green", "Purple", "Pink", "No Glow FX"}, "Use Map"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"WaW Wall Buys",
			"Whether WaW map wallbuys should use Black Ops weapons or for Der Riese: Declassified to remain unchanged.",
			"MutatorSettings_WaWWallWeapons",
			"mutator_waw_wall_weapons",
			BuildStringSettings({"Black Ops Weapons", "Use Custom Map"}, "Use Custom Map"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Random Perk Machine Locations",
			"Whether perk machine locations are randomised or not for Shadows of Evil, The Giant and Zetsubou no Shima.",
			"MutatorSettings_RandomPerkMachines",
			"mutator_random_perk_machines",
			BuildStringSettings({"On", "Off"}, "On"), nil, SetDvarSetting),
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
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"AK47",
			"Add AK47 to the mystery box and Reznov's Revenge as its PaP version.",
			"MutatorSettings_AK47",
			"mutator_ak47",
            BuildStringSettings({"Disabled", "Reznov's Revenge"}, "Disabled"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Uzi",
			"Add Uzi to the mystery box. SP/MP has a 32+192/64+448 base/PaP ammo capacity, BO II has a 25+275/25+300 base/PaP ammo capacity.",
			"MutatorSettings_Uzi",
			"mutator_uzi",
            BuildStringSettings({"Disabled", "SP/MP", "BO II"}, "Disabled"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Skorpion",
			"Add Skorpion to the mystery box.",
			"MutatorSettings_Skorpion",
			"mutator_skorpion",
            BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Stoner 63",
			"Add Stoner 63 to the mystery box.",
			"MutatorSettings_Stoner63",
			"mutator_stoner63",
            BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Enfield",
			"Add Enfield to the mystery box.",
			"MutatorSettings_Enfield",
			"mutator_enfield",
            BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"WA2000",
			"Enable WA2000 in the mystery box.",
			"MutatorSettings_WA2000",
			"mutator_wa2000",
			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"PSG1",
			"Enable PSG1 in the mystery box.",
			"MutatorSettings_PSG1",
			"mutator_psg1",
			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"PPSh-41",
			"Enable PPSh-41 in the mystery box.",
			"MutatorSettings_PPSh",
			"mutator_ppsh",
			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Ray Gun Mark II",
			"Enable Ray Gun Mark II in the mystery box.",
			"MutatorSettings_RayGunMkII",
			"mutator_raygunmkii",
            BuildStringSettings({"On", "Off"}, "On"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Crossbow",
			"Enable Crossbow in the mystery box.",
			"MutatorSettings_Crossbow",
			"mutator_crossbow",
            BuildStringSettings({"On", "Off"}, "On"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Ballistic Knife",
			"Enable Ballistic Knife in the mystery box.",
			"MutatorSettings_BallisticKnife",
			"mutator_ballistic_knife",
            BuildStringSettings({"On", "Off"}, "On"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"BLACK OPS III WEAPONS",
			"Scroll to see more options",
			"MutatorSettings_BOIII_Weapons",
			"mutator_boiii_weapons",
			BuildStringSettings({""}, ""), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"M1927",
			"Add M1927 to the Mystery Box for maps that support it",
			"MutatorSettings_BO3M1927",
			"mutator_bo3_m1927",
           BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"MG08/15",
			"Add MG08/15 to the Mystery Box for maps that support it",
			"MutatorSettings_BO3MG08",
			"mutator_bo3_mg08",
            BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Base Mystery Box Weapons",
			"Mystery Box weapons mostly common to all Black Ops III maps: VMP, Weevil, Pharo, Man-O-War, HVK-30, Sheiva, ICR-1, Argus, 205 Brecci, Haymaker 12, Dingo, BRM, 48 Dredge, Gorgon, Locus, Drakon, SVG-100, XM-53, KN-44, Vesper, Kuda, M8A7, L-CAR 9, FFAR, KRM-262.",
			"MutatorSettings_BO3MysteryBox",
			"mutator_bo3_weapons",
            BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"RK5",
			"Add RK5 to the Mystery Box.",
			"MutatorSettings_RK5",
			"mutator_bo3_rk5",
            BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		--CoD.OptionsUtility.CreateDvarSettings(
		--	arg0,
		--	"L4 Siege",
		--	"Add L4 Siege to the Mystery Box.",
		--	"MutatorSettings_L4Siege",
		--	"mutator_bo3_l4_siege",
        --    BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"RPK",
			"Add RPK to the Mystery Box.",
			"MutatorSettings_BO3RPK",
			"mutator_bo3_rpk",
            BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"AK-74u",
			"Add AK-74u to the Mystery Box.",
			"MutatorSettings_BO3AK74u",
			"mutator_bo3_ak74u",
            BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Galil",
			"Add Galil to the Mystery Box.",
			"MutatorSettings_BO3Galil",
			"mutator_bo3_galil",
            BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"M16",
			"Add M16 to the Mystery Box.",
			"MutatorSettings_BO3M16",
			"mutator_bo3_m16",
            BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"M14",
			"Add M14 to the Mystery Box.",
			"MutatorSettings_BO3M14",
			"mutator_bo3_m14",
            BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		--CoD.OptionsUtility.CreateDvarSettings(
		--	arg0,
		--	"MX Garand",
		--	"Add MX Garand to the Mystery Box.",
		--	"MutatorSettings_MXGarand",
		--	"mutator_bo3_mx_garand",
         --   BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		--CoD.OptionsUtility.CreateDvarSettings(
		--	arg0,
		--	"HG 40",
		--	"Add HG 40 to the Mystery Box.",
		--	"MutatorSettings_HG40",
		--	"mutator_bo3_hg40",
        --    BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"MP 40",
			"Add MP 40 to the Mystery Box.",
			"MutatorSettings_BO3MP40",
			"mutator_bo3_mp40",
            BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"StG-44",
			"Add StG-44 to the Mystery Box.",
			"MutatorSettings_BO3StG",
			"mutator_bo3_stg",
            BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		--CoD.OptionsUtility.CreateDvarSettings(
		--	arg0,
		--	"PPSh-41",
		--	"Add PPSh-41 to the Mystery Box.",
		--	"MutatorSettings_BO3PPSh",
		--	"mutator_bo3_ppsh",
        --    BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		--CoD.OptionsUtility.CreateDvarSettings(
		--	arg0,
		--	"Bootlegger",
		--	"Add Bootlegger to the Mystery Box.",
		--	"MutatorSettings_Bootlegger",
		--	"mutator_bo3_bootlegger",
        --    BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		--CoD.OptionsUtility.CreateDvarSettings(
		--	arg0,
		--	"Peacekeeper MK2",
		--	"Add Peacekeeper MK2 to the Mystery Box.",
		--	"MutatorSettings_Peacekeeper",
		--	"mutator_bo3_peacekeeper",
        --    BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		--CoD.OptionsUtility.CreateDvarSettings(
		--	arg0,
		--	"Marshal 16",
		--	"Add Marshal 16 to the Mystery Box.",
		--	"MutatorSettings_Marshal",
		--	"mutator_bo3_marshal",
        --    BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		--CoD.OptionsUtility.CreateDvarSettings(
		--	arg0,
		--	"Razorback",
		--	"Add Razorback to the Mystery Box.",
		--	"MutatorSettings_Razorback",
		--	"mutator_bo3_razorback",
        --    BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		--CoD.OptionsUtility.CreateDvarSettings(
		--	arg0,
		--	"Banshii",
		--	"Add Banshii to the Mystery Box.",
		--	"MutatorSettings_Banshii",
		--	"mutator_bo3_banshii",
        --    BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
	}
end, nil, nil, Update)

--DataSources.MutatorSettingsBOCWModels = DataSourceHelpers.ListSetup("MutatorSettingsBOCWModels",
--function(arg0, arg1, arg2, arg3, arg4)
--	return
--	{
--		CoD.OptionsUtility.CreateDvarSettings(
--			arg0,
--			"COMPATIBILITY NOTE",
--			"INSTALL THE .XPAK BEFORE USING THESE OPTIONS. Scroll to see all weapons.",
--			"MutatorSettings_BOCW_Header",
--			"mutator_bocw_header",
--			BuildStringSettings({""}, ""), nil, SetDvarSetting),
--		CoD.OptionsUtility.CreateDvarSettings(
--			arg0,
--			"M1911",
--			"Replace M1911 with Black Ops Cold War version.",
--			"MutatorSettings_BOCW_1911",
--			"mutator_bocw_1911",
--			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
--		CoD.OptionsUtility.CreateDvarSettings(
--			arg0,
--			"Magnum",
--			"Replace Python with Magnum (names in-game unchanged).",
--			"MutatorSettings_BOCW_Magnum",
--			"mutator_bocw_magnum",
--			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
--		CoD.OptionsUtility.CreateDvarSettings(
--			arg0,
--			"MP5K",
--			"Replace MP5K with Black Ops Cold War version.",
--			"MutatorSettings_BOCW_MP5K",
--			"mutator_bocw_mp5k",
--			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
--		CoD.OptionsUtility.CreateDvarSettings(
--			arg0,
--			"AK74u",
--			"Replace AK74u with Black Ops Cold War version.",
--			"MutatorSettings_BOCW_AK74u",
--			"mutator_bocw_ak74u",
--			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
--		CoD.OptionsUtility.CreateDvarSettings(
--			arg0,
--			"PM63",
--			"Replace PM63 with AMP-63 (names in-game unchanged).",
--			"MutatorSettings_BOCW_PM63",
--			"mutator_bocw_pm63",
--			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
--		CoD.OptionsUtility.CreateDvarSettings(
--			arg0,
--			"Stakeout",
--			"Replace Stakeout with Hauer 77 (names in-game unchanged).",
--			"MutatorSettings_BOCW_Hauer77",
--			"mutator_bocw_hauer77",
--			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
--		CoD.OptionsUtility.CreateDvarSettings(
--			arg0,
--			"SPAS-12",
--			"Replace SPAS-12 with Gallo SA12 (names in-game unchanged).",
--			"MutatorSettings_BOCW_GalloSA12",
--			"mutator_bocw_gallosa12",
--			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
--		CoD.OptionsUtility.CreateDvarSettings(
--			arg0,
--			"M14",
--			"Replace M14 with DMR 14 (names in-game unchanged).",
--			"MutatorSettings_BOCW_M14",
--			"mutator_bocw_m14",
--			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
--		CoD.OptionsUtility.CreateDvarSettings(
--			arg0,
--			"M16",
--			"Replace M16 with Black Ops Cold War version.",
--			"MutatorSettings_BOCW_M16",
--			"mutator_bocw_m16",
--			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		--CoD.OptionsUtility.CreateDvarSettings(
		--	arg0,
		--	"Commando",
		--	"Replace Commando with XM4 (names in-game unchanged).",
		--	"MutatorSettings_BOCW_Commando",
		--	"mutator_bocw_commando",
		--	BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
--		CoD.OptionsUtility.CreateDvarSettings(
--			arg0,
--			"Galil",
--			"Replace Galil with Grav (names in-game unchanged).",
--			"MutatorSettings_BOCW_Galil",
--			"mutator_bocw_galil",
--			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		--CoD.OptionsUtility.CreateDvarSettings(
		--	arg0,
		--	"AUG",
		--	"Replace AUG with Black Ops Cold War version.",
		--	"MutatorSettings_BOCW_AUG",
		--	"mutator_bocw_aug",
		--	BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
--		CoD.OptionsUtility.CreateDvarSettings(
--			arg0,
--			"HK21",
--			"Replace HK21 with C58 variant (names in-game unchanged).",
--			"MutatorSettings_BOCW_HK21",
--			"mutator_bocw_hk21",
--			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
--		CoD.OptionsUtility.CreateDvarSettings(
--			arg0,
--			"RPK",
--			"Replace RPK with AK-47 variant (names in-game unchanged).",
--			"MutatorSettings_BOCW_RPK",
--			"mutator_bocw_rpk",
--			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
--		CoD.OptionsUtility.CreateDvarSettings(
--			arg0,
--			"L96A1",
--			"Replace L96A1 with LW3 Tundra (names in-game unchanged).",
--			"MutatorSettings_BOCW_L96A1",
--			"mutator_bocw_l96a1",
--			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
--		CoD.OptionsUtility.CreateDvarSettings(
--			arg0,
--			"AK47",
--			"Replace AK47 with Black Ops Cold War version. ENSURE MYSTERY BOX OPTION IS ENABLED.",
--			"MutatorSettings_BOCW_AK47",
--			"mutator_bocw_ak47",
--			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
--		CoD.OptionsUtility.CreateDvarSettings(
--			arg0,
--			"Stoner63",
--			"Replace Stoner63 with Black Ops Cold War version. ENSURE MYSTERY BOX OPTION IS ENABLED.",
--			"MutatorSettings_BOCW_Stoner63",
--			"mutator_bocw_stoner63",
--			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
--		CoD.OptionsUtility.CreateDvarSettings(
--			arg0,
--			"PPSh-41",
--			"Replace PPSh-41 with Black Ops Cold War version. ENSURE MYSTERY BOX OPTION IS ENABLED.",
--			"MutatorSettings_BOCW_PPSh",
--			"mutator_bocw_ppsh",
--			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting)
--	}
--end, nil, nil, Update)

DataSources.MutatorSettingsPaPCamo = DataSourceHelpers.ListSetup("MutatorSettingsPaPCamo",
function(arg0, arg1, arg2, arg3, arg4)
	return
	{
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Disable PaP Camo",
			"Weapons do not receive camo upon PaP, OVERRIDES ALL SETTINGS BELOW.",
			"MutatorSettings_CamoDisable",
			"mutator_camo_disable",
			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Cycle camos in-game",
			"Cycle through all selected camos every time you pack-a-punch",
			"MutatorSettings_CamoInGameCycle",
			"mutator_camo_ingame_cycle",
			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Black Ops",
			"Add Black Ops PaP camo to be randomly selected for the game",
			"MutatorSettings_CamoBlackOps",
			"mutator_camo_black_ops",
			BuildStringSettings({"On", "Off"}, "On"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"World at War",
			"Add World at War PaP camo to be randomly selected for the game",
			"MutatorSettings_CamoWorldAtWar",
			"mutator_camo_world_at_war",
			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Dark Matter",
			"Add Dark Matter to be randomly selected as PaP camo for the game",
			"MutatorSettings_CamoDarkMatter",
			"mutator_camo_dark_matter",
			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Ice",
			"Add Ice to be randomly selected as PaP camo for the game",
			"MutatorSettings_CamoIce",
			"mutator_camo_ice",
			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Ritual",
			"Add Ritual (Shadows of Evil) to be randomly selected as PaP camo for the game",
			"MutatorSettings_CamoRitual",
			"mutator_camo_ritual",
			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Etching",
			"Add Etching (The Giant/Nacht der Untoten/Verrückt/Shi No Numa) to be randomly selected as PaP camo for the game",
			"MutatorSettings_CamoEtching",
			"mutator_camo_etching",
			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Der Eisendrache Camos",
			"Add Topaz/Garnet/Sapphire/Emerald/Amethyst to be randomly selected as PaP camos for the game",
			"MutatorSettings_CamoDerEisendrache",
			"mutator_camo_der_eisendrache",
			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Overgrowth",
			"Add Overgrowth (Zetsubou No Shima) to be randomly selected as PaP camo for the game",
			"MutatorSettings_CamoOvergrowth",
			"mutator_camo_overgrowth",
			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Gorod Krovi Camos",
			"Add Dragon Fire/Glacies Fire (Blue Gorod Krovi)/Atomic Fire/Everlasting Fire/Arcane Fire to be randomly selected as PaP camos for the game",
			"MutatorSettings_CamoGorodKrovi",
			"mutator_camo_gorod_krovi",
			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Revelations Camos",
			"Add Cosmos/Cosmic/Infinitus/Into the Void/Universe to be randomly selected as PaP camos for the game",
			"MutatorSettings_CamoRevelations",
			"mutator_camo_revelations",
			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Circuits",
			"Add Circuits (BO III Kino der Toten) to be randomly selected as PaP camo for the game",
			"MutatorSettings_CamoKino",
			"mutator_camo_kino",
			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Origins",
			"Add Origins PaP camo to be randomly selected for the game",
			"MutatorSettings_CamoOrigins",
			"mutator_camo_origins",
			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Weaponized 115",
			"Add Weaponized 115 to be randomly selected as PaP camo for the game",
			"MutatorSettings_Weaponized115",
			"mutator_camo_weaponized_115",
			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting)
	}
end, nil, nil, Update)

DataSources.MutatorSettingsCustomMaps = DataSourceHelpers.ListSetup("MutatorSettingsCustomMaps",
function(arg0, arg1, arg2, arg3, arg4)
	return
	{
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Der Riese: Declassified PPSh-41",
			"Adds back Black Ops III PPSh-41 to Der Riese: Declassified",
			"MutatorSettings_DeclassifiedPPSh",
			"mutator_declassified_ppsh",
			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Der Riese: Declassified MG 42",
			"Adds back CoD: WWII MG 42 to Der Riese: Declassified",
			"MutatorSettings_DeclassifiedMG42",
			"mutator_declassified_mg42",
			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Call of the Dead Easter Egg Reward",
			"Force spawns Lightning Bolt powerup (Wunderwaffe DG-2) in place of Death Machine when defeating George A. Romero",
			"MutatorSettings_GeorgeReward",
			"mutator_george_reward",
			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting)
	}
end, nil, nil, Update)