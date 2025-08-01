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
	--Engine.SetDvar("mutator_aug", 0)
	--Engine.SetDvar("mutator_claymore", 0)
	Engine.SetDvar("mutator_raygunmkii", 0)
	--Engine.SetDvar("mutator_spacemonkey", 0)
	Engine.SetDvar("mutator_enable_wunderfizz", 0)
	--Engine.SetDvar("mutator_moon_random_char", 0)
	--Engine.SetDvar("mutator_camo_disable", 0)
	--Engine.SetDvar("mutuator_camo_black_ops", 0)
	--Engine.SetDvar("mutator_camo_world_at_war", 0)
	--Engine.SetDvar("mutator_camo_dark_matter", 0)
	--Engine.SetDvar("mutuator_camo_ritual", 0)
	--Engine.SetDvar("mutuator_camo_etching", 0)
	--Engine.SetDvar("mutuator_camo_der_eisendrache", 0)
	--Engine.SetDvar("mutuator_camo_overgrowth", 0)
	--Engine.SetDvar("mutuator_camo_gorod_krovi", 0)
	--Engine.SetDvar("mutuator_camo_revelations", 0)
	--Engine.SetDvar("mutator_camo_kino", 0)
	--Engine.SetDvar("mutuator_camo_origins", 0)
	--Engine.SetDvar("mutator_scopeads", 0)
	--Engine.SetDvar("mutator_camo_ingame_cycle", 0)
	Engine.SetDvar("mutator_george_reward", 0)
	Engine.SetDvar("mutator_round_music", 0)
	--Engine.SetDvar("mutator_camo_ice", 0)
	Engine.SetDvar("mutator_announcer", 0)
	--Engine.SetDvar("mutator_mystery_box_fx", 0)
	Engine.SetDvar("mutator_weapon_rest", 0)
	--Engine.SetDvar("mutator_redphone", 0)
	Engine.SetDvar("mutator_doubletap", 0)
	Engine.SetDvar("mutator_doubletap_existence", 0)
	Engine.SetDvar("mutator_deadshot_existence", 0)
	--Engine.SetDvar("mutator_eye_colour", 0)
	--Engine.SetDvar("mutator_camo_weaponized_115", 0)
	Engine.SetDvar("mutator_verruckt_springfield", 0)
	--Engine.SetDvar("mutator_map_visionset", 0)
	Engine.SetDvar("mutator_shinonuma_perk", 0)
	--Engine.SetDvar("mutator_sidestep", 0)
	--Engine.SetDvar("mutator_ascension_visionset", 0)
	Engine.SetDvar("mutator_health_difficulty", 0)
	Engine.SetDvar("mutator_startingweapon", 0)
	Engine.SetDvar("mutator_revive_anim", 0)
	Engine.SetDvar("mutator_wallbuys_der_eisendrache", 0)
	Engine.SetDvar("mutator_mule_kick", 0)
	Engine.SetDvar("mutator_health_difficulty", 0)
	Engine.SetDvar("mutator_reload_cancel", 0)
	Engine.SetDvar("mutator_sprint_cancel", 0)

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
            models        = { tabName 	= "WaW/BO Features", 				tabIcon = "" },
            properties    = { tabId 	= "MutatorSettingsBO", 				dataSourceName 	= "MutatorSettingsBO",	title =	"Black Ops Features Settings" }
        },
		{
            models        = { tabName 	= "Map Features", 				tabIcon = "" },
            properties    = { tabId 	= "MutatorSettingsBOMaps", 				dataSourceName 	= "MutatorSettingsBOMaps",	title =	"Map-specific Settings" }
        },
		{
            models        = { tabName 	= "General", 				        tabIcon = "" },
            properties    = { tabId 	= "MutatorSettingsGeneral", 		dataSourceName 	= "MutatorSettingsGeneral",	title =	"General Game Settings" }
        },
        {
            models        = { tabName 	= "Mystery Box", 				    tabIcon = "" },
            properties    = { tabId 	= "MutatorSettingsMysteryBox", 		dataSourceName 	= "MutatorSettingsMysteryBox",	title =	"Mystery Box Settings" }
        },
		--{
		--	models		  = { tabName	= "PaP Camo",						tabIcon = "" },
		--	properties	  = { tabId		= "MutatorSettingsPaPCamo",			dataSourceName	= "MutatorSettingsPaPCamo",		title = "Pack-a-Punch Camouflage Settings" }
		--},
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
			BuildStringSettings({"Use Map", "WaW"}, "WaW"), nil, SetDvarSetting),
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
			"Quick Revive",
			"If Quick Revive should cost 500 and work in solo like in Black Ops, or if it should always require power + cost 1500 and not provide solo revives like in World at War.",
			"MutatorSettings_QuickRevive",
			"mutator_quickrevive",
			BuildStringSettings({"BO", "WaW"}, "BO"), nil, SetDvarSetting),
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
			"If the perk icons should be set to the Classic icons, BO III with Classic colouring, or leave it at the map's own icons. MAY NOT WORK ON CUSTOM MAPS",
			"MutatorSettings_BOPerkIcons",
			"mutator_bo_perk_icons",
            BuildStringSettings({"Classic", "Recoloured BO III", "Use Map"}, "Classic"), nil, SetDvarSetting),
		--CoD.OptionsUtility.CreateDvarSettings(
		--	arg0,
		--	"Mine Wallbuy",
		--	"If the wallbuy should be Claymores instead of Trip Mines.",
		--	"MutatorSettings_Claymore",
		--	"mutator_claymore",
         --   BuildStringSettings({"Claymore", "Trip Mines"}, "Claymore"), nil, SetDvarSetting),
		--CoD.OptionsUtility.CreateDvarSettings(
		--	arg0,
		--	"Scope ADS",
		--	"If aiming down scope should be a 2D overlay, 3D viewmodel or changeable mid-game",
		--	"MutatorSettings_ScopeADS",
		--	"mutator_scopeads",
		--	BuildStringSettings({"2D Overlay", "3D Model", "Changeable"}, "Image Overlay"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Round Change Music",
			"Change between the BO III map-specific music and the World at War music",
			"MutatorSettings_RoundMusic",
			"mutator_round_music",
			BuildStringSettings({"WaW", "BO III"}, "WaW"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Mystery Box FX",
			"Change between BO III Mystery Box FX and previous games' FX",
			"MutatorSettings_MysteryBoxFX",
			"mutator_mystery_box_fx",
			BuildStringSettings({"BO III", "Classic"}, "BO III"), nil, SetDvarSetting),
		--CoD.OptionsUtility.CreateDvarSettings(
		--	arg0,
		--	"Zombie Dodging",
		--	"If zombies should side-step and roll like in Ascension.",
		--	"MutatorSettings_SideStep",
		--	"mutator_sidestep",
		--	BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Health Difficulty",
			"BO III has 3-hit-down system, All other settings are 2-hit-down.\nRecruit has the longest delay before health regeneration, Hardened/Veteran has the shortest delay\nVeteran shows the critically injured overlay at 50% health (i.e. after a single hit pre-Juggernog)",
			"MutatorSettings_HealthDifficulty",
			"mutator_health_difficulty",
			--BuildStringSettings({"BO III", "Recruit", "Regular", "Hardened", "Veteran"}, "BO III"), nil, SetDvarSetting)
			BuildStringSettings({"BO III", "Recruit", "Regular", "Veteran"}, "BO III"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Revive Animation",
			"Change between the classic revive animation and the Black Ops III one.",
			"MutatorSettings_ReviveAnimation",
			"mutator_revive_anim",
			BuildStringSettings({"Classic", "BO III"}, "Classic"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Carpenter",
			"Enable or disable the Carpenter powerup, for pre-Der Riese maps that didn't have it.",
			"MutatorSettings_Carpenter",
			"mutator_carpenter",
			BuildStringSettings({"On", "Off"}, "On"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Fire Sale",
			"Enable or disable the Fire Sale powerup.",
			"MutatorSettings_FireSale",
			"mutator_firesale",
			BuildStringSettings({"On", "Off"}, "On"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Death Machine",
			"Enable or disable the Death Machine powerup.",
			"MutatorSettings_DeathMachine",
			"mutator_deathmachine",
			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting)
			
	}
end, nil, nil, Update)

DataSources.MutatorSettingsBOMaps = DataSourceHelpers.ListSetup("MutatorSettingsBOMaps",
function (arg0, arg1, arg2, arg3, arg4)
	return
	{
		--CoD.OptionsUtility.CreateDvarSettings(
		--	arg0,
		--	"Scoped FG42 Wallbuy",
		--	"If the Scoped FG42 wallbuy (based on the Wii AUG wallbuy) should exist on Kino der Toten.",
		--	"MutatorSettings_AUG",
		--	"mutator_aug",
        --    BuildStringSettings({"On", "Off"}, "Off"), nil, SetDvarSetting),
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
			"Which perk out of Mule Kick/Quick Revive will be spawned in Shi no Numa's starting room, or if there will be a perk machine at all.",
			"MutatorSettings_ShiNoNumaPerk",
			"mutator_shinonuma_perk",
			BuildStringSettings({"Mule Kick", "Quick Revive", "None"}, "Mule Kick"), nil, SetDvarSetting),
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
			"Set starting weapon to the WaW M1911 (C-3000 b1at-ch35), BO M1911 (Mustang and Sally) or leave it at the map's default.",
			"MutatorSettings_StartingWeapon",
			"mutator_startingweapon",
			BuildStringSettings({"WaW", "BO", "Use Map"}, "WaW"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Verrückt Bolt Action Wallbuy",
			"Whether it should be a Springfield on the American starting room or a Kar98k",
			"MutatorSettings_VerrucktSpringfield",
			"mutator_verruckt_springfield",
			BuildStringSettings({"Kar98k", "Springfield"}, "Springfield"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Kino der Toten Wallbuys",
			"WaW Layout 1 is roughly based on Der Riese, WaW Layout 2 is by Conn6orsuper117, WaW Layout 3 is based on rough counterparts to BO weapons with an further option to swap the FG42/BAR (MPL/PM63)",
			"MutatorSettings_WallbuysKinoderToten",
			"mutator_wallbuys_kino_der_toten",
			BuildStringSettings({"WaW Layout 1", "WaW Layout 2", "WaW Layout 3", "WaW Layout 3 (Swapped)"}, "Black Ops"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Der Eisendrache Wallbuys",
			"WaW Layout 1 is by poyzee, WaW Layout 2 is by Conn6orsuper117",
			"MutatorSettings_WallbuysDerEisendrache",
			"mutator_wallbuys_der_eisendrache",
			BuildStringSettings({"WaW Layout 1", "WaW Layout 2"}, "WaW Layout 3"), nil, SetDvarSetting)
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
			"Fall Damage",
			"Set height values for fall damage to previous games' values",
			"MutatorSetings_FallDamage",
			"mutator_falldamage",
			BuildStringSettings({"BO III", "Classic"}, "Classic"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Sprinting movement mechanic",
			"Whether you should dive-to-prone, slide, or do nothing at all when pressing crouch/prone while sprinting",
			"MutatorSettings_SlideDive",
			"mutator_slide_dive",
			BuildStringSettings({"Dive to Prone", "Sliding", "None"}, "None"), nil, SetDvarSetting),
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
		--CoD.OptionsUtility.CreateDvarSettings(
		--	arg0,
		--	"Grenade Wallbuy",
		--	"Set all grenade wallbuys to be frags, semtexes, or leave it at the map's default. For maps like Kino der Toten and Ascension which didn't originally have semtexes.",
		--	"MutatorSettings_GrenadeWallbuy",
		--	"mutator_grenade_wallbuy",
		--	BuildStringSettings({"Default", "Frag", "Semtex"}, "Default"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Zombie Eye Colour",
			"Sets the zombies' glowing eyes to a different colour. Eyes on the model itself may still be visible through the glow fx.",
			"MutatorSettings_EyeColour",
			"mutator_eye_colour",
			BuildStringSettings({"Use Map", "Orange", "Blue", "Red", "White", "Green", "Purple", "Pink", "No Glow FX"}, "Use Map"), nil, SetDvarSetting),
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
			"DP-28",
			"Enable DP-28 in the mystery box for all maps.",
			"MutatorSetings_DP27",
			"mutator_dp27",
			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Ray Gun",
			"Switch between WaW Ray Gun and Improved BO3 Ray Gun",
			"MutatorSettings_RayGun",
			"mutator_ray_gun",
			BuildStringSettings({"WaW", "BO III"}, "WaW"), nil, SetDvarSetting),
--		CoD.OptionsUtility.CreateDvarSettings(
--			arg0,
--			"Ray Gun Mark II",
--			"Enable Ray Gun Mark II in the mystery box.",
--			"MutatorSettings_RayGunMkII",
--			"mutator_raygunmkii",
--           BuildStringSettings({"On", "Off"}, "On"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Monkey Bomb",
			"Enable or disable Monkey Bombs in the mystery box.",
			"MutatorSettings_MonkeyBomb",
			"mutator_monkey_bomb",
			BuildStringSettings({"On", "Off"}, "On"), nil, SetDvarSetting)
	}
end, nil, nil, Update)

--DataSources.MutatorSettingsPaPCamo = DataSourceHelpers.ListSetup("MutatorSettingsPaPCamo",
--function(arg0, arg1, arg2, arg3, arg4)
--	return
--	{
--		CoD.OptionsUtility.CreateDvarSettings(
--			arg0,
--			"Disable PaP Camo",
--			"Weapons do not receive camo upon PaP, OVERRIDES ALL SETTINGS BELOW.",
--			"MutatorSettings_CamoDisable",
--			"mutator_camo_disable",
--			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
--		CoD.OptionsUtility.CreateDvarSettings(
--			arg0,
--			"Cycle camos in-game",
--			"Cycle through all selected camos every time you pack-a-punch",
--			"MutatorSettings_CamoInGameCycle",
--			"mutator_camo_ingame_cycle",
--			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
--		CoD.OptionsUtility.CreateDvarSettings(
--			arg0,
--			"Black Ops",
--			"Add Black Ops PaP camo to be randomly selected for the game",
--			"MutatorSettings_CamoBlackOps",
--			"mutator_camo_black_ops",
--			BuildStringSettings({"On", "Off"}, "On"), nil, SetDvarSetting),
--		CoD.OptionsUtility.CreateDvarSettings(
--			arg0,
--			"World at War",
--			"Add World at War PaP camo to be randomly selected for the game",
--			"MutatorSettings_CamoWorldAtWar",
--			"mutator_camo_world_at_war",
--			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
--		CoD.OptionsUtility.CreateDvarSettings(
--			arg0,
--			"Dark Matter",
--			"Add Dark Matter to be randomly selected as PaP camo for the game",
--			"MutatorSettings_CamoDarkMatter",
--			"mutator_camo_dark_matter",
--			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
--		CoD.OptionsUtility.CreateDvarSettings(
--			arg0,
--			"Ice",
--			"Add Ice to be randomly selected as PaP camo for the game",
--			"MutatorSettings_CamoIce",
--			"mutator_camo_ice",
--			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
--		CoD.OptionsUtility.CreateDvarSettings(
--			arg0,
--			"Ritual",
--			"Add Ritual (Shadows of Evil) to be randomly selected as PaP camo for the game",
--			"MutatorSettings_CamoRitual",
--			"mutator_camo_ritual",
--			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
--		CoD.OptionsUtility.CreateDvarSettings(
--			arg0,
--			"Etching",
--			"Add Etching (The Giant/Nacht der Untoten/Verrückt/Shi No Numa) to be randomly selected as PaP camo for the game",
--			"MutatorSettings_CamoEtching",
--			"mutator_camo_etching",
--			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
--		CoD.OptionsUtility.CreateDvarSettings(
--			arg0,
--			"Der Eisendrache Camos",
--			"Add Topaz/Garnet/Sapphire/Emerald/Amethyst to be randomly selected as PaP camos for the game",
--			"MutatorSettings_CamoDerEisendrache",
--			"mutator_camo_der_eisendrache",
--			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
--		CoD.OptionsUtility.CreateDvarSettings(
--			arg0,
--			"Overgrowth",
--			"Add Overgrowth (Zetsubou No Shima) to be randomly selected as PaP camo for the game",
--			"MutatorSettings_CamoOvergrowth",
--			"mutator_camo_overgrowth",
--			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
--		CoD.OptionsUtility.CreateDvarSettings(
--			arg0,
--			"Gorod Krovi Camos",
--			"Add Dragon Fire/Glacies Fire (Blue Gorod Krovi)/Atomic Fire/Everlasting Fire/Arcane Fire to be randomly selected as PaP camos for the game",
--			"MutatorSettings_CamoGorodKrovi",
--			"mutator_camo_gorod_krovi",
--			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
--		CoD.OptionsUtility.CreateDvarSettings(
--			arg0,
--			"Revelations Camos",
--			"Add Cosmos/Cosmic/Infinitus/Into the Void/Universe to be randomly selected as PaP camos for the game",
--			"MutatorSettings_CamoRevelations",
--			"mutator_camo_revelations",
--			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
--		CoD.OptionsUtility.CreateDvarSettings(
--			arg0,
--			"Circuits",
--			"Add Circuits (BO III Kino der Toten) to be randomly selected as PaP camo for the game",
--			"MutatorSettings_CamoKino",
--			"mutator_camo_kino",
--			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
--		CoD.OptionsUtility.CreateDvarSettings(
--			arg0,
--			"Origins",
--			"Add Origins PaP camo to be randomly selected for the game",
--			"MutatorSettings_CamoOrigins",
--			"mutator_camo_origins",
--			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
--		CoD.OptionsUtility.CreateDvarSettings(
--			arg0,
--			"Weaponized 115",
--			"Add Weaponized 115 to be randomly selected as PaP camo for the game",
--			"MutatorSettings_Weaponized115",
--			"mutator_camo_weaponized_115",
--			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting)
--	}
--end, nil, nil, Update)

DataSources.MutatorSettingsCustomMaps = DataSourceHelpers.ListSetup("MutatorSettingsCustomMaps",
function(arg0, arg1, arg2, arg3, arg4)
	return
	{
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Call of the Dead Easter Egg Reward",
			"Force spawns Lightning Bolt powerup (Wunderwaffe DG-2) in place of Death Machine when defeating George A. Romero",
			"MutatorSettings_GeorgeReward",
			"mutator_george_reward",
			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		CoD.OptionsUtility.CreateDvarSettings(
			arg0,
			"Bonus Points",
			"Enable or disable the Bonus Points powerup. For Der Riese: Declassified.",
			"MutatorSettings_DeclassifiedBonusPoints",
			"mutator_declassified_bonuspoints",
			BuildStringSettings({"Off", "On"}, "Off"), nil, SetDvarSetting),
		--CoD.OptionsUtility.CreateDvarSettings(
		--	arg0,
		--	"gcp345's Der Riese Weapons",
		--	"Choose either the map's weapons or this mod's weapons for gcp345's Der Riese.",
		--	"MutatorSettings_FactoryClassic",
		--	"mutator_factory_classic",
		--	BuildStringSettings({"Use Map", "Use Mod"}, "Use Map"), nil, SetDvarSetting)
	}
end, nil, nil, Update)