#using scripts\codescripts\struct;
#using scripts\shared\aat_shared;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\zm_claymore;
#using scripts\zm\_zm_unitrigger;

//#using scripts\zm\zm_alcatraz_island;

#insert scripts\zm\_zm_mutators.gsh;

#namespace zm_swap_weapons;

/*
	Name: __init__sytem__
	Namespace: namespace_934d772b
	Checksum: 0x68BCA40E
	Offset: 0x520
	Size: 0x3B
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__sytem__()
{
	system::register("zm_swap_weapons", &init, &main, undefined);
}

/*
	Name: init
	Namespace: namespace_934d772b
	Checksum: 0x9ACF73B8
	Offset: 0x568
	Size: 0x3
	Parameters: 0
	Flags: None
*/
function init()
{
}

/*
	Name: main
	Namespace: namespace_934d772b
	Checksum: 0x7BAC8DE5
	Offset: 0x578
	Size: 0x7B
	Parameters: 0
	Flags: None
*/
function main()
{
	/*if(GetDvarString("mapname") != "zm_coast")
	{
		return;
	}*/
	thread swap_chalk();
	thread starter_weapon();
	level flag::wait_till("initial_blackscreen_passed");
	thread change_minigun();
}

/*
	Name: function_63f6ca02
	Namespace: namespace_934d772b
	Checksum: 0x152BE4F8
	Offset: 0x600
	Size: 0x9B
	Parameters: 0
	Flags: None
*/
function starter_weapon()
{
	wait(1);
	
	
	
	if(GetDvarString("mapname") == "zm_alcatraz_island")
	{
		//stop shank being added in MOTD Remastered
		//callback::remove_on_spawned(&zm_alcatraz_island::give_shank);
		arrayremoveindex(level._callbacks[#"on_player_spawned"], 24);
	}
	
	if(GetDvarString("mapname") == "zm_town"
		 || GetDvarString("mapname") == "zm_farm_hd"
		 || GetDvarString("mapname") == "zm_town_hd"
		 || GetDvarString("mapname") == "zm_diner")
	{
		if(GetDvarString("mapname") == "zm_town")
		{
			//remove other weapons in zm_t6_weapons.csv from mystery box
			level.zombie_weapons[GetWeapon("t6_pdw57")].is_in_box = false;
			zm_utility::include_weapon( "t6_pdw57", false);
			level.zombie_weapons[GetWeapon("t6_ak47")].is_in_box = false;
			zm_utility::include_weapon( "t6_ak47", false);
			level.zombie_weapons[GetWeapon("t6_lsat")].is_in_box = false;
			zm_utility::include_weapon( "t6_lsat", false);
			level.zombie_weapons[GetWeapon("t6_death_machine")].is_in_box = false;
			zm_utility::include_weapon( "t6_death_machine", false);	
		}
		else
		{
			//for Town Reimagined these are in zm_t6_weapons.csv
			zm_utility::include_weapon( "t6_fiveseven_rdw", true );
			zm_utility::include_weapon( "t6_fiveseven_up", false );
			zm_weapons::add_zombie_weapon( "t6_fiveseven_rdw", "t6_fiveseven_rdw", "", 1100, "pistol", "", undefined, "", false, "" );
			
			zm_utility::include_weapon( "t6_fal", true );
			zm_utility::include_weapon( "t6_fal_up", false );
			zm_weapons::add_zombie_weapon( "t6_fal", "t6_fal_up", "", 600, "rifle", "", undefined, "", false, "" );
			
			zm_utility::include_weapon( "t6_mtar", true );
			zm_utility::include_weapon( "t6_mtar_up", false );
			zm_weapons::add_zombie_weapon( "t6_mtar", "t6_mtar_up", "", 1300, "rifle", "", undefined, "", false, "" );
			
			zm_utility::include_weapon( "t6_galil", true );
			zm_utility::include_weapon( "t6_mtar_up", false );
			zm_weapons::add_zombie_weapon( "t6_galil", "t6_galil_up", "", 1400, "rifle", "", undefined, "", false, "" );
			
			zm_utility::include_weapon( "t6_s12", true );
			zm_utility::include_weapon( "t6_s12_up", false );
			zm_weapons::add_zombie_weapon( "t6_s12", "t6_s12_up", "", 1250, "shotgun", "", undefined, "", false, "" );
			
			zm_utility::include_weapon( "t6_m82a1", true );
			zm_utility::include_weapon( "t6_m82a1_up", false );
			zm_weapons::add_zombie_weapon( "t6_m82a1", "t6_m82a1_up", "", 2000, "sniper", "", undefined, "", false, "" );
			
			zm_utility::include_weapon( "t6_dsr50", true );
			zm_utility::include_weapon( "t6_dsr50", false );
			zm_weapons::add_zombie_weapon( "t6_dsr50", "t6_dsr50", "", 2000, "sniper", "", undefined, "", false, "" );
			
			zm_utility::include_weapon( "t6_rpg", true );
			zm_utility::include_weapon( "t6_rpg_up", false );
			zm_weapons::add_zombie_weapon( "t6_rpg", "t6_rpg_up", "", 3000, "launcher", "", undefined, "", false, "" );
			aat::register_aat_exemption(getweapon("t6_rpg_up"));
		}
		
		zm_utility::include_weapon( "t6_fiveseven", true );
		zm_utility::include_weapon( "t6_fiveseven_up", false );
		zm_weapons::add_zombie_weapon( "t6_fiveseven", "t6_fiveseven_up", "", 900, "pistol", "", undefined, "", false, "" );
		
		zm_utility::include_weapon( "t6_kap40", true );
		zm_utility::include_weapon( "t6_kap40_rdw_up", false );
		zm_weapons::add_zombie_weapon( "t6_kap40", "t6_kap40_rdw_up", "", 900, "pistol", "", undefined, "", false, "" );
		
		zm_utility::include_weapon( "t6_python", true );
		zm_utility::include_weapon( "t6_python_up", false );
		zm_weapons::add_zombie_weapon( "t6_python", "t6_python_up", "", 1000, "pistol", "", undefined, "", false, "" );
		
		zm_utility::include_weapon( "t6_chicom_cqb", true );
		zm_utility::include_weapon( "t6_chicom_cqb_up", false );
		zm_weapons::add_zombie_weapon( "t6_chicom_cqb", "t6_chicom_cqb_up", "", 1000, "smg", "", undefined, "", false, "" );
		
		zm_utility::include_weapon( "t6_smr", true );
		zm_utility::include_weapon( "t6_smr_up", false );
		zm_weapons::add_zombie_weapon( "t6_smr", "t6_smr_up", "", 600, "rifle", "", undefined, "", false, "" );
		
		zm_utility::include_weapon( "t6_m8a1", true );
		zm_utility::include_weapon( "t6_m8a1_up", false );
		zm_weapons::add_zombie_weapon( "t6_m8a1", "t6_m8a1_up", "", 1250, "rifle", "", undefined, "", false, "" );
		
		zm_utility::include_weapon( "t6_type25", true );
		zm_utility::include_weapon( "t6_type25_up", false );
		zm_weapons::add_zombie_weapon( "t6_type25", "t6_type25_up", "", 1200, "rifle", "", undefined, "", false, "" );
		
		zm_utility::include_weapon( "t6_m1216", true );
		zm_utility::include_weapon( "t6_m1216_up", false );
		zm_weapons::add_zombie_weapon( "t6_m1216", "t6_m1216_up", "", 1300, "shotgun", "", undefined, "", false, "" );
		
		zm_utility::include_weapon( "t6_hamr", true );
		zm_utility::include_weapon( "t6_hamr_up", false );
		zm_weapons::add_zombie_weapon( "t6_hamr", "t6_hamr_up", "", 2500, "lmg", "", undefined, "", false, "" );
		
		zm_utility::include_weapon( "t6_rpd", true );
		zm_utility::include_weapon( "t6_rpd_up", false );
		zm_weapons::add_zombie_weapon( "t6_rpd", "t6_rpd_up", "", 2500, "lmg", "", undefined, "", false, "" );
		
		/*zm_utility::include_weapon( "t9_ballistic_knife", true );
		zm_utility::include_weapon( "t9_ballistic_knife_up", false );
		zm_weapons::add_zombie_weapon( "t9_ballistic_knife", "t9_ballistic_knife_up", "", 2000, "", "", undefined, "", false, "" );
		aat::register_aat_exemption(getweapon("t9_ballistic_knife_up"));
		zm_utility::include_weapon( "knife_ballistic_bowie", false );
		zm_utility::include_weapon( "knife_ballistic_bowie_upgraded", false );
		zm_weapons::add_zombie_weapon( "knife_ballistic_bowie", "knife_ballistic_bowie_upgraded", "", 2000, "", "", undefined, "", false, "" );
		aat::register_aat_exemption(getweapon("knife_ballistic_bowie_upgraded"));*/
		
		zm_utility::include_weapon( "t6_war_machine", true );
		zm_utility::include_weapon( "t6_war_machine_up", false );
		zm_weapons::add_zombie_weapon( "t6_war_machine", "t6_war_machine_up", "", 1700, "launcher", "", undefined, "", false, "" );
		aat::register_aat_exemption(getweapon("t6_war_machine_up"));
	}
	else if(GetDvarString("mapname") == "zm_cellblock")
	{
		zm_utility::include_weapon( "t6_m1911", true );
		//zm_utility::include_weapon( "t6_m1911_rdw_up", false );
		//zm_weapons::add_zombie_weapon( "t6_m1911", "t6_m1911_rdw_up", "", 300, "pistol", "", undefined, "", false, "" );
		level.zombie_weapons[GetWeapon("t6_m1911")].is_in_box = true;
		zm_weapons::add_limited_weapon( "t6_m1911", 4 );
		
		zm_utility::include_weapon( "t6_fiveseven_rdw", true );
		zm_utility::include_weapon( "t6_fiveseven_up", false );
		zm_weapons::add_zombie_weapon( "t6_fiveseven_rdw", "t6_fiveseven_rdw", "", 1100, "pistol", "", undefined, "", false, "" );
		
		zm_utility::include_weapon( "t6_executioner", true );
		zm_utility::include_weapon( "t6_executioner_up", false );
		zm_weapons::add_zombie_weapon( "t6_executioner", "t6_executioner_up", "", 600, "pistol", "", undefined, "", false, "" );

		zm_utility::include_weapon( "t6_pdw57", true );
		zm_utility::include_weapon( "t6_pdw57_up", false );
		zm_weapons::add_zombie_weapon( "t6_pdw57", "t6_pdw57_up", "", 1000, "smg", "", undefined, "", false, "" );
		
		zm_utility::include_weapon( "t6_m1927", true );
		zm_utility::include_weapon( "t6_m1927_up", false );
		zm_weapons::add_zombie_weapon( "t6_m1927", "t6_m1927_up", "", 1500, "smg", "", undefined, "", false, "" );
		
		zm_utility::include_weapon( "t6_fal", true );
		zm_utility::include_weapon( "t6_fal_up", false );
		zm_weapons::add_zombie_weapon( "t6_fal", "t6_fal_up", "", 600, "rifle", "", undefined, "", false, "" );
		
		zm_utility::include_weapon( "t6_mtar", true );
		zm_utility::include_weapon( "t6_mtar_up", false );
		zm_weapons::add_zombie_weapon( "t6_mtar", "t6_mtar_up", "", 1300, "rifle", "", undefined, "", false, "" );
		
		zm_utility::include_weapon( "t6_ak47", true );
		zm_utility::include_weapon( "t6_ak47_up", false );
		zm_weapons::add_zombie_weapon( "t6_ak47", "t6_ak47_up", "", 1400, "rifle", "", undefined, "", false, "" );
		
		zm_utility::include_weapon( "t6_galil", true );
		zm_utility::include_weapon( "t6_mtar_up", false );
		zm_weapons::add_zombie_weapon( "t6_galil", "t6_galil_up", "", 1400, "rifle", "", undefined, "", false, "" );
			
		zm_utility::include_weapon( "t6_rem870mcs", true );
		zm_utility::include_weapon( "t6_rem870mcs_up", false );
		zm_weapons::add_zombie_weapon( "t6_rem870mcs", "t6_rem870mcs_up", "", 1200, "shotgun", "", undefined, "", false, "" );
			
		zm_utility::include_weapon( "t6_s12", true );
		zm_utility::include_weapon( "t6_s12_up", false );
		zm_weapons::add_zombie_weapon( "t6_s12", "t6_s12_up", "", 1250, "shotgun", "", undefined, "", false, "" );
			
		zm_utility::include_weapon( "t6_m82a1", true );
		zm_utility::include_weapon( "t6_m82a1_up", false );
		zm_weapons::add_zombie_weapon( "t6_m82a1", "t6_m82a1_up", "", 2000, "sniper", "", undefined, "", false, "" );
			
		zm_utility::include_weapon( "t6_dsr50", true );
		zm_utility::include_weapon( "t6_dsr50", false );
		zm_weapons::add_zombie_weapon( "t6_dsr50", "t6_dsr50", "", 2000, "sniper", "", undefined, "", false, "" );
		
		zm_utility::include_weapon( "t6_lsat", true );
		zm_utility::include_weapon( "t6_lsat_up", false );
		zm_weapons::add_zombie_weapon( "t6_lsat", "t6_lsat_up", "", 2000, "lmg", "", undefined, "", false, "" );
		
		zm_utility::include_weapon( "t6_death_machine", true );
		zm_utility::include_weapon( "t6_death_machine_up", false );
		zm_weapons::add_zombie_weapon( "t6_death_machine", "t6_death_machine_up", "", 5000, "lmg", "", undefined, "", false, "" );
		
		zm_utility::include_weapon( "t6_rpg", true );
		zm_utility::include_weapon( "t6_rpg_up", false );
		zm_weapons::add_zombie_weapon( "t6_rpg", "t6_rpg_up", "", 3000, "launcher", "", undefined, "", false, "" );
		aat::register_aat_exemption(getweapon("t6_rpg_up"));
		
		zm_utility::include_weapon( "t8_shotgun_blundergat", true );
		zm_utility::include_weapon( "t8_shotgun_blundergat_upgraded", false );
		zm_weapons::add_zombie_weapon( "t8_shotgun_blundergat", "t8_shotgun_blundergat_upgraded", "", 5000, "shotgun", "", undefined, "", true, "" );
		aat::register_aat_exemption(getweapon("t8_shotgun_blundergat_upgraded"));
		zm_weapons::add_limited_weapon( "t8_shotgun_blundergat", 1 );
	}
	else if(GetDvarString("mapname") == "zm_prison") //copforthat's Mob of the Dead
	{
		zm_utility::include_weapon( "t6_fiveseven_rdw", true );
		zm_utility::include_weapon( "t6_fiveseven_up", false );
		zm_weapons::add_zombie_weapon( "t6_fiveseven_rdw", "t6_fiveseven_rdw", "", 1100, "pistol", "", undefined, "", false, "" );
		
		zm_utility::include_weapon( "t6_executioner", true );
		zm_utility::include_weapon( "t6_executioner_up", false );
		zm_weapons::add_zombie_weapon( "t6_executioner", "t6_executioner_up", "", 600, "pistol", "", undefined, "", false, "" );

		zm_utility::include_weapon( "t6_pdw57", true );
		zm_utility::include_weapon( "t6_pdw57_up", false );
		zm_weapons::add_zombie_weapon( "t6_pdw57", "t6_pdw57_up", "", 1000, "smg", "", undefined, "", false, "" );
		
		zm_utility::include_weapon( "t6_fal", true );
		zm_utility::include_weapon( "t6_fal_up", false );
		zm_weapons::add_zombie_weapon( "t6_fal", "t6_fal_up", "", 600, "rifle", "", undefined, "", false, "" );
		
		zm_utility::include_weapon( "t6_mtar", true );
		zm_utility::include_weapon( "t6_mtar_up", false );
		zm_weapons::add_zombie_weapon( "t6_mtar", "t6_mtar_up", "", 1300, "rifle", "", undefined, "", false, "" );
		
		zm_utility::include_weapon( "t6_ak47", true );
		zm_utility::include_weapon( "t6_ak47_up", false );
		zm_weapons::add_zombie_weapon( "t6_ak47", "t6_ak47_up", "", 1400, "rifle", "", undefined, "", false, "" );
		
		zm_utility::include_weapon( "t6_galil", true );
		zm_utility::include_weapon( "t6_mtar_up", false );
		zm_weapons::add_zombie_weapon( "t6_galil", "t6_galil_up", "", 1400, "rifle", "", undefined, "", false, "" );
			
		zm_utility::include_weapon( "t6_s12", true );
		zm_utility::include_weapon( "t6_s12_up", false );
		zm_weapons::add_zombie_weapon( "t6_s12", "t6_s12_up", "", 1250, "shotgun", "", undefined, "", false, "" );
			
		zm_utility::include_weapon( "t6_m82a1", true );
		zm_utility::include_weapon( "t6_m82a1_up", false );
		zm_weapons::add_zombie_weapon( "t6_m82a1", "t6_m82a1_up", "", 2000, "sniper", "", undefined, "", false, "" );
		
		zm_utility::include_weapon( "t6_dsr50", true );
		zm_utility::include_weapon( "t6_dsr50", false );
		zm_weapons::add_zombie_weapon( "t6_dsr50", "t6_dsr50", "", 2000, "sniper", "", undefined, "", false, "" );
		
		zm_utility::include_weapon( "t6_lsat", true );
		zm_utility::include_weapon( "t6_lsat_up", false );
		zm_weapons::add_zombie_weapon( "t6_lsat", "t6_lsat_up", "", 2000, "lmg", "", undefined, "", false, "" );
		
		zm_utility::include_weapon( "t6_death_machine", true );
		zm_utility::include_weapon( "t6_death_machine_up", false );
		zm_weapons::add_zombie_weapon( "t6_death_machine", "t6_death_machine_up", "", 5000, "lmg", "", undefined, "", false, "" );
		
		zm_utility::include_weapon( "t6_rpg", true );
		zm_utility::include_weapon( "t6_rpg_up", false );
		zm_weapons::add_zombie_weapon( "t6_rpg", "t6_rpg_up", "", 3000, "launcher", "", undefined, "", false, "" );
		aat::register_aat_exemption(getweapon("t6_rpg_up"));
		
		zm_utility::include_weapon( "t6_xl_ray_gun", true );
		zm_utility::include_weapon( "t6_xl_ray_gun_up", false );
		zm_weapons::add_zombie_weapon( "t6_xl_ray_gun", "t6_xl_ray_gun_up", "", 10000, "wpck_ray", "", undefined, "", true, "" );
		aat::register_aat_exemption(getweapon("t6_xl_ray_gun_up"));
		
		zm_utility::include_weapon( "t6_xl_raygun_mark2", true );
		zm_utility::include_weapon( "t6_xl_raygun_mark2_up", false );
		zm_weapons::add_zombie_weapon( "t6_xl_raygun_mark2", "t6_xl_raygun_mark2_up", "", 10000, "raygun_mk2", "", undefined, "", true, "" );
		aat::register_aat_exemption(getweapon("t6_xl_raygun_mark2_up"));
		
		zm_utility::include_weapon( "t8_blundergat", true );
		zm_utility::include_weapon( "t8_blundergat_upgraded", false );
		zm_weapons::add_zombie_weapon( "t8_blundergat", "t8_blundergat_upgraded", "", 10000, "wpck_ray", "", undefined, "", true, "" );
		aat::register_aat_exemption(getweapon("t8_blundergat_upgraded"));
		zm_weapons::add_limited_weapon( "t8_blundergat", 1 );
	}
	
	if(GetDvarString("mapname") == "zm_town_hd")
	{
		zm_utility::include_weapon( "raygun_mark2", true );
		zm_utility::include_weapon( "raygun_mark2_upgraded", false );
		zm_weapons::add_zombie_weapon( "raygun_mark2", "raygun_mark2_upgraded", "", 5000, "raygun", "", undefined, "", true, "" );
		aat::register_aat_exemption(getweapon("raygun_mark2_upgraded"));
		
		zm_utility::include_weapon( "knife_ballistic", true );
		zm_utility::include_weapon( "knife_ballistic_upgraded", false );
		zm_weapons::add_zombie_weapon( "knife_ballistic", "knife_ballistic_upgraded", "", 1000, "", "", undefined, "", true, "" );
		aat::register_aat_exemption(getweapon("knife_ballistic_upgraded"));
	}
	else if(GetDvarString("mapname") == "zm_diner")
	{
		zm_utility::include_weapon( "otg_bo4_ray_gun", true );
		zm_utility::include_weapon( "otg_bo4_ray_gun_up", false );
		zm_weapons::add_zombie_weapon( "otg_bo4_ray_gun", "otg_bo4_ray_gun_up", "", 10000, "pistol", "", undefined, "", true, "" );
		aat::register_aat_exemption(getweapon("otg_bo4_ray_gun_up"));
		
		zm_utility::include_weapon( "t7_raygun_mark2", true );
		zm_utility::include_weapon( "t7_raygun_mark2_upgraded", false );
		zm_weapons::add_zombie_weapon( "t7_raygun_mark2", "t7_raygun_mark2_upgraded", "", 10000, "wpck_ray", "", undefined, "", true, "" );
		aat::register_aat_exemption(getweapon("t7_raygun_mark2_upgraded"));
	}
	
	/*if(GetDvarInt("mutator_bocw_1911") == 2)
	{
		zm_utility::include_weapon( "t9_1911", false);
		zm_utility::include_weapon( "t9_1911_rdw_up", false);
		zm_weapons::add_zombie_weapon( "t9_1911", "t9_1911_rdw_up", "", 300, "pistol", "", undefined, undefined, false, "" );
		aat::register_aat_exemption(getweapon("t9_1911"));
	}
	
	if(isdefined(level.pack_a_punch_camo_list))
	{	
		pap_camo = array::random(level.pack_a_punch_camo_list);
		switch(pap_camo)
		{
		case 75:
		case 84:
		case 121:
			level.pack_a_punch_camo_index_number_variants = 5;
			break;
		}
		level.pack_a_punch_camo_index = pap_camo;
	}
	else
		level.pack_a_punch_camo_index = 132;
	
	if(GetDvarInt("mutator_camo_disable") == 2)
		level.pack_a_punch_camo_index = 127; //blank camo, this is actually for Dempsey's Matryoshka Doll 
	
	//level.pack_a_punch_camo_index_number_variants = 1;
	
	if(GetDvarInt("mutator_startingweapon") != 2)*/
	{
		starting_weapon = GetWeapon("t6_m1911");
		starting_weapon_pap = GetWeapon("t6_m1911_rdw_up");
		
		if(GetDvarString("mapname") == "zm_tomb")
		{
			starting_weapon = GetWeapon("t6_mauser_c96");
			starting_weapon_pap = GetWeapon("t6_mauser_c96_up");
		}
		
		level.start_weapon = starting_weapon;
		level.default_laststandpistol = starting_weapon;
		level.default_solo_laststandpistol = starting_weapon_pap;
		thread zm::last_stand_pistol_rank_init();
		starter_weapon_extra();
	}
	if(GetDvarInt("mutator_revive_anim") == 1)
		level.weaponrevivetool = getweapon("legacy_syrette");
}

/*
	Name: function_6709b71c
	Namespace: namespace_934d772b
	Checksum: 0xA09ED1FF
	Offset: 0x6A8
	Size: 0x2E9
	Parameters: 0
	Flags: None
*/
function starter_weapon_extra()
{
	level flag::wait_till("initial_blackscreen_passed");
	
	starting_weapon = GetWeapon("t6_m1911");
	starting_weapon_pap = GetWeapon("t6_m1911_rdw_up");
	
	if(GetDvarString("mapname") == "zm_tomb")
	{
		starting_weapon = GetWeapon("t6_mauser_c96");
		starting_weapon_pap = GetWeapon("t6_mauser_c96_up");
	}
	
	level.start_weapon = starting_weapon;
	level.default_laststandpistol = starting_weapon;
	level.default_solo_laststandpistol = starting_weapon_pap;
	if(GetDvarString("mapname") != "zm_alcatraz_island" && GetDvarString("mapname") != "zm_prison") //don't add weapon at the start of the game while in Afterlife mode
	{
		foreach(player in GetPlayers())
			player thread give_starting_weapon(starting_weapon);
	}
	
	//DO NOT use any attachments here in pap_attach.csv
	level.zombie_weapons[GetWeapon("t6_b23r")].mysterybox_attachments = array("extclip");
	//level.zombie_weapons[GetWeapon("t6_ak74u")].mysterybox_attachments = array("extclip");
	level.zombie_weapons[GetWeapon("t6_mp40")].mysterybox_attachments = array("stalker");
	
	//parentweaponname check isn't working
	if(GetDvarString("mapname") == "zm_tomb")
	{
		level.weapons_using_ammo_sharing = true;
		zm_weapons::add_shared_ammo_weapon(GetWeapon("t6_ak74u_extmag"), GetWeapon("t6_ak74u"));
		zm_weapons::add_shared_ammo_weapon(GetWeapon("t6_ak74u_extmag_up"), GetWeapon("t6_ak74u_up"));
	}
	
	//callback_search(&zm_alcatraz_island::give_shank);
	
	/*level.pack_a_punch_camo_index = 136;
	foreach(player in GetPlayers())
	{
		player thread zm_equipment::show_hint_text("There is currently a known bug of crashing in co-op around round 16-17", 5, 1.5, 150);
	}
	wait(6);
	foreach(player in GetPlayers())
	{
		player thread zm_equipment::show_hint_text("The mod should work fine in solo, hope you enjoy!", 5, 1.5, 150);
	}*/
}

function give_starting_weapon(starting_weapon)
{
	if(GetDvarString("mapname") == "zm_town_hd")
	{
		while(!level.var_ee71e4d)
			wait(0.1);
		wait(1);
	}
	
	if(self GetCurrentWeapon() != starting_weapon || GetDvarString("mapname") == "zm_town_hd")
	{
		self TakeWeapon(self GetCurrentWeapon());
		self zm_weapons::weapon_give(starting_weapon, 0, 0, 1, 1);
	}
}

/*function callback_search(func)
{
	foreach(index, func_group in level._callbacks[#"on_player_spawned"])
	{
		if(func_group[0] == func)
		{
			foreach(player in GetPlayers())
			{
				player thread zm_equipment::show_hint_text(index, 5, 1.5, 150);
			}
			break;
		}
	}
}*/

/*
	Name: function_194c02a5
	Namespace: namespace_934d772b
	Checksum: 0x9FE0BCF4
	Offset: 0x9A0
	Size: 0x2D
	Parameters: 0
	Flags: None
*/
function change_minigun()
{
	level.zombie_powerup_weapon["minigun"] = GetWeapon("t6_death_machine");
}

/*
	Name: function_5d00cefc
	Namespace: namespace_934d772b
	Checksum: 0xFA97D96C
	Offset: 0x9D8
	Size: 0x281
	Parameters: 0
	Flags: None
*/
function swap_wall_weapon()
{
	/*switch(GetDvarInt("mutator_scopeads"))
	{
		case 1:
		{
			if(GetDvarInt("mutator_bocw_l96a1") == 2)
			{
				zm_utility::include_weapon( "t9_lw3_tundra_overlay", true );
				zm_utility::include_weapon( "t9_lw3_tundra_up_overlay", false );
				zm_weapons::add_zombie_weapon( "t9_lw3_tundra_overlay", "t9_lw3_tundra_up_overlay", "", 1900, "sniper", "", 500, "", false, "" );
			}
			else
			{
				zm_utility::include_weapon( "t5_l96a1_overlay", true );
				zm_utility::include_weapon( "t5_l96a1_up_overlay", false );
				zm_weapons::add_zombie_weapon( "t5_l96a1_overlay", "t5_l96a1_up_overlay", "", 1900, "sniper", "", 500, "", false, "" );
			}
			level.zombie_weapons[GetWeapon("t5_l96a1")].is_in_box = false;
			zm_utility::include_weapon( "t5_l96a1", false);
			
			break;
		}
		case 2:
		{
			if(GetDvarInt("mutator_bocw_l96a1") == 2)
			{
				zm_utility::include_weapon( "t9_lw3_tundra", true );
				zm_utility::include_weapon( "t9_lw3_tundra_up", false );
				zm_weapons::add_zombie_weapon( "t9_lw3_tundra", "t9_lw3_tundra_up", "", 1900, "sniper", "", 500, "", false, "" );
				level.zombie_weapons[GetWeapon("t5_l96a1")].is_in_box = false;
				zm_utility::include_weapon( "t5_l96a1", false);
			}
			
			break;
		}
		case 3:
		{
			if(GetDvarInt("mutator_bocw_l96a1") == 2)
			{
				zm_utility::include_weapon( "t9_lw3_tundra_switch", true );
				zm_utility::include_weapon( "t9_lw3_tundra_up_switch", false );
				zm_weapons::add_zombie_weapon( "t9_lw3_tundra_switch", "t9_lw3_tundra_up_switch", "", 1900, "sniper", "", 500, "", false, "" );
			}
			else
			{
				zm_utility::include_weapon( "t5_l96a1_switch", true );
				zm_utility::include_weapon( "t5_l96a1_up_switch", false );
				zm_weapons::add_zombie_weapon( "t5_l96a1_switch", "t5_l96a1_up_switch", "", 1900, "sniper", "", 500, "", false, "" );
			}
			level.zombie_weapons[GetWeapon("t5_l96a1")].is_in_box = false;
			zm_utility::include_weapon( "t5_l96a1", false);
			
			break;
		}
	}*/
	
	rk5 = 0;
	vesper = 0;
	kuda = 0;
	m8a7 = 0;
	krm262 = 0;
	argus = 0;
	sheiva = 0;
	lcar9 = 0;
	vmp = 0;
	hvk30 = 0;
	kn44 = 0;
	icr = 0;
	foreach(ent in struct::get_array("weapon_upgrade", "targetname"))
	{
		VAL = ent.zombie_weapon_upgrade;
		if(!isdefined(VAL))
		{
			continue;
		}
		
		if(VAL == "smg_mp40_1940" || VAL == "s2_mp40" )
			ent.zombie_weapon_upgrade = "t6_mp40";
		
		switch( GetDvarString("mapname") )
		{
		case "zm_prototype": //Nacht der Untoten
			{
				switch(VAL)
				{
				case "pistol_burst": //RK5
					ent.zombie_weapon_upgrade = "t6_smr";
					break;
				case "ar_marksman": //Sheiva
					ent.zombie_weapon_upgrade = "t6_ballista";
					break;
				case "smg_standard": //Kuda
					ent.zombie_weapon_upgrade = "t6_m1927";
					break;
				case "shotgun_pump": //KRM-262
					ent.zombie_weapon_upgrade = "t6_olympia";
					break;
				case "ar_standard": //KN-44
					ent.zombie_weapon_upgrade = "t6_an94";
					break;
				case "shotgun_precision": //Argus
					ent.zombie_weapon_upgrade = "t6_rem870mcs";
					break;
				case "smg_burst": //Pharo
					ent.zombie_weapon_upgrade = "t6_executioner";
					break;
				case "sniper_fastbolt": //Locus
					{
						/*switch(GetDvarInt("mutator_scopeads"))
						{
						case 1:
							ent.zombie_weapon_upgrade = "t6_dsr50_scope_overlay";
							break;
						case 3:
							ent.zombie_weapon_upgrade = "t6_dsr50_switch";
							break;
						default:*/
							ent.zombie_weapon_upgrade = "t6_dsr50";
							/*break;
						}*/
						
						break;
					}
				}
				break;
			}
		case "zm_asylum": //Verrückt
			{
				switch(VAL)
				{
				case "ar_marksman": //Sheiva
					ent.zombie_weapon_upgrade = "t6_ballista";
					break;
				case "pistol_burst": //RK5
					{
						if(rk5 == 0)
							ent.zombie_weapon_upgrade = "t6_m14";
						else
							ent.zombie_weapon_upgrade = "t6_fal";
							
						rk5++;
						break;
					}
				case "pistol_fullauto": //L-CAR 9
					ent.zombie_weapon_upgrade = "t6_m1927";
					break;
				case "smg_fastfire": //Vesper
				case "smg_standard": //Kuda
					ent.zombie_weapon_upgrade = "t6_rem870mcs";
					break;
				case "ar_stg44":
					ent.zombie_weapon_upgrade = "t6_stg44";
					break;
				case "shotgun_pump": //KRM-262
					ent.zombie_weapon_upgrade = "t6_olympia";
					break;
				case "smg_sten":
				case "ar_accurate": //ICR-1
					ent.zombie_weapon_upgrade = "t6_an94";
					break;
				case "ar_cqb": //HVK-30
					ent.zombie_weapon_upgrade = "t6_executioner";
					break;
				}
				break;
			}
		case "zm_sumpf": //Shi no Numa
			{
				switch(VAL)
				{
				case "pistol_burst": //RK5
					ent.zombie_weapon_upgrade = "t6_fal";
					break;
				case "ar_marksman": //Sheiva
					{
						ent.zombie_weapon_upgrade = "t6_ballista";
						
						ent.origin += (0, 2, 0);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (0, 2, 0);
						
						break;
					}
				case "pistol_fullauto": //L-CAR 9
					{
						ent.zombie_weapon_upgrade = "t6_m1927";
						
						ent.origin += (0, -1, 0);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (0, -1, 0);
						
						break;
					}
				case "smg_fastfire": //Vesper
					{
						ent.zombie_weapon_upgrade = "t6_rem870mcs";
					
						ent.origin = (10510, 200, -610);
						ent.angles = (0, 0, 0);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin = (10510, 200, -610);
						spawn_loc.angles = (0, 0, 0);
						break;
					}
				case "shotgun_pump": //KRM-262
					ent.zombie_weapon_upgrade = "t6_m14";
					break;
				case "smg_burst": //Pharo
					ent.zombie_weapon_upgrade = "t6_smr";
					break;
				case "ar_stg44":
					{
						ent.zombie_weapon_upgrade = "t6_stg44";
					
						spawn_loc = struct::get(ent.target, "targetname");
						ent.origin += (10*cos(spawn_loc.angles[1]), 10*sin(spawn_loc.angles[1]), 0);
						spawn_loc.origin += (10*cos(spawn_loc.angles[1]), 10*sin(spawn_loc.angles[1]), 0);
						break;
					}
				case "ar_longburst": //M8A7
					{
						ent.zombie_weapon_upgrade = "t6_mp5";
					
						spawn_loc = struct::get(ent.target, "targetname");
						ent.origin += (9*cos(spawn_loc.angles[1]), 9*sin(spawn_loc.angles[1]), 4);
						spawn_loc.origin += (9*cos(spawn_loc.angles[1]), 9*sin(spawn_loc.angles[1]), 4);
						break;
					}
				case "ar_standard": //KN-44
					ent.zombie_weapon_upgrade = "t6_ak74u";
					break;
				case "shotgun_precision": //Argus
				case "smg_standard": //Kuda
				case "smg_versatile": //VMP
				case "ar_cqb": //HVK-30
				case "ar_accurate": //ICR-1
					ent struct::delete();
					break;
				}
				
				/*
				switch(VAL)
					{
					case "pistol_burst": //RK5
						ent.zombie_weapon_upgrade = "t6_m14";
						break;
					case "ar_marksman": //Sheiva
						{
							ent.zombie_weapon_upgrade = "t6_olympia";
							
							ent.origin += (0, 10, 0);
							spawn_loc = struct::get(ent.target, "targetname");
							spawn_loc.origin += (0, 10, 0);
							break;
						}
					case "pistol_fullauto": //L-CAR 9
						{
							ent.zombie_weapon_upgrade = "t6_m16a1";
							
							ent.origin += (0, 10, 4);
							spawn_loc = struct::get(ent.target, "targetname");
							spawn_loc.origin += (0, 10, 4);
							break;
						}
					case "smg_fastfire": //Vesper
						{
							ent.zombie_weapon_upgrade = "t6_mp5";
						
							ent.origin = (10510, 200, -610);
							ent.angles = (0, 0, 0);
							spawn_loc = struct::get(ent.target, "targetname");
							spawn_loc.origin = (10510, 200, -610);
							spawn_loc.angles = (0, 0, 0);
							break;
						}
					case "shotgun_pump": //KRM-262
						ent.zombie_weapon_upgrade = "t6_m14";
						break;
					case "smg_burst": //Pharo
						ent.zombie_weapon_upgrade = "t6_mp5";
						break;
					case "ar_stg44":
						{
							ent.zombie_weapon_upgrade = "t6_ak74u";
						
							ent.origin += (10*cos(spawn_loc.angles[1]), 10*sin(spawn_loc.angles[1]), 0);
							spawn_loc = struct::get(ent.target, "targetname");
							spawn_loc.origin += (10*cos(spawn_loc.angles[1]), 10*sin(spawn_loc.angles[1]), 0);
							break;
						}
					case "ar_longburst": //M8A7
						{
						ent.zombie_weapon_upgrade = "t6_b23r";
					
						ent.origin += (9*cos(spawn_loc.angles[1]), 9*sin(spawn_loc.angles[1]), 4);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (9*cos(spawn_loc.angles[1]), 9*sin(spawn_loc.angles[1]), 4);
						break;
						}
					case "ar_standard": //KN-44
						ent.zombie_weapon_upgrade = "t6_ak74u";
						break;
					case "shotgun_precision": //Argus
					case "smg_standard": //Kuda
					case "smg_versatile": //VMP
					case "ar_cqb": //HVK-30
					case "ar_accurate": //ICR-1
						ent struct::delete();
						break;
					}
				*/
				break;
			}
		case "zm_factory": //The Giant
			{
				switch(VAL)
				{
				case "pistol_burst": //RK5
					ent.zombie_weapon_upgrade = "t6_ballista";
					break;
				case "ar_marksman": //Sheiva
					ent.zombie_weapon_upgrade = "t6_fal";
					break;
				case "shotgun_pump": //KRM-262
					ent.zombie_weapon_upgrade = "t6_olympia";
					break;
				case "smg_versatile": //VMP
					{
						ent.zombie_weapon_upgrade = "t6_m1927";
						
						/*ent.origin += (20, 0, 0);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (20, 0, 0);*/
						break;
					}
				case "pistol_fullauto": //L-CAR 9
					ent.zombie_weapon_upgrade = "t6_smr";
					break;
				case "smg_fastfire": //Vesper
				case "ar_cqb": //HVK-30
					ent.zombie_weapon_upgrade = "t6_mp5";
					break;
				case "smg_standard": //Kuda
					{
						ent.zombie_weapon_upgrade = "t6_rem870mcs";
						
						/*ent.origin += (0, 5, 5);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (0, 5, 5);*/
						break;
					}
				case "ar_longburst": //M8A7
					{
						ent.zombie_weapon_upgrade = "t6_mp40";
						/*ent.origin += (1, 0, 0);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (1, 0, 0);*/
						break;
					}
				case "ar_standard": //KN-44
					ent.zombie_weapon_upgrade = "t6_stg44";
					break;
				}
				break;
			}
		case "zm_theater": //Kino der Toten
			{
				switch(VAL)
				{
					case "ar_marksman": //Sheiva
					{
						ent.zombie_weapon_upgrade = "t6_olympia";
						break;
					}
					case "pistol_burst": //RK5
					{
						ent.zombie_weapon_upgrade = "t6_m14";
						break;
					}
					case "smg_burst": //Pharo
					{
						ent struct::delete();
						break;
					}
					case "smg_fastfire": //Vesper
					{
						ent.zombie_weapon_upgrade = "t6_pdw57";
						break;
					}
					case "shotgun_precision": //Argus
					{
						ent.zombie_weapon_upgrade = "t6_rem870mcs";
						break;
					}
					case "ar_standard": //KN-44
					{
						ent.zombie_weapon_upgrade = "t6_mp5";
						break;
					}
					case "ar_accurate": //ICR-1
					{
						ent.zombie_weapon_upgrade = "t6_m16a1";
						break;
					}
					case "pistol_fullauto": //L-CAR 9
					{
						ent.zombie_weapon_upgrade = "t6_b23r";
						ent.origin += (0, -2, 0);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (0, -2, 0);
						break;
					}
					case "smg_versatile": //VMP
					{
						ent.zombie_weapon_upgrade = "t6_ak74u";
						break;
					}
					case "ar_longburst": //M8A7
					{
						ent struct::delete();
						break;
					}
				}
				break;
			}
		case "zm_cosmodrome": //Ascension
			{
				switch(VAL)
				{
				case "ar_marksman": //Sheiva
					ent.zombie_weapon_upgrade = "t6_m14";
					break;
				case "pistol_burst": //RK5
				{
					if (rk5 == 0)
						ent.zombie_weapon_upgrade = "t6_olympia";
					else
						ent.zombie_weapon_upgrade = "t6_mp5";
					
					rk5 = 1;
					break;
				}
				case "shotgun_precision": //Argus
					ent.zombie_weapon_upgrade = "t6_rem870mcs";
					break;
				case "ar_standard": //KN-44
					ent struct::delete();
					break;
				case "smg_fastfire": //Vesper
					ent.zombie_weapon_upgrade = "t6_ak74u";
					break;
				case "ar_accurate": //ICR-1
					ent struct::delete();
					break;
				case "pistol_fullauto": //L-CAR 9
					ent.zombie_weapon_upgrade = "t6_b23r";
					break;
				case "smg_versatile": //VMP
					ent.zombie_weapon_upgrade = "t6_pdw57";
					break;
				//Remove
				case "smg_standard": //Kuda
					ent struct::delete();
					break;
				case "ar_cqb": //HVK-30
					ent.zombie_weapon_upgrade = "t6_m16a1";
					break;
				}
				break;
			}
		case "zm_temple": //Shangri-La
			{
				switch(VAL)
				{
					case "ar_marksman": //Sheiva
					{
						if(GetDvarInt("mutator_bocw_m14") == 2)
							ent.zombie_weapon_upgrade = "t9_m14classic";
						else
							ent.zombie_weapon_upgrade = "t5_m14";
						
						break;
					}
					case "pistol_burst": //RK5
					{
						ent.zombie_weapon_upgrade = "t5_olympia";
						break;
					}
					case "ar_standard": //KN-44
					{
						if(GetDvarInt("mutator_bocw_m16") == 2)
							ent.zombie_weapon_upgrade = "t9_m16";
						else	
							ent.zombie_weapon_upgrade = "t5_m16a1";
						
						break;
					}
					case "ar_accurate": //ICR-1
					{
						if(GetDvarInt("mutator_bocw_hauer77") == 2)
							ent.zombie_weapon_upgrade = "t9_hauer77";
						else
							ent.zombie_weapon_upgrade = "t5_stakeout";
						
						break;
					}
					case "pistol_fullauto": //L-CAR 9
					{
						if(GetDvarInt("mutator_bocw_pm63") == 2)
							ent.zombie_weapon_upgrade = "t9_amp63";
						else
							ent.zombie_weapon_upgrade = "t5_pm63";
						
						break;
					}
					case "smg_burst": //Pharo
					{
						ent.zombie_weapon_upgrade = "t5_mpl";
						break;
					}
					case "smg_fastfire": //Vesper
					{
						if(GetDvarInt("mutator_bocw_mp5k") == 2)
							ent.zombie_weapon_upgrade = "t9_mp5k";
						else
							ent.zombie_weapon_upgrade = "t5_mp5k";
						
						break;
					}
					case "smg_standard": //Kuda
					{
						if(GetDvarInt("mutator_bocw_ak74u") == 2)
							ent.zombie_weapon_upgrade = "t9_ak74u";
						else
							ent.zombie_weapon_upgrade = "t5_ak74u";
						
						break;
					}
					case "frag_grenade":
					{
						ent.zombie_weapon_upgrade = "sticky_grenade_custom";
						break;
					}
				}
				break;
			}
		case "zm_moon":
			{
				switch(VAL)
				{
				case "ar_marksman": //Sheiva
					ent.zombie_weapon_upgrade = "t6_m14";
					break;
				case "pistol_burst": //RK5
					{
						ent.zombie_weapon_upgrade = "t6_olympia";
						
						ent.origin += (0, 10, 0);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (0, 10, 0);
						
						break;
					}
				case "ar_standard": //KN-44
					ent.zombie_weapon_upgrade = "t6_ak74u";
					break;
				case "shotgun_precision": //Argus
					ent.zombie_weapon_upgrade = "t6_rem870mcs";
					break;
				case "pistol_fullauto": //L-CAR 9
					ent.zombie_weapon_upgrade = "t6_b23r";
					break;
				case "smg_burst": //Pharo
					ent.zombie_weapon_upgrade = "t6_pdw57";
					break;
				case "smg_versatile": //VMP
					ent.zombie_weapon_upgrade = "t6_mp5";
					break;
				case "smg_standard": //Kuda
					ent.zombie_weapon_upgrade = "t6_m16a1";
					break;
				/*case "frag_grenade":
					ent.zombie_weapon_upgrade = "sticky_grenade_custom";
					break;*/
				}
				break;
			}
		case "zm_giant": //TrustInUma's DER RIESE
			{
				switch(VAL)
				{
				case "ar_marksman": //Sheiva
					ent.zombie_weapon_upgrade = "t4_g43";
					break;
				case "pistol_burst": //RK5
					ent.zombie_weapon_upgrade = "t4_kar98k";
					break;
				case "pistol_fullauto": //L-CAR 9
					ent.zombie_weapon_upgrade = "t4_carbine";
					break;
				case "ar_cqb": //HVK-30
					ent.zombie_weapon_upgrade = "t4_fg42";
					break;
				case "shotgun_pump": //KRM-262
					ent.zombie_weapon_upgrade = "t4_db";
					break;
				case "smg_burst": //Pharo
					ent.zombie_weapon_upgrade = "t4_thompson";
					break;
				case "shotgun_precision": //Argus
					ent.zombie_weapon_upgrade = "t4_m1897";
					break;
				case "smg_mp40_1940":
					{
						ent.origin += (4, 0, 0);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (4, 0, 0);
						break;
					}
				case "smg_sten":
					ent.zombie_weapon_upgrade = "t4_type100";
					break;
				case "ar_stg44":
					ent.zombie_weapon_upgrade = "t4_mp44";
					break;
				}
				break;
			}
		case "zm_der_riese": //Der Riese: Declassified
			{
				switch(VAL)
				{
				case "s2_kar98k_irons":
					ent.zombie_weapon_upgrade = "t4_kar98k";
					break;
				case "s2_gewehr43":
					ent.zombie_weapon_upgrade = "t4_g43";
					break;
				case "s2_m30":
					ent.zombie_weapon_upgrade = "t4_db";
					break;
				case "s2_thompsonm1a1":
					ent.zombie_weapon_upgrade = "t4_thompson";
					break;
				case "s2_m1a1carbine":
					ent.zombie_weapon_upgrade = "t4_carbine";
					break;
				case "s2_fg42":
					ent.zombie_weapon_upgrade = "t4_fg42";
					break;
				case "t8_m1897":
					{
						ent.zombie_weapon_upgrade = "t4_m1897";
						ent.origin += (0, 10, 5);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (0, 10, 5);
						break;
					}
				case "s2_type100":
					ent.zombie_weapon_upgrade = "t4_type100";
					break;
				case "s2_stg44":
					ent.zombie_weapon_upgrade = "t4_mp44";
					break;
				}
				break;
			}
		case "zm_tomb": //Origins
			{
				switch(VAL)
				{
				case "pistol_burst": //RK5
					ent.zombie_weapon_upgrade = "t6_m14";
					break;
				case "ar_marksman": //Sheiva":
					ent.zombie_weapon_upgrade = "t6_ballista";
					break;
				case "pistol_fullauto": //L-CAR 9
					ent.zombie_weapon_upgrade = "t6_b23r";
					break;
				case "smg_fastfire": //Vesper
				{
					if(vesper == 0)
					{
						ent.zombie_weapon_upgrade = "t6_fiveseven";
						vesper = 1;
					}
					else
						ent.zombie_weapon_upgrade = "t6_ak74u";
					break;
				}
				case "shotgun_pump": //KRM-262
					ent.zombie_weapon_upgrade = "t6_rem870mcs";
					break;
				case "shotgun_precision": //Argus
				{
					if(argus == 0)
					{
						ent.zombie_weapon_upgrade = "t6_rem870mcs";
						argus = 1;
					}
					else
						ent.zombie_weapon_upgrade = "t6_fiveseven";
					break;
				}
				case "smg_standard": //Kuda
					ent.zombie_weapon_upgrade = "t6_ak74u";
					break;
				case "smg_versatile": //VMP
				case "ar_standard": //KN-44
					ent.zombie_weapon_upgrade = "t6_mp40";
					break;
				case "ar_accurate": //ICR-1
					ent.zombie_weapon_upgrade = "t6_b23r";
					break;
				case "ar_longburst": //M8A7
					ent.zombie_weapon_upgrade = "t6_ak74u";
					break;
				case "ar_cqb": //HVK-30
					ent.zombie_weapon_upgrade = "t6_rem870mcs";
					break;
				case "ar_stg44":
				case "smg_thompson":
					ent.zombie_weapon_upgrade = "t6_stg44";
					break;
				}
				break;
			}
		case "zm_nuked": //Nuketown Zombies
			{
				switch(VAL)
				{
				case "ar_marksman": //Sheiva
					{
						ent.zombie_weapon_upgrade = "t6_olympia";
						
						ent.origin += (0, 5, 0);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (0, 5, 0);
						
						break;
					}
				case "pistol_burst": //RK5
					{
						ent.zombie_weapon_upgrade = "t6_m14";
						
						ent.origin += (0, -10, 0);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (0, -10, 0);
						
						break;
					}
				case "shotgun_pump": //KRM-262
					ent.zombie_weapon_upgrade = "t6_rem870mcs";
					break;
				case "ar_longburst": //M8A7
					ent.zombie_weapon_upgrade = "t6_m16a1";
					break;
				case "pistol_fullauto": //L-CAR 9
					ent.zombie_weapon_upgrade = "t6_b23r";
					break;
				case "smg_standard": //Kuda
					ent.zombie_weapon_upgrade = "t6_mp5";
					break;
				case "smg_versatile": //VMP
					ent.zombie_weapon_upgrade = "t6_ak74u";
					break;
				/*case "frag_grenade":
					ent.zombie_weapon_upgrade = "sticky_grenade_custom";
					break;*/
				}
				break;
			}
		case "zm_alcatraz_island": //Mob Of The Dead Remastered
			{
				switch(VAL)
				{
				case "bo2_m14":
					ent.zombie_weapon_upgrade = "t6_m14";
					break;
				case "bo2_olympia":
					{	
						ent.zombie_weapon_upgrade = "t6_olympia";
						
						ent.origin += (0, 12, 0);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (0, 12, 0);
						
						break;
					}
				case "pistol_beretta93r":
					ent.zombie_weapon_upgrade = "t6_b23r";
					break;
				case "mwr_mp5":
					ent.zombie_weapon_upgrade = "t6_mp5";
					break;
				case "bo2_uzi":
					{
						ent.zombie_weapon_upgrade = "t6_uzi";
						
						spawn_loc = struct::get(ent.target, "targetname");
						ent.origin += (-11*cos(spawn_loc.angles[1]), -11*sin(spawn_loc.angles[1]), -4);
						spawn_loc.origin += (-11*cos(spawn_loc.angles[1]), -11*sin(spawn_loc.angles[1]), -4);
						
						break;
					}
				case "bo2_m1927":
					{
						ent.zombie_weapon_upgrade = "t6_m1927";
						
						ent.origin += (0, 1, -1);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (0, 1, -1);
						
						break;
					}
				case "shotgun_870mcs":
					ent.zombie_weapon_upgrade = "t6_rem870mcs";
					break;
				}
				break;
			}
		case "zm_town": //Town Reimagined
			{
				switch(VAL)
				{
				case "t6_ar_m14":
					ent.zombie_weapon_upgrade = "t6_m14";
					break;
				case "t7_shotgun_rottweil72":
					{
						ent.zombie_weapon_upgrade = "t6_olympia";
						
						ent.origin += (0, 0, 1);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (0, 0, 1);
						
						break;
					}
				case "t6_sniper_ballista":
					ent struct::delete();
					break;
				case "t6_smg_mp5":
					ent.zombie_weapon_upgrade = "t6_mp5";
					break;
				}
				break;
			}
		case "zm_farm_hd":
			{
				switch(VAL)
				{
				case "ar_marksman": //Sheiva
					{
						ent.zombie_weapon_upgrade = "t6_olympia";
						
						ent.origin += (2, 0, -4);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (2, 0, -4);
						
						break;
					}
				case "smg_standard": //Kuda
					ent.zombie_weapon_upgrade = "t6_mp5";
					break;
				}
				break;
			}
		case "zm_town_hd": //Town Remastered
			{
				switch(VAL)
				{
				case "town_ar_m14":
					ent.zombie_weapon_upgrade = "t6_m14";
					break;
				case "shotgun_olympia":
					ent.zombie_weapon_upgrade = "t6_olympia";
					break;
				case "town_smg_mp5":
					ent.zombie_weapon_upgrade = "t6_mp5";
					break;
				}
				break;
			}
		case "zm_prison": //copforthat's Mob of the Dead
			{
				switch(VAL)
				{
				case "t6_xl_m14":
					ent.zombie_weapon_upgrade = "t6_m14";
					break;
				case "t6_xl_olympia":
					ent.zombie_weapon_upgrade = "t6_olympia";
					break;
				case "t6_xl_b23r":
					ent.zombie_weapon_upgrade = "t6_b23r";
					break;
				case "t6_xl_mp5":
					ent.zombie_weapon_upgrade = "t6_mp5";
					break;
				case "t6_xl_uzi":
					ent.zombie_weapon_upgrade = "t6_uzi";
					break;
				case "t6_xl_m1927":
					ent.zombie_weapon_upgrade = "t6_m1927";
					break;
				case "t6_xl_rem870":
					ent.zombie_weapon_upgrade = "t6_rem870mcs";
					break;
				}
				break;
			}
		case "zm_die": //Die Rise
			{
				switch(VAL)
				{
				case "t6_ar_m14":
					ent.zombie_weapon_upgrade = "t6_m14";
					break;
				case "t6_shotgun_olympia":
					ent.zombie_weapon_upgrade = "t6_olympia";
					break;
				case "t6_pistol_b23r":
					ent.zombie_weapon_upgrade = "t6_b23r";
					break;
				case "t6_smg_mp5":
					ent.zombie_weapon_upgrade = "t6_mp5";
					break;
				case "t6_smg_ak74u":
					ent.zombie_weapon_upgrade = "t6_ak74u";
					break;
				case "t6_smg_pdw57":
					ent.zombie_weapon_upgrade = "t6_pdw57";
					break;
				case "t6_ar_m16":
					ent.zombie_weapon_upgrade = "t6_m16a1";
					break;
				case "t6_ar_an94":
					ent.zombie_weapon_upgrade = "t6_an94";
					break;
				case "t6_shotgun_rem870":
					ent.zombie_weapon_upgrade = "t6_rem870mcs";
					break;
				case "t6_sniper_svu":
					ent.zombie_weapon_upgrade = "t6_svu_as";
					break;
				}
				break;
			}
		case "zm_diner":
			{
				switch(VAL)
				{
				case "ar_m14":
					ent.zombie_weapon_upgrade = "t6_m14";
					break;
				case "t8_m1897":
					ent.zombie_weapon_upgrade = "t6_rem870mcs";
					break;
				case "shotgun_olympia":
					ent.zombie_weapon_upgrade = "t6_olympia";
					break;
				case "t8_essex_m07":
					{
						ent.zombie_weapon_upgrade = "t6_ballista";
						
						spawn_loc = struct::get(ent.target, "targetname");
						ent.origin += (-1*cos(spawn_loc.angles[1]), -1*sin(spawn_loc.angles[1]), -2);
						spawn_loc.origin += (-1*cos(spawn_loc.angles[1]), -1*sin(spawn_loc.angles[1]), -2);
						
						break;
					}
				case "t8_mog12":
					{
						ent.zombie_weapon_upgrade = "t6_ksg";
						
						ent.origin += (0, 5, -2);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (0, 5, -2);
						
						break;
					}
				case "t8_mx9":
					ent.zombie_weapon_upgrade = "t6_mp5";
					break;
				case "t8_rk7":
					ent.zombie_weapon_upgrade = "t6_b23r";
					break;
				case "t8_saug9mm":
					ent.zombie_weapon_upgrade = "t6_uzi";
					break;
				case "ar_m16":
					ent.zombie_weapon_upgrade = "t6_m16a1";
					break;
				case "t8_kn57":
					ent.zombie_weapon_upgrade = "t6_ak74u";
					break;
				}
				break;
			}
		/*case "zm_coast":
			{
				if(GetDvarInt("mutator_wallbuys_callofthedead") == 2)
				{
					switch(VAL)
					{
						case "t5_olympia":
							{
								ent.zombie_weapon_upgrade = "t4_kar98k";
								
								ent.origin += (8*cos(spawn_loc.angles[1]), 8*sin(spawn_loc.angles[1]), 0);
								spawn_loc = struct::get(ent.target, "targetname");
								spawn_loc.origin += (8*cos(spawn_loc.angles[1]), 8*sin(spawn_loc.angles[1]), 0);
								
								break;
							}
						case "t5_m14":
							{
								ent.zombie_weapon_upgrade = "t4_g43";
								
								ent.origin += (10*cos(spawn_loc.angles[1]), 10*sin(spawn_loc.angles[1]), 0);
								spawn_loc = struct::get(ent.target, "targetname");
								spawn_loc.origin += (10*cos(spawn_loc.angles[1]), 10*sin(spawn_loc.angles[1]), 0);
								
								break;
							}
						case "t5_mpl":
							ent.zombie_weapon_upgrade = "t4_carbine";
							break;
						case "t5_pm63":
							ent.zombie_weapon_upgrade = "t4_db";
							break;
						case "t5_mp40":
							ent.zombie_weapon_upgrade = "t5_mp40";
							break;
						case "t5_stakeout":
							{
								ent.zombie_weapon_upgrade = "t4_m1897";
								
								ent.origin += (-3, 10, 0);
								spawn_loc = struct::get(ent.target, "targetname");
								spawn_loc.origin += (-3, 10, 0);
								
								break;
							}
						case "t5_mp5k":
							ent.zombie_weapon_upgrade = "t4_type100";
							break;
						case "t5_m16a1":
							ent.zombie_weapon_upgrade = "t4_mp44";
							break;
						case "t5_ak74u":
							ent.zombie_weapon_upgrade = "t4_thompson";
							break;
					}
				}
				break;
			}*/
		/*case "zm_zod": //Shadows of Evil
			{
				switch(VAL)
				{
				case "ar_marksman": //Sheiva
					{
						if(GetDvarInt("mutator_bocw_m14") == 2)
							ent.zombie_weapon_upgrade = "t9_m14classic";
						else
							ent.zombie_weapon_upgrade = "t5_m14";
						
						break;
					}
				case "pistol_burst": //RK5
					ent.zombie_weapon_upgrade = "t5_olympia";
					break;
				case "shotgun_pump": //KRM-262
					{
						if(GetDvarInt("mutator_bocw_hauer77") == 2)
							ent.zombie_weapon_upgrade = "t9_hauer77";
						else
							ent.zombie_weapon_upgrade = "t5_stakeout";
						
						break;
					}
				case "pistol_fullauto": //L-CAR 9
					{
						if(GetDvarInt("mutator_bocw_pm63") == 2)
							ent.zombie_weapon_upgrade = "t9_amp63";
						else
							ent.zombie_weapon_upgrade = "t5_pm63";
						
						break;
					}
				case "ar_standard": //KN-44
					{
						if(GetDvarInt("mutator_bocw_ak74u") == 2)
							ent.zombie_weapon_upgrade = "t9_ak74u";
						else
							ent.zombie_weapon_upgrade = "t5_ak74u";
						
						break;
					}
				case "smg_versatile": //VMP
					ent.zombie_weapon_upgrade = "t5_mpl";
					break;
				case "ar_cqb": //HVK-30
					{
						if(GetDvarInt("mutator_bocw_m16") == 2)
							ent.zombie_weapon_upgrade = "t9_m16";
						else	
							ent.zombie_weapon_upgrade = "t5_m16a1";
						
						break;
					}
				case "smg_fastfire": //Vesper
					{
						if (vesper == 0) //Footlight District
						{
							if(GetDvarInt("mutator_bocw_ak74u") == 2)
								ent.zombie_weapon_upgrade = "t9_ak74u";
							else
								ent.zombie_weapon_upgrade = "t5_ak74u";
						}
						else
						{
							if(GetDvarInt("mutator_bocw_pm63") == 2)
								ent.zombie_weapon_upgrade = "t9_amp63";
							else
								ent.zombie_weapon_upgrade = "t5_pm63";
						}
						
						vesper = 1;
						break;
					}
				case "smg_standard": //Kuda
					{
						switch(kuda)
						{
						case 0:
						case 1:
							{
								if(GetDvarInt("mutator_bocw_mp5k") == 2)
									ent.zombie_weapon_upgrade = "t9_mp5k";
								else
									ent.zombie_weapon_upgrade = "t5_mp5k";
								
								kuda++;
								break;
							}
						case 2:
							{
								ent.zombie_weapon_upgrade = "t5_mpl";
								break;
							}
						}
						break;
					}
				case "ar_longburst": //M8A7
					{
						if (m8a7 == 0) //
						{
							if(GetDvarInt("mutator_bocw_ak74u") == 2)
								ent.zombie_weapon_upgrade = "t9_ak74u";
							else
								ent.zombie_weapon_upgrade = "t5_ak74u";
							
							ent.origin += (2, 0, 2);
							spawn_loc = struct::get(ent.target, "targetname");
							spawn_loc.origin += (2, 0, 2);
						}
						else
						{
							if(GetDvarInt("mutator_bocw_m16") == 2)
								ent.zombie_weapon_upgrade = "t9_m16";
							else
								ent.zombie_weapon_upgrade = "t5_m16a1";
							
							ent.origin += (-5, 0, -5);
							spawn_loc = struct::get(ent.target, "targetname");
							spawn_loc.origin += (-5, 0, -5);
						}
						
						m8a7 = 1;
						break;
					}
				}
				break;
			}*/
		/*case "zm_castle": //Der Eisendrache
			{
				switch(VAL)
				{
					case "pistol_burst": //RK5
						{
							ent.zombie_weapon_upgrade = "t4_kar98k";
							
							ent.origin += (-3, 0, 0);
							spawn_loc = struct::get(ent.target, "targetname");
							spawn_loc.origin += (-3, 0, 0);
							
							break;
						}
					case "ar_marksman": //Sheiva
						ent.zombie_weapon_upgrade = "t4_g43";
						break;
					case "shotgun_pump": //KRM-262
						ent.zombie_weapon_upgrade = "t4_m1897";
						break;
					case "pistol_fullauto": //L-CAR 9
						{
							ent.zombie_weapon_upgrade = "t4_carbine";
							
							if(lcar9 == 1) //left from spawn
							{
								ent.origin += (5*cos(spawn_loc.angles[1]), 5*sin(spawn_loc.angles[1]), 0);
								spawn_loc = struct::get(ent.target, "targetname");
								spawn_loc.origin += (5*cos(spawn_loc.angles[1]), 5*sin(spawn_loc.angles[1]), 0);
							}
							
							lcar9++;
							break;
						}
					case "smg_versatile": //VMP
						{
							ent.zombie_weapon_upgrade = "t4_thompson";
							
							if(vmp == 1) //teleporter
							{
								ent.origin += (7.5*cos(spawn_loc.angles[1]), 7.5*sin(spawn_loc.angles[1]), 0);
								spawn_loc = struct::get(ent.target, "targetname");
								spawn_loc.origin += (7.5*cos(spawn_loc.angles[1]), 7.5*sin(spawn_loc.angles[1]), 0);
							}
							
							vmp++;
							break;
						}
					case "ar_standard": //KN-44
						ent.zombie_weapon_upgrade = "t5_mp40";
						break;
					case "ar_cqb": //HVK-30
						{
							ent.zombie_weapon_upgrade = "t4_mp44";
							
							ent.origin += (10, 0, 0);
							spawn_loc = struct::get(ent.target, "targetname");
							spawn_loc.origin += (10, 0, 0);
							
							break;
						}
					case "smg_standard": //Kuda
						ent.zombie_weapon_upgrade = "t4_type100";
						break;
					case "smg_fastfire": //Vesper
						ent.zombie_weapon_upgrade = "t4_db";
						break;
					case "ar_longburst": //M8A7
						ent.zombie_weapon_upgrade = "t4_fg42";
						break;
					case "lmg_light": //BRM
						ent.zombie_weapon_upgrade = "t4r_ppsh";
						break;
				}
				break;
			}*/
		/*case "zm_island": //Zetsubou no Shima
			{ //Conn6orsuper117
				switch(VAL)
				{
				case "ar_marksman": //Sheiva
					ent.zombie_weapon_upgrade = "t4_type99r";
					break;
				case "pistol_burst": //RK5
					{
						ent.zombie_weapon_upgrade = "t4_carbine";
						
						ent.origin += (-5, 0, 0);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (-5, 0, 0);
						
						break;
					}
				case "pistol_fullauto": //L-CAR 9
					{
						ent.zombie_weapon_upgrade = "t4_m1";
					
						ent.origin += (-5, 40, 0);
						ent.angles = (0, 90, 0);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (-5, 40, 0);
						spawn_loc.angles = (0, 90, 0);
						
						break;
					}
				case "shotgun_precision": //Argus
					{
						if(argus == 0) //Ruins to the right
							ent.zombie_weapon_upgrade = "t4_m1897";
						else //Bunker left room underwater
							ent.zombie_weapon_upgrade = "t4_db";
						
						argus++;
						break;
					}
				case "ar_accurate": //ICR-1
					{
						if(icr == 0)
							ent.zombie_weapon_upgrade = "t4_bar";
						else
							ent.zombie_weapon_upgrade = "t5_mp40";
						
						icr++;
						break;
					}
				case "smg_fastfire": //Vesper
					{
						if(vesper == 0) //Inside Bunker
							ent.zombie_weapon_upgrade = "t4_thompson"; //developer's choice
						else //Outside Lab B
						{
							ent.zombie_weapon_upgrade = "t4_thompson";
							
							ent.origin += (5*cos(spawn_loc.angles[1]), 5*sin(spawn_loc.angles[1]), 5);
							spawn_loc = struct::get(ent.target, "targetname");
							spawn_loc.origin += (5*cos(spawn_loc.angles[1]), 5*sin(spawn_loc.angles[1]), 5);
						}
						
						vesper++;
						break;
					}
				case "shotgun_pump": //KRM-262
					{
						ent.zombie_weapon_upgrade = "t4_g43";
						
						ent.origin += (0, -7.5, 0);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (0, -7.5, 0);
						
						break;
					}
				case "smg_burst": //Pharo
					ent.zombie_weapon_upgrade = "t4_db_saw";
					break;
				case "ar_cqb": //HVK-30
					{
						if(hvk30 == 0) //Lab A
							ent.zombie_weapon_upgrade = "t4_type100";
						else //Bunker
							ent.zombie_weapon_upgrade = "t4_mp44";
						
						hvk30++;
						break;
					}
				case "smg_versatile": //VMP
					if(vmp == 0)
						ent.zombie_weapon_upgrade = "t4_fg42";
					else
					{
						ent.zombie_weapon_upgrade = "t4_m1897"; //developer's choice
						
						ent.origin += (0, 0, 5);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (0, 0, 5);
					}
					
					vmp++;
					break;
				case "ar_standard": //KN-44
					ent.zombie_weapon_upgrade = "t4_type100";
					break;
				case "smg_standard": //Kuda
					{
						if(kuda == 0) //Outside Laboratory A
							ent.zombie_weapon_upgrade = "t5_mp40";
						else //Bunker
							ent.zombie_weapon_upgrade = "t4_m1";
						
						kuda++;
						break;
					}
				case "ar_longburst": //M8A7
					{
						if(m8a7 == 0)
							ent.zombie_weapon_upgrade = "t4_type100";
						else
							ent.zombie_weapon_upgrade = "t4_bar";
						
						m8a7++;
						break;
					}
				}
				break;
			}*/
		}
		
		if(ent.zombie_weapon_upgrade == "sticky_grenade_custom" && GetGametypeSetting(mutator_grenade_wallbuy) == 2)
			ent.zombie_weapon_upgrade = "frag_grenade";
		else if(ent.zombie_weapon_upgrade == "frag_grenade" && GetGametypeSetting(mutator_grenade_wallbuy) == 3)
		{
			if(!isdefined(level.zombie_weapons[GetWeapon("sticky_grenade_custom")]))
			{
				zm_utility::include_weapon( "sticky_grenade_custom", false );
				zm_weapons::add_zombie_weapon( "sticky_grenade_custom", "", "", 250, "grenade", "", 250, "", false, "" );
			}
			
			ent.zombie_weapon_upgrade = "sticky_grenade_custom";
		}
		
		if(isdefined(ent.target) && isdefined(VAL))
		{
			struct::get(ent.target, "targetname").model = GetWeapon(ent.zombie_weapon_upgrade).worldmodel;
		}
	}

	/*switch(GetDvarString("mapname"))
	{
	case "zm_zod": //Shadows of Evil
		{
			foreach(ent in GetEntArray("train_buyable_weapon", "script_noteworthy"))
				ent.zombie_weapon_upgrade = "s2_sten";
			break;
		}
	}*/

	if(GetGametypeSetting(mutator_claymore) == BOOLMUTATOR_ONOFF_ON)
	{
		count = 0;
		foreach(ent in struct::get_array("claymore_purchase", "targetname"))
		{
			VAL = ent.zombie_weapon_upgrade;
			if(!isdefined(VAL))
			{
				continue;
			}
			if(GetDvarString("mapname") != "zm_asylum" || GetDvarString("mapname") == "zm_asylum" && count != 0) //Don't delete German side
				ent struct::delete();
			if(GetDvarString("mapname") != "zm_tomb" || GetDvarString("mapname") == "zm_tomb" && count == 1) //Delete trip mine under church
				ent struct::delete();
			
			count++;
		}
	}
}

/*
	Name: function_ad56b21c
	Namespace: namespace_934d772b
	Checksum: 0x33E12E7A
	Offset: 0xC68
	Size: 0x32F
	Parameters: 0
	Flags: None
*/
function swap_chalk()
{
	fiveseven = 0;
	
	ak74u = 0;
	m16 = 0;
	m14 = 0;
	olympia = 0;
	mp40 = 0;
	stg44 = 0;
	uzi = 0;
	foreach(ent in struct::get_array("weapon_upgrade", "targetname"))
	{
		VAL = ent.zombie_weapon_upgrade;
		if(!isdefined(VAL))
		{
			break;
		}
		switch(VAL)
		{
			case "t6_m14":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				//case "":																				 // ↔   ↔  ↕
				//	ent.var_47896610 = util::spawn_model("wallbuy_m14_bo2", spawn_loc.origin + VectorScale((0, 13, -3), 1), spawn_loc.angles);
				//	break;
				case "zm_diner":
					ent.var_47896610 = util::spawn_model("wallbuy_m14_bo2", spawn_loc.origin + VectorScale((1*cos(spawn_loc.angles[1]), 1*sin(spawn_loc.angles[1]), 0), 1), spawn_loc.angles);
					break;
				case "zm_cellblock":
					ent.var_47896610 = util::spawn_model("wallbuy_m14_bo2", spawn_loc.origin + VectorScale((-1, -1, 0), 1), spawn_loc.angles);
					break;
				case "zm_town": //Town Reimagined already has this
					break;
				case "zm_prison": //copforthat's Mob of the Dead
					ent.var_47896610 = util::spawn_model("wallbuy_m14_bo2", spawn_loc.origin + (-1, 0, 0), spawn_loc.angles);
					break;
				case "zm_cosmodrome":
					ent.var_47896610 = util::spawn_model("wallbuy_m14_bo2", spawn_loc.origin + (0, -1, 0), spawn_loc.angles);
					break;
				case "zm_asylum":
					ent.var_47896610 = util::spawn_model("wallbuy_m14_bo2", spawn_loc.origin + (1, 0, 0), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_m14_bo2", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t6_olympia":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_theater":
					ent.var_47896610 = util::spawn_model("wallbuy_olympia_bo2", spawn_loc.origin + VectorScale((0, 2, -3), 1), spawn_loc.angles);
					break;
				case "zm_cellblock":
					ent.var_47896610 = util::spawn_model("wallbuy_olympia_bo2", spawn_loc.origin + VectorScale((1, 1, -3), 1), spawn_loc.angles);
					break;
				case "zm_town": //Town Reimagined already has this
					break;
				case "zm_prison": //copforthat's Mob of the Dead
					ent.var_47896610 = util::spawn_model("wallbuy_olympia_bo2", spawn_loc.origin + (1, 0, -3), spawn_loc.angles);
					break;
				case "zm_asylum":
					ent.var_47896610 = util::spawn_model("wallbuy_olympia_bo2", spawn_loc.origin + (0, -1, -3), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_olympia_bo2", spawn_loc.origin + VectorScale((-1*cos(spawn_loc.angles[1]), -1*sin(spawn_loc.angles[1]), -3), 1), spawn_loc.angles);
					break;
				}
				break;
			}
			case "t6_b23r":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_theater":
				case "zm_cosmodrome":
					ent.var_47896610 = util::spawn_model("wallbuy_b23r", spawn_loc.origin + VectorScale((2, 0, 0), 1), spawn_loc.angles);
					break;
				case "zm_diner":
				case "zm_tomb":
					ent.var_47896610 = util::spawn_model("wallbuy_b23r", spawn_loc.origin + VectorScale((-2*cos(spawn_loc.angles[1]), -2*sin(spawn_loc.angles[1]), 0), 1), spawn_loc.angles);
					break;
				case "zm_cellblock":
					ent.var_47896610 = util::spawn_model("wallbuy_b23r", spawn_loc.origin + VectorScale((1, 2, 0), 1), spawn_loc.angles);
					break;
				case "zm_nuked":
					ent.var_47896610 = util::spawn_model("wallbuy_b23r", spawn_loc.origin + (-2, 1, 1), spawn_loc.angles);
					break;
				case "zm_prison": //copforthat's Mob of the Dead
					ent.var_47896610 = util::spawn_model("wallbuy_b23r", spawn_loc.origin + (1, 2, 0), spawn_loc.angles);
					break;
				case "zm_alcatraz_island": //Mob of the Dead Remastered
					ent.var_47896610 = util::spawn_model("wallbuy_b23r", spawn_loc.origin + (0, 2, 0), spawn_loc.angles);
					break;
				case "zm_moon":
					ent.var_47896610 = util::spawn_model("wallbuy_b23r", spawn_loc.origin + (0, -2, 0), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_b23r", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t6_ak74u":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_theater":
					ent.var_47896610 = util::spawn_model("wallbuy_ak74u_bo2", spawn_loc.origin + VectorScale((-1, -1, 0), 1), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_ak74u_bo2", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t6_pdw57":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_theater":
					ent.var_47896610 = util::spawn_model("wallbuy_pdw57", spawn_loc.origin + VectorScale((0, 7, 2), 1), spawn_loc.angles);
					break;
				case "zm_cosmodrome":
					ent.var_47896610 = util::spawn_model("wallbuy_pdw57", spawn_loc.origin + (-7, 1, 2), spawn_loc.angles);
					break;
				case "zm_moon":
					ent.var_47896610 = util::spawn_model("wallbuy_pdw57", spawn_loc.origin + (7, 0, 2), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_pdw57", spawn_loc.origin + VectorScale((7*cos(spawn_loc.angles[1]), 7*sin(spawn_loc.angles[1]), 2), 1), spawn_loc.angles);
					break;
				}
				break;
			}
			case "t6_rem870mcs":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_theater":
					ent.var_47896610 = util::spawn_model("wallbuy_rem870mcs", spawn_loc.origin + VectorScale((0, 1, 0), 1), spawn_loc.angles);
					break;
				case "zm_prison": //copforthat's Mob of the Dead
					ent.var_47896610 = util::spawn_model("wallbuy_rem870mcs", spawn_loc.origin + (1, 0, 0), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_rem870mcs", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t6_mp40":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_asylum":
					ent.var_47896610 = util::spawn_model("wallbuy_mp40_bo2", spawn_loc.origin + (0, 1, 0), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_mp40_bo2", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t6_mp5":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_theater":
				case "zm_moon":
					ent.var_47896610 = util::spawn_model("wallbuy_mp5", spawn_loc.origin + VectorScale((0, 8.5, 1), 1), spawn_loc.angles);
					break;
				case "zm_cellblock":
					ent.var_47896610 = util::spawn_model("wallbuy_mp5", spawn_loc.origin + VectorScale((0, 8.5, 2), 1), spawn_loc.angles);
					break;
				case "zm_diner":
				case "zm_farm_hd":
					ent.var_47896610 = util::spawn_model("wallbuy_mp5", spawn_loc.origin + VectorScale((-8.5, 0, 2), 1), spawn_loc.angles);
					break;
				case "zm_town_hd":
					ent.var_47896610 = util::spawn_model("wallbuy_mp5", spawn_loc.origin + (-1, -8.5, 2), spawn_loc.angles);
					break;
				case "zm_town": //Town Reimagined already has this
				case "zm_alcatraz_island": //Mob of the Dead Remastered already has this
					break;
				case "zm_nuked":
					ent.var_47896610 = util::spawn_model("wallbuy_mp5", spawn_loc.origin + (8, -4, 2), spawn_loc.angles);
					break;
				case "zm_sumpf":
					ent.var_47896610 = util::spawn_model("wallbuy_mp5", spawn_loc.origin + (-8.5*cos(spawn_loc.angles[1]), -8.5*sin(spawn_loc.angles[1]), 1), spawn_loc.angles);
					break;
				case "zm_prison": //copforthat's Mob of the Dead
					ent.var_47896610 = util::spawn_model("wallbuy_mp5", spawn_loc.origin + (1, 8.5, 0), spawn_loc.angles);
					break;
				case "zm_cosmodrome":
					ent.var_47896610 = util::spawn_model("wallbuy_mp5", spawn_loc.origin + (0, -8.5, 1), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_mp5", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t6_m16a1":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_theater":
				case "zm_nuked":
					ent.var_47896610 = util::spawn_model("wallbuy_m16a1_bo2", spawn_loc.origin + VectorScale((-6, -1, 0), 1), spawn_loc.angles);
					break;
				case "zm_diner":
					ent.var_47896610 = util::spawn_model("wallbuy_m16a1_bo2", spawn_loc.origin + VectorScale((-6*cos(spawn_loc.angles[1]), -6*sin(spawn_loc.angles[1]), 0), 1), spawn_loc.angles);
					break;
				case "zm_cosmodrome":
					ent.var_47896610 = util::spawn_model("wallbuy_m16a1_bo2", spawn_loc.origin + (1, 6, 0), spawn_loc.angles);
					break;
				case "zm_moon":
					ent.var_47896610 = util::spawn_model("wallbuy_m16a1_bo2", spawn_loc.origin + (0, -6, 0), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_m16a1_bo2", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t6_stg44":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_tomb":
					ent.var_47896610 = util::spawn_model("wallbuy_stg44_bo2", spawn_loc.origin + VectorScale((-8.5*cos(spawn_loc.angles[1]), -8.5*sin(spawn_loc.angles[1]), -1), 1), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_stg44_bo2", spawn_loc.origin + VectorScale((-8.5*cos(spawn_loc.angles[1]), -8.5*sin(spawn_loc.angles[1]), -1), 1), spawn_loc.angles);
					break;
				}
				break;
			}
			case "t6_ballista":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_tomb":
					ent.var_47896610 = util::spawn_model("wallbuy_ballista", spawn_loc.origin + VectorScale((-3, 0, 1), 1), spawn_loc.angles);
					break;
				case "zm_asylum":
					ent.var_47896610 = util::spawn_model("wallbuy_ballista", spawn_loc.origin + (-3*cos(spawn_loc.angles[1])+1, -3*sin(spawn_loc.angles[1]), 1), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_ballista", spawn_loc.origin + VectorScale((-3*cos(spawn_loc.angles[1]), -3*sin(spawn_loc.angles[1]), 1), 1), spawn_loc.angles);
					break;
				}
				break;
			}
			case "t6_fiveseven":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_tomb":
					{
						if(fiveseven == 0) //Ice Tunnel
							ent.var_47896610 = util::spawn_model("wallbuy_fiveseven", spawn_loc.origin + VectorScale((-4*cos(spawn_loc.angles[1]), -4*sin(spawn_loc.angles[1]), 0.25), 1), spawn_loc.angles);
						else //Workshop
							ent.var_47896610 = util::spawn_model("wallbuy_fiveseven", spawn_loc.origin + VectorScale((-4*cos(spawn_loc.angles[1]), -4*sin(spawn_loc.angles[1]), -0.25), 1), spawn_loc.angles);
							
						fiveseven++;
						break;
					}
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_fiveseven", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t6_m1927":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_prototype":
					ent.var_47896610 = util::spawn_model("wallbuy_m1927_bo2", spawn_loc.origin + VectorScale((8, 0, -1), 1), spawn_loc.angles);
					break;
				case "zm_sumpf":
					ent.var_47896610 = util::spawn_model("wallbuy_m1927_bo2", spawn_loc.origin + VectorScale((-1, -8, -1), 1), spawn_loc.angles);
					break;
				case "zm_prison": //copforthat's Mob of the Dead
					ent.var_47896610 = util::spawn_model("wallbuy_m1927_bo2", spawn_loc.origin + (1, 8, -1), spawn_loc.angles);
					break;
				case "zm_alcatraz_island": //Mob of the Dead Remastered already has this
					break;
				case "zm_asylum":
					ent.var_47896610 = util::spawn_model("wallbuy_m1927_bo2", spawn_loc.origin + (8, -1, -1), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_m1927_bo2", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t6_an94":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_prototype":
				case "zm_asylum":
					ent.var_47896610 = util::spawn_model("wallbuy_an94", spawn_loc.origin + VectorScale((0, 5, -1), 1), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_an94", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t6_smr":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_prototype":
					ent.var_47896610 = util::spawn_model("wallbuy_smr", spawn_loc.origin + VectorScale((0, 12, 1), 1), spawn_loc.angles);
					break;
				case "zm_sumpf":
					ent.var_47896610 = util::spawn_model("wallbuy_smr", spawn_loc.origin + (12, 0, 1), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_smr", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t6_fal":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_factory":
					ent.var_47896610 = util::spawn_model("wallbuy_fal_bo2", spawn_loc.origin + VectorScale((1, 5, 0), 1), spawn_loc.angles);
					break;
				case "zm_sumpf":
				case "zm_asylum":
					ent.var_47896610 = util::spawn_model("wallbuy_fal_bo2", spawn_loc.origin + VectorScale((0, 4, 0), 1), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_fal_bo2", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t6_uzi":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_diner":
				case "zm_prison": //copforthat's Mob of the Dead
					ent.var_47896610 = util::spawn_model("wallbuy_uzi_bo2", spawn_loc.origin + (1, 8, 0), spawn_loc.angles);
					break;
				case "zm_cellblock":
					ent.var_47896610 = util::spawn_model("wallbuy_uzi_bo2", spawn_loc.origin + (8*cos(spawn_loc.angles[1]), 8*sin(spawn_loc.angles[1]), 0), spawn_loc.angles);
					break;
				case "zm_prison": //copforthat's Mob of the Dead
					{
						if(uzi < 2)
							ent.var_47896610 = util::spawn_model("wallbuy_uzi_bo2", spawn_loc.origin + (1, 8, 0), spawn_loc.angles);
						else //Citadel Tunnels
							ent.var_47896610 = util::spawn_model("wallbuy_uzi_bo2", spawn_loc.origin + (-8*cos(spawn_loc.angles[1]), -8*sin(spawn_loc.angles[1]), 0), spawn_loc.angles);
						
						uzi++;
						break;
					}
				case "zm_alcatraz_island": //Mob of the Dead Remastered already has this
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_uzi_bo2", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t6_ksg":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_diner":
					ent.var_47896610 = util::spawn_model("wallbuy_ksg", spawn_loc.origin + (0, -11, 2), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_ksg", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t6_executioner":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_prototype":
					ent.var_47896610 = util::spawn_model("wallbuy_executioner", spawn_loc.origin + (0, -9, -2), spawn_loc.angles);
					break;
				case "zm_asylum":
					ent.var_47896610 = util::spawn_model("wallbuy_executioner", spawn_loc.origin + (9, 0, -2), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_executioner", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
		}
	}
}

function swap_claymores()
{
	count = 0;
	foreach(ent in struct::get_array("claymore_purchase", "targetname"))
	{
		VAL = ent.zombie_weapon_upgrade;
		if(!isdefined(VAL))
		{
			continue;
		}
		spawn_loc = struct::get(ent.target, "targetname");
		switch( GetDvarString("mapname") )
		{
		case "zm_theater": //Kino der Toten
		case "zm_cosmodrome": //Ascension
		case "zm_temple": //Shangri-La, need to replace with Spikemore
		case "zm_moon":
			{
				claymore = Spawn("trigger_radius_use", spawn_loc.origin, 0, 84, 72);
				claymore.targetname = "claymore_trigger";
				claymore zm_unitrigger::create_unitrigger( "Hold ^3&&1^7 to buy Claymores [Cost: 1000]" , 20, &visibility_and_update_prompt);
				break;
			}
		case "zm_sumpf": //Shi no Numa
		case "zm_factory": //The Giant
			{
				/*if(GetDvarInt("mutator_waw_wall_weapons") == 2)
				{*/
					claymore = Spawn("trigger_radius_use", spawn_loc.origin, 0, 84, 72);
					claymore.targetname = "claymore_trigger";
					claymore zm_unitrigger::create_unitrigger( "Hold ^3&&1^7 to buy Claymores [Cost: 1000]" , 20, &visibility_and_update_prompt);
				//}
				break;
			}
		case "zm_asylum": //Verrückt
		case "zm_tomb":
			{
				/*if(GetDvarInt("mutator_waw_wall_weapons") == 2)
				{*/
					if(count == 1) //American side
					{
						claymore = Spawn("trigger_radius_use", spawn_loc.origin, 0, 84, 72);
						claymore.targetname = "claymore_trigger";
						claymore zm_unitrigger::create_unitrigger( "Hold ^3&&1^7 to buy Claymores [Cost: 1000]" , 20, &visibility_and_update_prompt);
					}
					else
						claymore = ent;
				//}
				break;
			}
		}
		if(isdefined(claymore))
		{
			if(GetDvarString("mapname") == "zm_asylum")
			{
				if(count == 0) //German side
					claymore.var_47896610 = util::spawn_model("wallbuy_claymore", spawn_loc.origin + VectorScale((0, 1, 0), 1), spawn_loc.angles);
				else
					claymore.var_47896610 = util::spawn_model("wallbuy_claymore", spawn_loc.origin + VectorScale((0, -0.5, 0), 1), spawn_loc.angles);
				
				count = 1;
			}
			else if(GetDvarString("mapname") != "zm_prison")
			{
				if(count == 1)
					claymore.var_47896610 = util::spawn_model("wallbuy_claymore", spawn_loc.origin + VectorScale((0, -0.5, 0), 1), spawn_loc.angles);
				if(GetDvarString("mapname") == "zm_tomb")
					count++;
			}
		}
	}
	thread zm_claymore::init();
}

function visibility_and_update_prompt( player )
{
    if(isdefined(self.hint_string))
    {
        self SetHintString( self.hint_string );
    }
    return true;
}