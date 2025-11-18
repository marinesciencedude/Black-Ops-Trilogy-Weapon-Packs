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
	
	if(GetDvarInt("mutator_bocw_1911") == 2)
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
	
	if(GetGametypeSetting(mutator_camo_disable) == MUTATOR_OFFON_ON)
		level.pack_a_punch_camo_index = 127; //blank camo, this is actually for Dempsey's Matryoshka Doll 
	
	//level.pack_a_punch_camo_index_number_variants = 1;
	
	if(GetGametypeSetting(mutator_startingweapon) != 2)
	{
		if(GetDvarInt("mutator_bocw_1911") == 2)
		{
			starting_weapon = GetWeapon("t9_1911");
			starting_weapon_pap = GetWeapon("t9_1911_rdw_up");
		}
		else
		{
			starting_weapon = GetWeapon("t5_m1911");
			starting_weapon_pap = GetWeapon("t5_m1911_rdw_up");
		}
		
		level.start_weapon = starting_weapon;
		level.default_laststandpistol = starting_weapon;
		level.default_solo_laststandpistol = starting_weapon_pap;
		thread zm::last_stand_pistol_rank_init();
		starter_weapon_extra();
	}
	if(GetGametypeSetting(mutator_revive_anim) == 1)
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
	
	if(GetDvarInt("mutator_bocw_1911") == 2)
	{
		starting_weapon = GetWeapon("t9_1911");
		starting_weapon_pap = GetWeapon("t9_1911_rdw_up");
	}
	else
	{
		starting_weapon = GetWeapon("t5_m1911");
		starting_weapon_pap = GetWeapon("t5_m1911_rdw_up");
	}
	
	level.start_weapon = starting_weapon;
	level.default_laststandpistol = starting_weapon;
	level.default_solo_laststandpistol = starting_weapon_pap;
	foreach(player in GetPlayers())
	{
		if(player GetCurrentWeapon() != starting_weapon)
		{
			player TakeWeapon(player GetCurrentWeapon());
			player zm_weapons::weapon_give(starting_weapon, 0, 0, 1, 1);
		}
	}
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
	level.zombie_powerup_weapon["minigun"] = GetWeapon("t5_minigun");
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
	if(GetDvarInt("mutator_bocw_mp5k") == 2)
	{
		zm_utility::include_weapon( "t9_mp5k", false);
		zm_utility::include_weapon( "t9_mp5k_up", false);
		zm_weapons::add_zombie_weapon( "t9_mp5k", "t9_mp5k_up", "", 1000, "smg", "", undefined, undefined, false, "" );
	}
	
	if(GetDvarInt("mutator_bocw_ak74u") == 2)
	{
		zm_utility::include_weapon( "t9_ak74u", false);
		zm_utility::include_weapon( "t9_ak74u_up", false);
		zm_weapons::add_zombie_weapon( "t9_ak74u", "t9_ak74u_up", "", 1200, "smg", "", undefined, undefined, false, "" );
	}
	
	if(GetDvarInt("mutator_bocw_pm63") == 2)
	{
		zm_utility::include_weapon( "t9_amp63", false);
		zm_utility::include_weapon( "t9_amp63_up", false);
		zm_weapons::add_zombie_weapon( "t9_amp63", "t9_amp63_up", "", 1000, "smg", "", undefined, undefined, false, "" );
	}
	
	if(GetDvarInt("mutator_bocw_hauer77") == 2)
	{
		zm_utility::include_weapon( "t9_hauer77", false);
		zm_utility::include_weapon( "t9_hauer77_up", false);
		zm_weapons::add_zombie_weapon( "t9_hauer77", "t9_hauer77_up", "", 1500, "shotgun", "", undefined, undefined, false, "" );
	}
	
	if(GetDvarInt("mutator_bocw_m14") == 2)
	{
		zm_utility::include_weapon( "t9_m14classic", false);
		zm_utility::include_weapon( "t9_m14classic_up", false);
		zm_weapons::add_zombie_weapon( "t9_m14classic", "t9_m14classic_up", "", 500, "rifle", "", undefined, undefined, false, "" );
	}
	
	if(GetDvarInt("mutator_bocw_m16") == 2)
	{
		zm_utility::include_weapon( "t9_m16", false);
		zm_utility::include_weapon( "t9_m16_up", false);
		zm_weapons::add_zombie_weapon( "t9_m16", "t9_m16_up", "", 1200, "rifle", "", undefined, undefined, false, "" );
	}
	
	/*if(GetDvarInt("mutator_bocw_aug") == 2)
	{
		level.zombie_weapons[GetWeapon("t5_aug")].is_in_box = false;
		zm_utility::include_weapon( "t5_aug", false);
		zm_utility::include_weapon( "t9_aug", true);
		zm_utility::include_weapon( "t9_aug_up", false);
		zm_weapons::add_zombie_weapon( "t9_aug", "t9_aug_up", "", 1200, "rifle", "", undefined, undefined, false, "" );
	}*/
	
	switch(GetGametypeSetting(mutator_scopeads))
	{
		case 1:
		{
			if(GetDvarInt("mutator_bocw_l96a1") == 2)
			{
				zm_utility::include_weapon( "t9_lw3_tundra_overlay", true );
				zm_utility::include_weapon( "t9_lw3_tundra_up_overlay", false );
				zm_weapons::add_zombie_weapon( "t9_lw3_tundra_overlay", "t9_lw3_tundra_up_overlay", "", 1900, "sniper", "", undefined, undefined, false, "" );
			}
			else
			{
				zm_utility::include_weapon( "t5_l96a1_overlay", true );
				zm_utility::include_weapon( "t5_l96a1_up_overlay", false );
				zm_weapons::add_zombie_weapon( "t5_l96a1_overlay", "t5_l96a1_up_overlay", "", 1900, "sniper", "", undefined, undefined, false, "" );
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
				zm_weapons::add_zombie_weapon( "t9_lw3_tundra", "t9_lw3_tundra_up", "", 1900, "sniper", "", undefined, undefined, false, "" );
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
				zm_weapons::add_zombie_weapon( "t9_lw3_tundra_switch", "t9_lw3_tundra_up_switch", "", 1900, "sniper", "", undefined, undefined, false, "" );
			}
			else
			{
				zm_utility::include_weapon( "t5_l96a1_switch", true );
				zm_utility::include_weapon( "t5_l96a1_up_switch", false );
				zm_weapons::add_zombie_weapon( "t5_l96a1_switch", "t5_l96a1_up_switch", "", 1900, "sniper", "", undefined, undefined, false, "" );
			}
			level.zombie_weapons[GetWeapon("t5_l96a1")].is_in_box = false;
			zm_utility::include_weapon( "t5_l96a1", false);
			
			break;
		}
	}
	
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
		
		if(VAL == "smg_mp40_1940" || (GetGametypeSetting(mutator_waw_wall_weapons) != 3 && VAL == "s2_mp40") )
			ent.zombie_weapon_upgrade = "t5_mp40";
		
		switch( GetDvarString("mapname") )
		{
		case "zm_prototype": //Nacht der Untoten
			{
				if(GetGametypeSetting(mutator_waw_wall_weapons) == 1 || !GetGametypeSetting(mutator_waw_wall_weapons))
				{
					switch(VAL)
					{
					case "pistol_burst": //RK5
						ent.zombie_weapon_upgrade = "t4_carbine";
						break;
					case "ar_marksman": //Sheiva
						ent.zombie_weapon_upgrade = "t4_kar98k";
						break;
					case "smg_standard": //Kuda
						ent.zombie_weapon_upgrade = "t4_thompson";
						break;
					case "shotgun_pump": //KRM-262
						ent.zombie_weapon_upgrade = "t4_db";
						break;
					case "ar_standard": //KN-44
						ent.zombie_weapon_upgrade = "t4_bar";
						break;
					case "shotgun_precision": //Argus
						ent.zombie_weapon_upgrade = "t4_m1897";
						break;
					case "smg_burst": //Pharo
						ent.zombie_weapon_upgrade = "t4_db_saw";
						break;
					case "sniper_fastbolt": //Locus
						{
							/*switch(GetGametypeSetting(mutator_scopeads))
							{
							case 1:
								ent.zombie_weapon_upgrade = "t4_kar98k_scope_overlay";
								break;
							case 3:
								ent.zombie_weapon_upgrade = "t4_kar98k_scope_switch";
								break;
							default:*/
								ent.zombie_weapon_upgrade = "t4_kar98k_scope"; //actually this is the overlay version
								/*break;
							}*/
							
							break;
						}
					}
				}
				else if(GetGametypeSetting(mutator_waw_wall_weapons) == 2)
				{
					switch(VAL)
					{
					case "pistol_burst": //RK5
						{
							if(GetDvarInt("mutator_bocw_m14") == 2)
								ent.zombie_weapon_upgrade = "t9_m14classic";
							else
								ent.zombie_weapon_upgrade = "t5_m14";
							
							break;
						}
					case "ar_marksman": //Sheiva
						ent.zombie_weapon_upgrade = "t5_olympia";
						break;
					case "smg_standard": //Kuda
						{
							if(GetDvarInt("mutator_bocw_ak74u") == 2)
								ent.zombie_weapon_upgrade = "t9_ak74u";
							else
								ent.zombie_weapon_upgrade = "t5_ak74u";
							
							break;
						}
					case "shotgun_pump": //KRM-262
						ent.zombie_weapon_upgrade = "t5_mpl";
						break;
					case "ar_standard": //KN-44
						{
							if(GetDvarInt("mutator_bocw_m16") == 2)
								ent.zombie_weapon_upgrade = "t9_m16";
							else	
								ent.zombie_weapon_upgrade = "t5_m16a1";
							
							break;
						}
					case "shotgun_precision": //Argus
						{
							if(GetDvarInt("mutator_bocw_pm63") == 2)
								ent.zombie_weapon_upgrade = "t9_amp63";
							else
								ent.zombie_weapon_upgrade = "t5_pm63";
							break;
						}
					case "smg_burst": //Pharo
						{
							if(GetDvarInt("mutator_bocw_hauer77") == 2)
								ent.zombie_weapon_upgrade = "t9_hauer77";
							else
								ent.zombie_weapon_upgrade = "t5_stakeout";
							
							break;
						}
					case "sniper_fastbolt": //Locus
						{
							if(GetDvarInt("mutator_bocw_l96a1") == 2)
							{
								switch(GetGametypeSetting(mutator_scopeads))
								{
								case 1:
									ent.zombie_weapon_upgrade = "t9_lw3_tundra_overlay";
									break;
								case 2:
									ent.zombie_weapon_upgrade = "t9_lw3_tundra";
									break;
								case 3:
									ent.zombie_weapon_upgrade = "t9_lw3_tundra_switch";
									break;
								}
							}
							else
							{
								switch(GetGametypeSetting(mutator_scopeads))
								{
								case 1:
									ent.zombie_weapon_upgrade = "t5_l96a1_overlay";
									break;
								case 3:
									ent.zombie_weapon_upgrade = "t5_l96a1_switch";
									break;
								default:
									ent.zombie_weapon_upgrade = "t5_l96a1";
									break;
								}
							}
							
							break;
						}
					}
				}
				break;
			}
		case "zm_asylum": //Verrückt
			{
				if(GetGametypeSetting(mutator_waw_wall_weapons) == 1 || !GetGametypeSetting(mutator_waw_wall_weapons))
				{
					switch(VAL)
					{
					case "ar_marksman": //Sheiva
						{
							if(sheiva == 0 && GetGametypeSetting(mutator_verruckt_springfield) == 2)
								ent.zombie_weapon_upgrade = "t4_spring";
							else
								ent.zombie_weapon_upgrade = "t4_kar98k";
							
							sheiva++;
							break;
						}
					case "pistol_burst": //RK5
						{
							if(rk5 == 0)
								ent.zombie_weapon_upgrade = "t4_m1";
							else
								ent.zombie_weapon_upgrade = "t4_g43";
								
							rk5++;
							break;
						}
					case "pistol_fullauto": //L-CAR 9
						{
							ent.zombie_weapon_upgrade = "t4_thompson";
							
							ent.origin += (-5, 0, 0);
							spawn_loc = struct::get(ent.target, "targetname");
							spawn_loc.origin += (-5, 0, 0);
							break;
						}
					case "smg_fastfire": //Vesper
					case "smg_standard": //Kuda
						ent.zombie_weapon_upgrade = "t4_m1897";
						break;
					case "ar_stg44":
						{
							ent.zombie_weapon_upgrade = "t4_mp44";
							
							ent.origin += (-15, 0, 0);
							spawn_loc = struct::get(ent.target, "targetname");
							spawn_loc.origin += (-15, 0, 0);
							break;
						}
					case "shotgun_pump": //KRM-262
						ent.zombie_weapon_upgrade = "t4_db";
						break;
					case "smg_sten":
					case "ar_accurate": //ICR-1
						ent.zombie_weapon_upgrade = "t4_bar_bipod";
						break;
					case "ar_cqb": //HVK-30
						ent.zombie_weapon_upgrade = "t4_db_saw";
						break;
					}
				}
				else if(GetGametypeSetting(mutator_waw_wall_weapons) == 2)
				{
					switch(VAL)
					{
					case "ar_marksman": //Sheiva
						ent.zombie_weapon_upgrade = "t5_olympia";
						break;
					case "pistol_burst": //RK5
						{
							if(GetDvarInt("mutator_bocw_m14") == 2)
								ent.zombie_weapon_upgrade = "t9_m14classic";
							else
								ent.zombie_weapon_upgrade = "t5_m14";
							break;
						}
					case "pistol_fullauto": //L-CAR 9
						{
							if(GetDvarInt("mutator_bocw_ak74u") == 2)
								ent.zombie_weapon_upgrade = "t9_ak74u";
							else
								ent.zombie_weapon_upgrade = "t5_ak74u";
							
							break;
						}
					case "smg_fastfire": //Vesper
					case "smg_standard": //Kuda
						{
							if(GetDvarInt("mutator_bocw_hauer77") == 2)
								ent.zombie_weapon_upgrade = "t9_hauer77";
							else
								ent.zombie_weapon_upgrade = "t5_stakeout";
						
							break;
						}
					case "ar_stg44":
						{
							if(GetDvarInt("mutator_bocw_m16") == 2)
								ent.zombie_weapon_upgrade = "t9_m16";
							else
								ent.zombie_weapon_upgrade = "t5_m16a1";
							
							break;
						}
					case "shotgun_pump": //KRM-262
						{
							if(krm262 == 0) //German Double-Barrelled Shotgun
							{
								if(GetDvarInt("mutator_bocw_pm63") == 2)
									ent.zombie_weapon_upgrade = "t9_amp63";
								else
									ent.zombie_weapon_upgrade = "t5_pm63";
							}
							else //American Double-Barrelled Shotgun
								ent.zombie_weapon_upgrade = "t5_mpl";
							
							krm262 = 1;
							break;
						}
					case "smg_sten":
						{
							ent.zombie_weapon_upgrade = "s2_sten";
							ent.origin += (0, 2, 1.5);
							spawn_loc = struct::get(ent.target, "targetname");
							spawn_loc.origin += (0, 2, 1.5);
							break;
						}
					case "ar_accurate": //ICR-1
						ent.zombie_weapon_upgrade = "s2_sten";
						break;
					case "ar_cqb": //HVK-30
						{
							if(GetDvarInt("mutator_bocw_mp5k") == 2)
								ent.zombie_weapon_upgrade = "t9_mp5k";
							else
								ent.zombie_weapon_upgrade = "t5_mp5k";
							
							break;
						}
					}
				}
				break;
			}
		case "zm_sumpf": //Shi no Numa
			{
				if(GetGametypeSetting(mutator_waw_wall_weapons) == 1 || !GetGametypeSetting(mutator_waw_wall_weapons))
				{
					switch(VAL)
					{
					case "pistol_burst": //RK5
						ent.zombie_weapon_upgrade = "t4_g43";
						break;
					case "ar_marksman": //Sheiva
						{
							ent.zombie_weapon_upgrade = "t4_type99r";
							
							ent.origin += (0, 10, 0);
							spawn_loc = struct::get(ent.target, "targetname");
							spawn_loc.origin += (0, 10, 0);
							break;
						}
					case "pistol_fullauto": //L-CAR 9
						{
							ent.zombie_weapon_upgrade = "t4_thompson";
							
							ent.origin += (0, 10, 4);
							spawn_loc = struct::get(ent.target, "targetname");
							spawn_loc.origin += (0, 10, 4);
							break;
						}
					case "smg_fastfire": //Vesper
						{
							ent.zombie_weapon_upgrade = "t4_m1897";
						
							ent.origin = (10510, 200, -610);
							ent.angles = (0, 0, 0);
							spawn_loc = struct::get(ent.target, "targetname");
							spawn_loc.origin = (10510, 200, -610);
							spawn_loc.angles = (0, 0, 0);
							break;
						}
					case "shotgun_pump": //KRM-262
						ent.zombie_weapon_upgrade = "t4_m1";
						break;
					case "smg_burst": //Pharo
						ent.zombie_weapon_upgrade = "t4_carbine";
						break;
					case "ar_stg44":
						{
							ent.zombie_weapon_upgrade = "t4_mp44";
						
							ent.origin += (10*cos(spawn_loc.angles[1]), 10*sin(spawn_loc.angles[1]), 0);
							spawn_loc = struct::get(ent.target, "targetname");
							spawn_loc.origin += (10*cos(spawn_loc.angles[1]), 10*sin(spawn_loc.angles[1]), 0);
							break;
						}
					case "ar_longburst": //M8A7
						{
						ent.zombie_weapon_upgrade = "t4_type100";
					
						ent.origin += (9*cos(spawn_loc.angles[1]), 9*sin(spawn_loc.angles[1]), 4);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (9*cos(spawn_loc.angles[1]), 9*sin(spawn_loc.angles[1]), 4);
						break;
						}
					case "ar_standard": //KN-44
						ent.zombie_weapon_upgrade = "t4_bar";
						break;
					case "shotgun_precision": //Argus
					case "smg_standard": //Kuda
					case "smg_versatile": //VMP
					case "ar_cqb": //HVK-30
					case "ar_accurate": //ICR-1
						ent struct::delete();
						break;
					}
				}
				else if(GetGametypeSetting(mutator_waw_wall_weapons) == 2)
				{
					switch(VAL)
					{
					case "pistol_burst": //RK5
						{
							if(GetDvarInt("mutator_bocw_m14") == 2)
								ent.zombie_weapon_upgrade = "t9_m14classic";
							else
								ent.zombie_weapon_upgrade = "t5_m14";
							
							break;
						}
					case "ar_marksman": //Sheiva
						ent.zombie_weapon_upgrade = "t5_olympia";
						break;
					case "pistol_fullauto": //L-CAR 9
						{
							if(GetDvarInt("mutator_bocw_ak74u") == 2)
								ent.zombie_weapon_upgrade = "t9_ak74u";
							else
								ent.zombie_weapon_upgrade = "t5_ak74u";
							
							ent.origin += (0, -9, 0);
							spawn_loc = struct::get(ent.target, "targetname");
							spawn_loc.origin += (0, -9, 0);
							break;
						}
					case "smg_fastfire": //Vesper
						{
							if(GetDvarInt("mutator_bocw_hauer77") == 2)
								ent.zombie_weapon_upgrade = "t9_hauer77";
							else
								ent.zombie_weapon_upgrade = "t5_stakeout";
						
							ent.origin = (10510, 200, -610);
							ent.angles = (0, 0, 0);
							spawn_loc = struct::get(ent.target, "targetname");
							spawn_loc.origin = (10510, 200, -610);
							spawn_loc.angles = (0, 0, 0);
							break;
						}
					case "shotgun_pump": //KRM-262
						ent.zombie_weapon_upgrade = "t5_mpl";
						break;
					case "smg_burst": //Pharo
						{
							if(GetDvarInt("mutator_bocw_pm63") == 2)
								ent.zombie_weapon_upgrade = "t9_amp63";
							else
								ent.zombie_weapon_upgrade = "t5_pm63";
							
							break;
						}
					case "ar_stg44":
						{
							if(GetDvarInt("mutator_bocw_m16") == 2)
								ent.zombie_weapon_upgrade = "t9_m16";
							else	
								ent.zombie_weapon_upgrade = "t5_m16a1";
							
							break;
						}
					case "ar_longburst": //M8A7
						{
							if(GetDvarInt("mutator_bocw_mp5k") == 2)
								ent.zombie_weapon_upgrade = "t9_mp5k";
							else
								ent.zombie_weapon_upgrade = "t5_mp5k";
						
							break;
						}
					case "ar_standard": //KN-44
						ent.zombie_weapon_upgrade = "s2_sten";
						break;
					case "shotgun_precision": //Argus
					case "smg_standard": //Kuda
					case "smg_versatile": //VMP
					case "ar_cqb": //HVK-30
					case "ar_accurate": //ICR-1
						ent struct::delete();
						break;
					}
				}
				break;
			}
		case "zm_factory": //The Giant
			{
				if(GetGametypeSetting(mutator_waw_wall_weapons) == 1 || !GetGametypeSetting(mutator_waw_wall_weapons))
				{
					switch(VAL)
					{
					case "pistol_burst": //RK5
						ent.zombie_weapon_upgrade = "t4_kar98k";
						break;
					case "ar_marksman": //Sheiva
						ent.zombie_weapon_upgrade = "t4_g43";
						break;
					case "shotgun_pump": //KRM-262
						ent.zombie_weapon_upgrade = "t4_db";
						break;
					case "smg_versatile": //VMP
						{
							ent.zombie_weapon_upgrade = "t4_thompson";
							
							ent.origin += (20, 0, 0);
							spawn_loc = struct::get(ent.target, "targetname");
							spawn_loc.origin += (20, 0, 0);
							break;
						}
					case "pistol_fullauto": //L-CAR 9
						ent.zombie_weapon_upgrade = "t4_carbine";
						break;
					case "smg_fastfire": //Vesper
						ent.zombie_weapon_upgrade = "t4_fg42";
						break;
					case "smg_standard": //Kuda
						{
							ent.zombie_weapon_upgrade = "t4_m1897";
							
							ent.origin += (0, 5, 5);
							spawn_loc = struct::get(ent.target, "targetname");
							spawn_loc.origin += (0, 5, 5);
							break;
						}
					case "ar_longburst": //M8A7
						{
							ent.zombie_weapon_upgrade = "t5_mp40";
							ent.origin += (1, 0, 0);
							spawn_loc = struct::get(ent.target, "targetname");
							spawn_loc.origin += (1, 0, 0);
							break;
						}
					case "ar_cqb": //HVK-30
						ent.zombie_weapon_upgrade = "t4_type100";
						break;
					case "ar_standard": //KN-44
						ent.zombie_weapon_upgrade = "t4_mp44";
						break;
					}
				}
				else if(GetGametypeSetting(mutator_waw_wall_weapons) == 2)
				{
					switch(VAL)
					{
					case "pistol_burst": //RK5
						ent.zombie_weapon_upgrade = "t5_olympia";
						break;
					case "ar_marksman": //Sheiva
						{
							if(GetDvarInt("mutator_bocw_m14") == 2)
								ent.zombie_weapon_upgrade = "t9_m14classic";
							else
								ent.zombie_weapon_upgrade = "t5_m14";
							
							break;
						}
					case "shotgun_pump": //KRM-262
						ent.zombie_weapon_upgrade = "t5_mpl";
						break;
					case "smg_versatile": //VMP
						{
							if(GetDvarInt("mutator_bocw_ak74u") == 2)
								ent.zombie_weapon_upgrade = "t9_ak74u";
							else
								ent.zombie_weapon_upgrade = "t5_ak74u";
							
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
					case "smg_fastfire": //Vesper
						{
							/*if(GetDvarInt("mutator_bocw_aug") == 2)
								ent.zombie_weapon_upgrade = "t9_aug";
							else*/
								ent.zombie_weapon_upgrade = "t5_aug";
							
							break;
						}
					case "smg_standard": //Kuda
						{
							if(GetDvarInt("mutator_bocw_hauer77") == 2)
								ent.zombie_weapon_upgrade = "t9_hauer77";
							else
								ent.zombie_weapon_upgrade = "t5_stakeout";
							
							ent.origin += (0, -7, 0);
							spawn_loc = struct::get(ent.target, "targetname");
							spawn_loc.origin += (0, -7, 0);
							break;
						}
					case "ar_longburst": //M8A7
						{
							ent.zombie_weapon_upgrade = "t5_mp40";
							ent.origin += (1, 0, 0);
							spawn_loc = struct::get(ent.target, "targetname");
							spawn_loc.origin += (1, 0, 0);
							break;
						}
					case "ar_cqb": //HVK-30
						{
							if(GetDvarInt("mutator_bocw_mp5k") == 2)
								ent.zombie_weapon_upgrade = "t9_mp5k";
							else
								ent.zombie_weapon_upgrade = "t5_mp5k";
							
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
					}
				}
				break;
			}
		case "zm_theater": //Kino der Toten
			{
				if(VAL == "smg_fastfire") //Vesper
				{
					if(GetGametypeSetting(mutator_aug) == 1 && (!GetGametypeSetting(mutator_wallbuys_kino_der_toten) || GetGametypeSetting(mutator_wallbuys_kino_der_toten) == 5))
					{
						/*if(GetDvarInt("mutator_bocw_aug") == 2)
							ent.zombie_weapon_upgrade = "t9_aug";
						else*/
							ent.zombie_weapon_upgrade = "t5_aug";
						
						ent.origin = (3, 926, -30);
						ent.angles = (0, 180, 0);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin = (3, 926, -30);
						spawn_loc.angles = (0, 180, 0);
					}
					else
						ent struct::delete();
				}
				
				if(!GetGametypeSetting(mutator_wallbuys_kino_der_toten) || GetGametypeSetting(mutator_wallbuys_kino_der_toten) == 5) //Black Ops
				{
					switch(VAL)
					{
						case "ar_marksman": //Sheiva
						{
							ent.zombie_weapon_upgrade = "t5_olympia";
							break;
						}
						case "pistol_burst": //RK5
						{
							if(GetDvarInt("mutator_bocw_m14") == 2)
								ent.zombie_weapon_upgrade = "t9_m14classic";
							else
								ent.zombie_weapon_upgrade = "t5_m14";
							
							break;
						}
						case "smg_burst": //Pharo
						{
							if(GetDvarInt("mutator_bocw_pm63") == 2)
								ent.zombie_weapon_upgrade = "t9_amp63";
							else
								ent.zombie_weapon_upgrade = "t5_pm63";
							
							break;
						}
						case "shotgun_precision": //Argus
						{
							if(GetDvarInt("mutator_bocw_hauer77") == 2)
								ent.zombie_weapon_upgrade = "t9_hauer77";
							else
								ent.zombie_weapon_upgrade = "t5_stakeout";
							
							break;
						}
						case "ar_standard": //KN-44
						{
							if(GetDvarInt("mutator_bocw_mp5k") == 2)
								ent.zombie_weapon_upgrade = "t9_mp5k";
							else
								ent.zombie_weapon_upgrade = "t5_mp5k";
							
							break;
						}
						case "ar_accurate": //ICR-1
						{
							if(GetDvarInt("mutator_bocw_m16") == 2)
								ent.zombie_weapon_upgrade = "t9_m16";
							else	
								ent.zombie_weapon_upgrade = "t5_m16a1";
							
							break;
						}
						case "pistol_fullauto": //L-CAR 9
						{
							ent.zombie_weapon_upgrade = "t5_mpl";
							break;
						}
						case "smg_versatile": //VMP
						{
							if(GetDvarInt("mutator_bocw_ak74u") == 2)
								ent.zombie_weapon_upgrade = "t9_ak74u";
							else
								ent.zombie_weapon_upgrade = "t5_ak74u";
							
							ent.origin += (-2, 0, 0);
							spawn_loc = struct::get(ent.target, "targetname");
							spawn_loc.origin += (-2, 0, 0);
							
							break;
						}
						case "ar_longburst": //M8A7
						{
							ent struct::delete();
							break;
						}
					}
				}
				else if(GetGametypeSetting(mutator_wallbuys_kino_der_toten) == 1) //Der Riese
				{
					switch(VAL)
					{
						case "ar_marksman": //Sheiva
							ent.zombie_weapon_upgrade = "t4_kar98k";
							break;
						case "pistol_burst": //RK5
							ent.zombie_weapon_upgrade = "t4_g43";
							break;
						case "smg_burst": //Pharo
							ent.zombie_weapon_upgrade = "t4_carbine";
							break;
						case "shotgun_precision": //Argus
							ent.zombie_weapon_upgrade = "t4_m1897";
							break;
						case "ar_standard": //KN-44
							ent.zombie_weapon_upgrade = "t4_type100";
							break;
						case "ar_accurate": //ICR-1
							ent.zombie_weapon_upgrade = "t4_mp44";
							break;
						case "pistol_fullauto": //L-CAR 9
							{
								ent.zombie_weapon_upgrade = "t4_db";
								
								ent.origin += (0, -2, 0);
								spawn_loc = struct::get(ent.target, "targetname");
								spawn_loc.origin += (0, -2, 0);
								
								break;
							}
						case "smg_versatile": //VMP
							ent.zombie_weapon_upgrade = "t4_thompson";
							break;
						case "ar_longburst": //M8A7
						{
							ent struct::delete();
							break;
						}
					}
				}
				else if(GetGametypeSetting(mutator_wallbuys_kino_der_toten) == 3 || GetGametypeSetting(mutator_wallbuys_kino_der_toten) == 4) //WaW - Black Ops-style
				{
					switch(VAL)
					{
						case "ar_marksman": //Sheiva
							ent.zombie_weapon_upgrade = "t4_db";
							break;
						case "pistol_burst": //RK5
							ent.zombie_weapon_upgrade = "t4_m1";
							break;
						case "smg_burst": //Pharo
							{
								if(GetGametypeSetting(mutator_wallbuys_kino_der_toten) == 3)
									ent.zombie_weapon_upgrade = "t4_bar";
								else
									ent.zombie_weapon_upgrade = "t4_fg42";

								break;
							}
						case "shotgun_precision": //Argus
							ent.zombie_weapon_upgrade = "t4_m1897";
							break;
						case "ar_standard": //KN-44
							ent.zombie_weapon_upgrade = "t4_type100";
							break;
						case "ar_accurate": //ICR-1
							ent.zombie_weapon_upgrade = "t4_mp44";
							break;
						case "pistol_fullauto": //L-CAR 9
							{
								if(GetGametypeSetting(mutator_wallbuys_kino_der_toten) == 3)
									ent.zombie_weapon_upgrade = "t4_fg42";
								else
									ent.zombie_weapon_upgrade = "t4_bar";
									
								
								ent.origin += (0, -2, 0);
								spawn_loc = struct::get(ent.target, "targetname");
								spawn_loc.origin += (0, -2, 0);
								
								break;
							}
						case "smg_versatile": //VMP
							ent.zombie_weapon_upgrade = "t4_thompson";
							break;
						case "ar_longburst": //M8A7
						{
							ent struct::delete();
							break;
						}
					}
				}
				else if(GetGametypeSetting(mutator_wallbuys_kino_der_toten) == 2) //Conn6orsuper117
				{
					switch(VAL)
					{
						case "ar_marksman": //Sheiva
							ent.zombie_weapon_upgrade = "t4_kar98k";
							break;
						case "pistol_burst": //RK5
							ent.zombie_weapon_upgrade = "t4_g43";
							break;
						case "smg_burst": //Pharo
							ent.zombie_weapon_upgrade = "t4_m1";
							break;
						case "pistol_fullauto": //L-CAR 9
							{
								ent.zombie_weapon_upgrade = "t4_carbine";
								
								ent.origin += (0, -2, 0);
								spawn_loc = struct::get(ent.target, "targetname");
								spawn_loc.origin += (0, -2, 0);
								
								break;
							}
						case "shotgun_precision": //Argus
							ent.zombie_weapon_upgrade = "t4_m1897";
							break;
						case "smg_versatile": //VMP
							ent.zombie_weapon_upgrade = "t4_thompson";
							break;
						case "ar_longburst": //M8A7
							{
								ent.zombie_weapon_upgrade = "t4_db_saw";

								ent.origin += (14, 20, 5);
								spawn_loc = struct::get(ent.target, "targetname");
								spawn_loc.origin += (14, 0, 5);
								
								break;
							}
						case "ar_standard": //KN-44
							ent.zombie_weapon_upgrade = "t4_mp44";
							break;
						case "ar_accurate": //ICR-1
							ent.zombie_weapon_upgrade = "t4_bar";
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
					{
						if(GetDvarInt("mutator_bocw_m14") == 2)
							ent.zombie_weapon_upgrade = "t9_m14classic";
						else
							ent.zombie_weapon_upgrade = "t5_m14";
						
						break;
					}
					case "pistol_burst": //RK5
					{
						if (rk5 == 0)
							ent.zombie_weapon_upgrade = "t5_olympia";
						else
						{
							if(GetDvarInt("mutator_bocw_mp5k") == 2)
								ent.zombie_weapon_upgrade = "t9_mp5k";
							else
								ent.zombie_weapon_upgrade = "t5_mp5k";
						}
						
						rk5 = 1;
						break;
					}
					case "shotgun_precision": //Argus
					{
						if(GetDvarInt("mutator_bocw_hauer77") == 2)
							ent.zombie_weapon_upgrade = "t9_hauer77";
						else
							ent.zombie_weapon_upgrade = "t5_stakeout";
						
						break;
					}
					case "ar_standard": //KN-44
					{
						ent struct::delete();
						break;
					}
					case "smg_fastfire": //Vesper
					{
						if(GetDvarInt("mutator_bocw_ak74u") == 2)
							ent.zombie_weapon_upgrade = "t9_ak74u";
						else
							ent.zombie_weapon_upgrade = "t5_ak74u";
						
						break;
					}
					case "ar_accurate": //ICR-1
					{
						ent struct::delete();
						break;
					}
					case "pistol_fullauto": //L-CAR 9
					{
						ent.zombie_weapon_upgrade = "t5_mpl";
						break;
					}
					case "smg_versatile": //VMP
					{
						if(GetDvarInt("mutator_bocw_pm63") == 2)
							ent.zombie_weapon_upgrade = "t9_amp63";
						else
							ent.zombie_weapon_upgrade = "t5_pm63";
						
						break;
					}
					//Remove
					case "smg_standard": //Kuda
					{
						ent struct::delete();
						break;
					}
					case "ar_cqb": //HVK-30
					{
						if(GetDvarInt("mutator_bocw_m16") == 2)
							ent.zombie_weapon_upgrade = "t9_m16";
						else	
							ent.zombie_weapon_upgrade = "t5_m16a1";
						
						break;
					}
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
					{
						if(GetDvarInt("mutator_bocw_m14") == 2)
							ent.zombie_weapon_upgrade = "t9_m14classic";
						else
							ent.zombie_weapon_upgrade = "t5_m14";
						
						ent.origin += (0, -5, 0);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (0, -5, 0);
						break;
					}
					case "pistol_burst": //RK5
					{
						ent.zombie_weapon_upgrade = "t5_olympia";
						ent.origin += (0, 10, 0);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (0, 10, 0);
						break;
					}
					case "ar_standard": //KN-44
					{
						if(GetDvarInt("mutator_bocw_ak74u") == 2)
							ent.zombie_weapon_upgrade = "t9_ak74u";
						else
							ent.zombie_weapon_upgrade = "t5_ak74u";
						
						ent.origin += (5, 0, 0);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (5, 0, 0);
						break;
					}
					case "shotgun_precision": //Argus
					{
						if(GetDvarInt("mutator_bocw_hauer77") == 2)
							ent.zombie_weapon_upgrade = "t9_hauer77";
						else
							ent.zombie_weapon_upgrade = "t5_stakeout";
						
						ent.origin += (0, 9, 0);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (0, 9, 0);
						break;
					}
					case "pistol_fullauto": //L-CAR 9
					{
						ent.zombie_weapon_upgrade = "t5_mpl";
						ent.origin += (0, -5, 0);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (0, -5, 0);
						break;
					}
					case "smg_burst": //Pharo
					{
						if(GetDvarInt("mutator_bocw_pm63") == 2)
							ent.zombie_weapon_upgrade = "t9_amp63";
						else
							ent.zombie_weapon_upgrade = "t5_pm63";
						
						ent.origin += (0, -1, 0);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (0, -1, 0);
						break;
					}
					case "smg_versatile": //VMP
					{
						if(GetDvarInt("mutator_bocw_mp5k") == 2)
							ent.zombie_weapon_upgrade = "t9_mp5k";
						else
							ent.zombie_weapon_upgrade = "t5_mp5k";

						break;
					}
					case "smg_standard": //Kuda
					{
						if(GetDvarInt("mutator_bocw_m16") == 2)
							ent.zombie_weapon_upgrade = "t9_m16";
						else	
							ent.zombie_weapon_upgrade = "t5_m16a1";
						
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
		case "zm_zod": //Shadows of Evil
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
			}
		case "zm_giant": //TrustInUma's DER RIESE
			{
				if(GetGametypeSetting(mutator_waw_wall_weapons) != 2 || !GetGametypeSetting(mutator_waw_wall_weapons))
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
				}
				else if(GetGametypeSetting(mutator_waw_wall_weapons) == 2)
				{
					switch(VAL)
					{
					case "pistol_burst": //RK5
						ent.zombie_weapon_upgrade = "t5_olympia";
						break;
					case "ar_marksman": //Sheiva
						{
							if(GetDvarInt("mutator_bocw_m14") == 2)
								ent.zombie_weapon_upgrade = "t9_m14classic";
							else
								ent.zombie_weapon_upgrade = "t5_m14";
							
							break;
						}
					case "shotgun_pump": //KRM-262
						ent.zombie_weapon_upgrade = "t5_mpl";
						break;
					case "smg_burst": //Pharo
						{
							if(GetDvarInt("mutator_bocw_ak74u") == 2)
								ent.zombie_weapon_upgrade = "t9_ak74u";
							else
								ent.zombie_weapon_upgrade = "t5_ak74u";
							
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
					case "ar_cqb": //HVK-30
						{
							/*if(GetDvarInt("mutator_bocw_aug") == 2)
								ent.zombie_weapon_upgrade = "t9_aug";
							else*/
								ent.zombie_weapon_upgrade = "t5_aug";
							
							break;
						}
					case "shotgun_precision": //Argus
						{
							if(GetDvarInt("mutator_bocw_hauer77") == 2)
								ent.zombie_weapon_upgrade = "t9_hauer77";
							else
								ent.zombie_weapon_upgrade = "t5_stakeout";
							
							break;
						}
					case "smg_mp40_1940":
						{
							ent.origin += (4, 0, 0);
							spawn_loc = struct::get(ent.target, "targetname");
							spawn_loc.origin += (4, 0, 0);
							break;
						}
					case "smg_sten":
						{
							if(GetDvarInt("mutator_bocw_mp5k") == 2)
								ent.zombie_weapon_upgrade = "t9_mp5k";
							else
								ent.zombie_weapon_upgrade = "t5_mp5k";
							
							break;
						}
					case "ar_stg44":
						{
							if(GetDvarInt("mutator_bocw_m16") == 2)
								ent.zombie_weapon_upgrade = "t9_m16";
							else	
								ent.zombie_weapon_upgrade = "t5_m16a1";
							
							break;
						}
					}
				}
				break;
			}
		case "zm_der_riese": //Der Riese: Declassified
			{
				if(GetGametypeSetting(mutator_waw_wall_weapons) == 1 || !GetGametypeSetting(mutator_waw_wall_weapons))
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
				}
				else if(GetGametypeSetting(mutator_waw_wall_weapons) == 2)
				{
					switch(VAL)
					{
					case "s2_kar98k_irons":
						ent.zombie_weapon_upgrade = "t5_olympia";
						break;
					case "s2_gewehr43":
						{
							if(GetDvarInt("mutator_bocw_m14") == 2)
								ent.zombie_weapon_upgrade = "t9_m14classic";
							else
								ent.zombie_weapon_upgrade = "t5_m14";
							
							break;
						}
					case "s2_m30":
						ent.zombie_weapon_upgrade = "t5_mpl";
						break;
					case "s2_thompsonm1a1":
						{
							if(GetDvarInt("mutator_bocw_ak74u") == 2)
								ent.zombie_weapon_upgrade = "t9_ak74u";
							else
								ent.zombie_weapon_upgrade = "t5_ak74u";
							
							break;
						}
					case "s2_m1a1carbine":
						{
							if(GetDvarInt("mutator_bocw_pm63") == 2)
								ent.zombie_weapon_upgrade = "t9_amp63";
							else
								ent.zombie_weapon_upgrade = "t5_pm63";
							
							break;
						}
					case "s2_fg42":
						{
							/*if(GetDvarInt("mutator_bocw_aug") == 2)
								ent.zombie_weapon_upgrade = "t9_aug";
							else*/
								ent.zombie_weapon_upgrade = "t5_aug";
							
							break;
						}
					case "t8_m1897":
						{
							if(GetDvarInt("mutator_bocw_hauer77") == 2)
								ent.zombie_weapon_upgrade = "t9_hauer77";
							else
								ent.zombie_weapon_upgrade = "t5_stakeout";
							
							break;
						}
					case "s2_type100":
						{
							if(GetDvarInt("mutator_bocw_mp5k") == 2)
								ent.zombie_weapon_upgrade = "t9_mp5k";
							else
								ent.zombie_weapon_upgrade = "t5_mp5k";
							
							break;
						}
					case "s2_stg44":
						{
							if(GetDvarInt("mutator_bocw_m16") == 2)
								ent.zombie_weapon_upgrade = "t9_m16";
							else	
								ent.zombie_weapon_upgrade = "t5_m16a1";
							
							break;
						}
					}
				}
				break;
			}
			case "zm_tomb": //Origins
			{
				if(!GetGametypeSetting(mutator_wallbuys_origins) || GetGametypeSetting(mutator_wallbuys_origins) == 1)
				{
					switch(VAL)
					{
						case "pistol_burst": //RK5
						{
							if(GetDvarInt("mutator_bocw_m14") == 2)
								ent.zombie_weapon_upgrade = "t9_m14classic";
							else
								ent.zombie_weapon_upgrade = "t5_m14";
							
							break;
						}
						case "ar_marksman": //Sheiva":
						{
							ent.zombie_weapon_upgrade = "t5_olympia";
							break;
						}
						case "pistol_fullauto": //L-CAR 9
						{
							ent.zombie_weapon_upgrade = "t5_mpl";
							break;
						}
						case "smg_fastfire": //Vesper
						{
							if(vesper == 0)
							{
								ent.zombie_weapon_upgrade = "t5_mpl";
								vesper = 1;
							}
							else
							{
								if(GetDvarInt("mutator_bocw_ak74u") == 2)
									ent.zombie_weapon_upgrade = "t9_ak74u";
								else
									ent.zombie_weapon_upgrade = "t5_ak74u";
							}
							break;
						}
						case "shotgun_pump": //KRM-262
						{
							if(GetDvarInt("mutator_bocw_hauer77") == 2)
								ent.zombie_weapon_upgrade = "t9_hauer77";
							else
								ent.zombie_weapon_upgrade = "t5_stakeout";
							
							break;
						}
						case "shotgun_precision": //Argus
						{
							if(argus == 0)
							{
								if(GetDvarInt("mutator_bocw_hauer77") == 2)
									ent.zombie_weapon_upgrade = "t9_hauer77";
								else
									ent.zombie_weapon_upgrade = "t5_stakeout";
								
								argus = 1;
							}
							else
							{
								if(GetDvarInt("mutator_bocw_mp5k") == 2)
									ent.zombie_weapon_upgrade = "t9_mp5k";
								else
									ent.zombie_weapon_upgrade = "t5_mp5k";
							}
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
						case "smg_versatile": //VMP
						case "ar_standard": //KN-44
						{
							ent.zombie_weapon_upgrade = "t5_mp40";
							break;
						}
						case "ar_accurate": //ICR-1
						{
							if(GetDvarInt("mutator_bocw_aug") == 2)
								ent.zombie_weapon_upgrade = "t9_aug";
							else
								ent.zombie_weapon_upgrade = "t5_aug";
							
							break;
						}
						case "ar_longburst": //M8A7
						{
							if(GetDvarInt("mutator_bocw_m16") == 2)
								ent.zombie_weapon_upgrade = "t9_m16";
							else
								ent.zombie_weapon_upgrade = "t5_m16a1";
							
							break;
						}
						case "ar_cqb": //HVK-30
						{
							if(GetDvarInt("mutator_bocw_mp5k") == 2)
								ent.zombie_weapon_upgrade = "t9_mp5k";
							else
								ent.zombie_weapon_upgrade = "t5_mp5k";
							
							break;
						}
					}
				}
				else if(GetGametypeSetting(mutator_wallbuys_origins) == 2)
				{
					switch(VAL)
					{
					case "pistol_burst": //RK5
						ent.zombie_weapon_upgrade = "t4_g43";
						break;
					case "ar_marksman": //Sheiva
						ent.zombie_weapon_upgrade = "t4_kar98k";
						break;
					case "shotgun_pump": //KRM-262
						ent.zombie_weapon_upgrade = "t4_m1897";
						break;
					case "ar_standard": //KN-44
						ent.zombie_weapon_upgrade = "t5_mp40";
						break;
					case "smg_standard": //Kuda
						ent.zombie_weapon_upgrade = "t4_thompson";
						break;
					case "pistol_fullauto": //L-CAR 9
						ent.zombie_weapon_upgrade = "t4_carbine";
						break;
					case "smg_fastfire": //Vesper
						ent.zombie_weapon_upgrade = "t4_fg42";
						break;
					case "ar_accurate": //ICR-1
						ent struct::delete();
						break;
					case "ar_cqb": //HVK-30
						ent.zombie_weapon_upgrade = "t4_bar";
						break;
					case "smg_versatile": //VMP
						ent.zombie_weapon_upgrade = "t5_mp40";
						break;
					case "shotgun_precision": //Argus
						ent.zombie_weapon_upgrade = "t4_db";
						break;
					case "ar_longburst": //M8A7
						ent.zombie_weapon_upgrade = "t4_type100";
						break;
					case "ar_stg44":
						ent.zombie_weapon_upgrade = "t4_mp44";
						break;
					case "smg_thompson":
						ent.zombie_weapon_upgrade = "t4_mp44";
						break;
					}
				}
				break;
			}
			case "zm_theater": //Kino der Toten
			{
				if(VAL == "smg_fastfire") //Vesper
				{
					/*if(GetDvarInt("mutator_scopedfg42") == 1)
					{
						ent.zombie_weapon_upgrade = "t4_fg42_scoped";
						
						ent.origin = (3, 926, -30);
						ent.angles = (0, 180, 0);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin = (3, 926, -30);
						spawn_loc.angles = (0, 180, 0);
					}
					else*/
						ent struct::delete();
				}
				
				break;
			}
		case "zm_coast":
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
			}
		case "zm_castle": //Der Eisendrache
			{
				if(!GetGametypeSetting(mutator_wallbuys_der_eisendrache) || GetGametypeSetting(mutator_wallbuys_der_eisendrache) == 1) //poyzee
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
				}
				else if(GetGametypeSetting(mutator_wallbuys_der_eisendrache) == 2) //Conn6orsuper117	
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
						case "pistol_fullauto": //L-CAR 9
							{
								if(lcar9 == 1) //left from spawn
								{
									ent.zombie_weapon_upgrade = "t4_m1";
									
									ent.origin += (4*cos(spawn_loc.angles[1]), 4*sin(spawn_loc.angles[1]), 0);
									spawn_loc = struct::get(ent.target, "targetname");
									spawn_loc.origin += (4*cos(spawn_loc.angles[1]), 4*sin(spawn_loc.angles[1]), 0);
								}
								else //Right from spawn
								{
									/*switch(GetGametypeSetting(mutator_scopeads))
									{
									case 1:
										ent.zombie_weapon_upgrade = "t4_kar98k_scope_overlay";
										break;
									case 3:
										ent.zombie_weapon_upgrade = "t4_kar98k_scope_switch";
										break;
									default:*/
										ent.zombie_weapon_upgrade = "t4_kar98k_scope"; //actually this is the overlay version
										/*break;
									}*/
								}
								
								lcar9++;
								break;
							}
						case "shotgun_pump": //KRM-262
							{
								if(krm262 == 0)
									ent.zombie_weapon_upgrade = "t4_thompson";
								else
									ent.zombie_weapon_upgrade = "t4_carbine";
								
								krm262++;
								break;
							}
						case "smg_standard": //Kuda
							ent.zombie_weapon_upgrade = "t4_bar";
							break;
						case "smg_fastfire": //Vesper
							{
								if(vesper == 1) //Left from Spawn
									ent.zombie_weapon_upgrade = "t4_db";
								else //Right from Spawn
									ent.zombie_weapon_upgrade = "t4_db_saw";
								
								vesper++;
								break;
							}
						case "ar_longburst": //M8A7
							ent.zombie_weapon_upgrade = "t4_mp44";
							break;
						case "ar_cqb": //HVK-30
							{
								if(hvk30 == 0) //Castle Interior
								{
									ent.zombie_weapon_upgrade = "t4_m1897";
									
									ent.origin += (7.5, 0, 0);
									spawn_loc = struct::get(ent.target, "targetname");
									spawn_loc.origin += (7.5, 0, 0);
								}
								else //Undercroft
									ent.zombie_weapon_upgrade = "t4_mp44";
								
								hvk30++;
								break;
							}
						case "smg_versatile": //VMP
							ent.zombie_weapon_upgrade = "t4_type100";
							break;
						case "ar_standard": //KN-44
							{
								if(kn44 == 0)
									ent.zombie_weapon_upgrade = "t5_mp40";
								else
								{
									ent.zombie_weapon_upgrade = "t4_fg42";
									
									ent.origin += (-10, 0, 0);
									spawn_loc = struct::get(ent.target, "targetname");
									spawn_loc.origin += (-10, 0, 0);
								}
								
								kn44++;
								break;
							}
					}
				}
				break;
			}
			case "zm_island": //Zetsubou no Shima
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
			}
			case "zm_stalingrad": //Gorod Krovi
			{ //HzRetro
				switch(VAL)
				{
				case "ar_marksman": //Sheiva
					ent.zombie_weapon_upgrade = "t5_olympia";
					break;
				case "pistol_burst": //RK5
					ent.zombie_weapon_upgrade = "t5_m14";
					break;
				case "shotgun_pump": //KRM-262
					ent.zombie_weapon_upgrade = "t5_pm63";
					break;
				case "pistol_fullauto": //L-CAR 9
					ent.zombie_weapon_upgrade = "t5_mpl";
					break;
				case "smg_burst": //Pharo
				case "ar_standard": //KN-44
					ent struct::delete();
					break;
				case "smg_standard": //Kuda
					ent.zombie_weapon_upgrade = "t5_mp5k";
					break;
				case "shotgun_precision": //Argus
					ent.zombie_weapon_upgrade = "t5_stakeout";
					break;
				case "ar_cqb": //HVK-30
					ent.zombie_weapon_upgrade = "sticky_grenade_custom";
					break;
				case "smg_versatile": //VMP
					ent.zombie_weapon_upgrade = "t5_ak74u";
					break;
				case "smg_fastfire": //Vesper
					ent.zombie_weapon_upgrade = "t5_mp40";
					break;
				case "ar_longburst": //M8A7
					ent.zombie_weapon_upgrade = "t5_m16a1";
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
						ent.zombie_weapon_upgrade = "t5_olympia";
						
						ent.origin += (0, 8, 0);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (0, 8, 0);
						
						break;
					}
				case "pistol_burst": //RK5
					{
						ent.zombie_weapon_upgrade = "t5_m14";
						
						ent.origin += (0, -10, 0);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (0, -10, 0);
						
						break;
					}
				case "shotgun_pump": //KRM-262
					ent.zombie_weapon_upgrade = "t5_stakeout";
					break;
				case "ar_longburst": //M8A7
					ent.zombie_weapon_upgrade = "t5_m16a1";
					break;
				case "pistol_fullauto": //L-CAR 9
					ent.zombie_weapon_upgrade = "t5_mpl";
					break;
				case "smg_standard": //Kuda
					ent.zombie_weapon_upgrade = "t5_mp5k";
					break;
				case "smg_versatile": //VMP
					{
						ent.zombie_weapon_upgrade = "t5_ak74u";
						
						ent.origin += (10, 0, 0);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (10, 0, 0);
						
						break;
					}
				case "frag_grenade":
					ent.zombie_weapon_upgrade = "sticky_grenade_custom";
					break;
				}
				break;
			}
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

	switch(GetDvarString("mapname"))
	{
	case "zm_zod": //Shadows of Evil
		{
			foreach(ent in GetEntArray("train_buyable_weapon", "script_noteworthy"))
				ent.zombie_weapon_upgrade = "s2_sten";
			break;
		}
	}

	if(GetGametypeSetting(mutator_claymore) == 1)
	{
		count = 0;
		foreach(ent in struct::get_array("claymore_purchase", "targetname"))
		{
			VAL = ent.zombie_weapon_upgrade;
			if(!isdefined(VAL))
			{
				continue;
			}
			if((GetDvarString("mapname") == "zm_asylum" && count == 0) || (GetGametypeSetting(mutator_waw_wall_weapons) != 2 && (GetDvarString("mapname") == "zm_asylum" || GetDvarString("mapname") == "zm_sumpf" || GetDvarString("mapname") == "zm_factory")))
				ent.zombie_weapon_upgrade = "bo1_bouncingbetty";
			else if(GetDvarString("mapname") != "zm_asylum" || (GetDvarString("mapname") == "zm_asylum" && count != 0)) //Don't delete German side
				ent struct::delete();
			
			count = 1;
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
	pm63 = 0;
	ak74u = 0;
	stakeout = 0;
	m16 = 0;
	m14 = 0;
	olympia = 0;
	sten = 0;
	argus = 0;
	mp40 = 0;
	stg44 = 0;
	doublebarrel = 0;
	trenchgun = 0;
	kar98k = 0;
	if(!(GetDvarString("mapname") == "zm_coast")) { //don't re-draw over existing ones
	foreach(ent in struct::get_array("weapon_upgrade", "targetname"))
	{
		VAL = ent.zombie_weapon_upgrade;
		if(!isdefined(VAL))
		{
			break;
		}
		switch(VAL)
		{
			case "t4_kar98k":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_prototype":
				case "zm_factory":
				case "zm_der_riese":
				case "zm_giant":
				case "zm_theater":																		// ↔   ↔  ↕
					ent.var_47896610 = util::spawn_model("wallbuy_kar98k", spawn_loc.origin + VectorScale((0, 13, -3), 1), spawn_loc.angles);
					break;
				case "zm_asylum":
					{
						if((GetGametypeSetting(mutator_verruckt_springfield) == 1 || !GetGametypeSetting(mutator_verruckt_springfield)) && kar98k == 0)
							ent.var_47896610 = util::spawn_model("wallbuy_kar98k", spawn_loc.origin + VectorScale((-14, 0, -4), 1), spawn_loc.angles);
						else
							ent.var_47896610 = util::spawn_model("wallbuy_kar98k", spawn_loc.origin + VectorScale((1, 14, -4), 1), spawn_loc.angles);
						
						kar98k++;
						break;
					}
				case "zm_coast":
					ent.var_47896610 = util::spawn_model("wallbuy_kar98k", spawn_loc.origin + VectorScale((0, -13, -3), 1), spawn_loc.angles);
					break;
				case "zm_tomb": //Origins
					ent.var_47896610 = util::spawn_model("wallbuy_kar98k", spawn_loc.origin + VectorScale((-13, 0, -4), 1), spawn_loc.angles);
					break;
				case "zm_castle": //Der Eisendrache
					ent.var_47896610 = util::spawn_model("wallbuy_kar98k", spawn_loc.origin + VectorScale((12, 2, -3), 1), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_kar98k", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t4_kar98k_scope":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_prototype":
				{
					ent.var_47896610 = util::spawn_model("wm_kar98k_scope", spawn_loc.origin + VectorScale((1, -4, 0), 1), spawn_loc.angles);
					ent.var_47896611 = util::spawn_model("wm_kar98k_scope", spawn_loc.origin + VectorScale((0, 2, 0), 1), (-spawn_loc.angles[0],spawn_loc.angles[1],spawn_loc.angles[2]));
					break;
				}
				case "zm_castle": //Der Eisendrache
					ent.var_47896610 = util::spawn_model("wallbuy_kar98k_scoped", spawn_loc.origin + VectorScale((-12, 0, -2), 1), spawn_loc.angles);
					break;
				}
				break;
			}
			case "t4_spring":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_asylum":
					ent.var_47896610 = util::spawn_model("wallbuy_springfield", spawn_loc.origin + VectorScale((-14, 0, -4), 1), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_springfield", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t4_type99r":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_sumpf":
					ent.var_47896610 = util::spawn_model("wallbuy_arisaka", spawn_loc.origin + VectorScale((0, -12, -3), 1), spawn_loc.angles);
					break;
				case "zm_island": //Zetsubou no Shima
					ent.var_47896610 = util::spawn_model("wallbuy_arisaka", spawn_loc.origin + VectorScale((1, 12, -3), 1), spawn_loc.angles);
					break;
				default:	
					ent.var_47896610 = util::spawn_model("wallbuy_arisaka", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t4_g43":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_asylum":
				case "zm_sumpf":
					ent.var_47896610 = util::spawn_model("wallbuy_gewehr43", spawn_loc.origin + VectorScale((0, 13, -3), 1), spawn_loc.angles);
					break;
				case "zm_factory":
				case "zm_der_riese":
				case "zm_giant":
				case "zm_coast":
					ent.var_47896610 = util::spawn_model("wallbuy_gewehr43", spawn_loc.origin + VectorScale((1, 13, -2), 1), spawn_loc.angles);
					break;
				case "zm_theater":
					ent.var_47896610 = util::spawn_model("wallbuy_gewehr43", spawn_loc.origin + VectorScale((13, 0, -2), 1), spawn_loc.angles);
					break;
				case "zm_tomb":
					ent.var_47896610 = util::spawn_model("wallbuy_gewehr43", spawn_loc.origin + VectorScale((0, 13, -2), 1), spawn_loc.angles);
					break;
				case "zm_castle": //Der Eisendrache
					ent.var_47896610 = util::spawn_model("wallbuy_gewehr43", spawn_loc.origin + VectorScale((2, -13, -2), 1), spawn_loc.angles);
					break;
				case "zm_island": //Zetsubou no Shima
					ent.var_47896610 = util::spawn_model("wallbuy_gewehr43", spawn_loc.origin + VectorScale((0, 13, -2), 1), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_gewehr43", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t4_mp44":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_asylum":
					ent.var_47896610 = util::spawn_model("wallbuy_stg44", spawn_loc.origin + VectorScale((20, 0, -4), 1), spawn_loc.angles);
					break;
				case "zm_sumpf":
					ent.var_47896610 = util::spawn_model("wallbuy_stg44", spawn_loc.origin + VectorScale((-20*cos(spawn_loc.angles[1]), -20*sin(spawn_loc.angles[1]), -4), 1), spawn_loc.angles);
					break;
				case "zm_factory":
				case "zm_der_riese":
				case "zm_giant":
					ent.var_47896610 = util::spawn_model("wallbuy_stg44", spawn_loc.origin + VectorScale((-1, -20, -4), 1), spawn_loc.angles);
					break;
				case "zm_theater":
					{
						if(GetGametypeSetting(mutator_wallbuys_kino_der_toten) == 2) //Conn6orsuper117
							ent.var_47896610 = util::spawn_model("wallbuy_stg44", spawn_loc.origin + VectorScale((0, 20, -4), 1), spawn_loc.angles);
						else
							ent.var_47896610 = util::spawn_model("wallbuy_stg44", spawn_loc.origin + VectorScale((-20, 0, -4), 1), spawn_loc.angles);
						
						break;
					}
				case "zm_coast":
					ent.var_47896610 = util::spawn_model("wallbuy_stg44", spawn_loc.origin + VectorScale((-20*cos(spawn_loc.angles[1]), -20*sin(spawn_loc.angles[1]), -3), 1), spawn_loc.angles);
					break;
				case "zm_tomb": //Origins
					ent.var_47896610 = util::spawn_model("wallbuy_stg44", spawn_loc.origin + VectorScale((-20*cos(spawn_loc.angles[1]), -20*sin(spawn_loc.angles[1]), -4), 1), spawn_loc.angles);
					break;
				case "zm_castle": //Der Eisendrache
					{
						if(!GetGametypeSetting(mutator_wallbuys_der_eisendrache) || GetGametypeSetting(mutator_wallbuys_der_eisendrache) == 1) //poyzee
							ent.var_47896610 = util::spawn_model("wallbuy_stg44", spawn_loc.origin + VectorScale((-20, 0, -4), 1), spawn_loc.angles);
						else if(GetGametypeSetting(mutator_wallbuys_der_eisendrache) == 2) //Conn6orsuper117
						{
							if(stg44 == 0) //Mission Control
								ent.var_47896610 = util::spawn_model("wallbuy_stg44", spawn_loc.origin + VectorScale((0, -20, -4), 1), spawn_loc.angles);
							else //Undercroft
								ent.var_47896610 = util::spawn_model("wallbuy_stg44", spawn_loc.origin + VectorScale((-20, 0, -4), 1), spawn_loc.angles);
							
							stg44++;
						}
						break;
					}
				case "zm_island": //Zetsubou no Shima
					ent.var_47896610 = util::spawn_model("wallbuy_stg44", spawn_loc.origin + VectorScale((0, 20, -4), 1), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_stg44", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t4_carbine":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_prototype":
					ent.var_47896610 = util::spawn_model("wallbuy_m1carbine", spawn_loc.origin + VectorScale((0, 15, -4), 1), spawn_loc.angles);
					break;
				case "zm_sumpf":
				case "zm_theater":
					ent.var_47896610 = util::spawn_model("wallbuy_m1carbine", spawn_loc.origin + VectorScale((16, 0, -4), 1), spawn_loc.angles);
					break;
				case "zm_factory":
				case "zm_der_riese":
				case "zm_giant":
					ent.var_47896610 = util::spawn_model("wallbuy_m1carbine", spawn_loc.origin + VectorScale((-16, 1, -4), 1), spawn_loc.angles);
					break;
				case "zm_coast":
					ent.var_47896610 = util::spawn_model("wallbuy_m1carbine", spawn_loc.origin + VectorScale((1, -16, -2), 1), spawn_loc.angles);
					break;
				case "zm_tomb": //Origins
					ent.var_47896610 = util::spawn_model("wallbuy_m1carbine", spawn_loc.origin + VectorScale((-16, 0, -4), 1), spawn_loc.angles);
					break;
				case "zm_castle": //Der Eisendrache
					ent.var_47896610 = util::spawn_model("wallbuy_m1carbine", spawn_loc.origin + VectorScale((-16*cos(spawn_loc.angles[1]), -16*sin(spawn_loc.angles[1]), -4), 1), spawn_loc.angles);
					break;
				case "zm_island": //Zetsubou no Shima
					ent.var_47896610 = util::spawn_model("wallbuy_m1carbine", spawn_loc.origin + VectorScale((-13*cos(spawn_loc.angles[1])+3, -13*sin(spawn_loc.angles[1]), -4), 1), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_m1carbine", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t4_m1":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_asylum":
					ent.var_47896610 = util::spawn_model("wallbuy_m1garand", spawn_loc.origin + VectorScale((1, 13, -2), 1), spawn_loc.angles);
					break;
				case "zm_sumpf":
					ent.var_47896610 = util::spawn_model("wallbuy_m1garand", spawn_loc.origin + VectorScale((-13, 0, -3), 1), spawn_loc.angles);
					break;
				case "zm_theater":
					ent.var_47896610 = util::spawn_model("wallbuy_m1garand", spawn_loc.origin + VectorScale((13, 0, -3), 1), spawn_loc.angles);
					break;
				case "zm_castle": //Der Eisendrache
					ent.var_47896610 = util::spawn_model("wallbuy_m1garand", spawn_loc.origin + VectorScale((-13*cos(spawn_loc.angles[1])+1, -13*sin(spawn_loc.angles[1]), -3), 1), spawn_loc.angles);
					break;
				case "zm_island": //Zetsubou no Shima
					ent.var_47896610 = util::spawn_model("wallbuy_m1garand", spawn_loc.origin + VectorScale((-1, -14, -3), 1), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_m1garand", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t4_type100":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_sumpf":
					ent.var_47896610 = util::spawn_model("wallbuy_type100", spawn_loc.origin + VectorScale((-15*cos(spawn_loc.angles[1]), -15*sin(spawn_loc.angles[1]), -4), 1), spawn_loc.angles);
					break;
				case "zm_factory":
				case "zm_der_riese":
				case "zm_giant":
					ent.var_47896610 = util::spawn_model("wallbuy_type100", spawn_loc.origin + VectorScale((14, -1, -4), 1), spawn_loc.angles);
					break;
				case "zm_theater":
					ent.var_47896610 = util::spawn_model("wallbuy_type100", spawn_loc.origin + VectorScale((0, 14, -4), 1), spawn_loc.angles);
					break;
				case "zm_coast":
					ent.var_47896610 = util::spawn_model("wallbuy_type100", spawn_loc.origin + VectorScale((-14, 0, -4), 1), spawn_loc.angles);
					break;
				case "zm_tomb": //Origins
					ent.var_47896610 = util::spawn_model("wallbuy_type100", spawn_loc.origin + VectorScale((0, 14, -4), 1), spawn_loc.angles);
					break;
				case "zm_castle": //Der Eisendrache
					{
						if(!GetGametypeSetting(mutator_wallbuys_der_eisendrache) || GetGametypeSetting(mutator_wallbuys_der_eisendrache) == 1) //poyzee
							ent.var_47896610 = util::spawn_model("wallbuy_type100", spawn_loc.origin + VectorScale((-5, 14, -4), 1), spawn_loc.angles);
						else if(GetGametypeSetting(mutator_wallbuys_der_eisendrache) == 2) //Conn6orsuper117
							ent.var_47896610 = util::spawn_model("wallbuy_type100", spawn_loc.origin + VectorScale((-14*cos(spawn_loc.angles[1]), -14*sin(spawn_loc.angles[1]), -4), 1), spawn_loc.angles);
						
						break;
					}
				case "zm_island": //Zetsubou no Shima
					ent.var_47896610 = util::spawn_model("wallbuy_type100", spawn_loc.origin + VectorScale((-14*cos(spawn_loc.angles[1]), -14*sin(spawn_loc.angles[1]), -4), 1), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_type100", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t4_thompson":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_prototype":
					ent.var_47896610 = util::spawn_model("wallbuy_thompson", spawn_loc.origin + VectorScale((19, 0, -4), 1), spawn_loc.angles);
					break;
				case "zm_asylum":
					ent.var_47896610 = util::spawn_model("wallbuy_thompson", spawn_loc.origin + VectorScale((19, -1, -4), 1), spawn_loc.angles);
					break;
				case "zm_sumpf":
				case "zm_theater":
					ent.var_47896610 = util::spawn_model("wallbuy_thompson", spawn_loc.origin + VectorScale((-1, -19, -4), 1), spawn_loc.angles);
					break;
				case "zm_factory":
				case "zm_der_riese":
				case "zm_giant":
					ent.var_47896610 = util::spawn_model("wallbuy_thompson", spawn_loc.origin + VectorScale((-19, 1, -4), 1), spawn_loc.angles);
					break;
				case "zm_coast":
					ent.var_47896610 = util::spawn_model("wallbuy_thompson", spawn_loc.origin + VectorScale((19, 2, -4), 1), spawn_loc.angles);
					break;
				case "zm_tomb": //Origins
					ent.var_47896610 = util::spawn_model("wallbuy_thompson", spawn_loc.origin + VectorScale((-19, 0, -4), 1), spawn_loc.angles);
					break;
				case "zm_castle": //Der Eisendrache
					ent.var_47896610 = util::spawn_model("wallbuy_thompson", spawn_loc.origin + VectorScale((-19*cos(spawn_loc.angles[1]), -19*sin(spawn_loc.angles[1]), -4), 1), spawn_loc.angles);
					break;
				case "zm_island": //Zetsubou no Shima
					ent.var_47896610 = util::spawn_model("wallbuy_thompson", spawn_loc.origin + VectorScale((-19*cos(spawn_loc.angles[1]), -19*sin(spawn_loc.angles[1])-1, -4), 1), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_thompson", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t4_bar":
			case "t4_bar_bipod":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_prototype":
					ent.var_47896610 = util::spawn_model("wallbuy_bar", spawn_loc.origin + VectorScale((0, 11, -3), 1), spawn_loc.angles);
					break;
				case "zm_asylum":
					ent.var_47896610 = util::spawn_model("wallbuy_bar", spawn_loc.origin + VectorScale((0, 10, -3), 1), spawn_loc.angles);
					break;
				case "zm_sumpf":
					ent.var_47896610 = util::spawn_model("wallbuy_bar", spawn_loc.origin + VectorScale((-11*cos(spawn_loc.angles[1]), -11*sin(spawn_loc.angles[1]), -4), 1), spawn_loc.angles);
					break;
				case "zm_theater":
					{
						if(GetGametypeSetting(mutator_wallbuys_kino_der_toten) == 3 || GetGametypeSetting(mutator_wallbuys_kino_der_toten) == 4) //Black Ops
							ent.var_47896610 = util::spawn_model("wallbuy_bar", spawn_loc.origin + VectorScale((10, 0, -3), 1), spawn_loc.angles);
						else if(GetGametypeSetting(mutator_wallbuys_kino_der_toten) == 2) //Conn6orsuper117
							ent.var_47896610 = util::spawn_model("wallbuy_bar", spawn_loc.origin + VectorScale((-10, 0, -3), 1), spawn_loc.angles);

						break;
					}
				case "zm_tomb": //Origins
					ent.var_47896610 = util::spawn_model("wallbuy_bar", spawn_loc.origin + VectorScale((0, 12, -3), 1), spawn_loc.angles);
					break;
				case "zm_castle": //Der Eisendrache
					ent.var_47896610 = util::spawn_model("wallbuy_bar", spawn_loc.origin + VectorScale((-3, 12, -3), 1), spawn_loc.angles);
					break;
				case "zm_island": //Zetsubou no Shima
					ent.var_47896610 = util::spawn_model("wallbuy_bar", spawn_loc.origin + VectorScale((-11*cos(spawn_loc.angles[1]), -11*sin(spawn_loc.angles[1]), -3), 1), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_bar", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t4_fg42":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_factory":
				case "zm_der_riese":
				case "zm_giant":
					ent.var_47896610 = util::spawn_model("wallbuy_fg42", spawn_loc.origin + VectorScale((-15, 1, -2), 1), spawn_loc.angles);
					break;
				case "zm_theater":
					ent.var_47896610 = util::spawn_model("wallbuy_fg42", spawn_loc.origin + VectorScale((15, 0, -2), 1), spawn_loc.angles);
					break;
				case "zm_tomb": //Origins
					ent.var_47896610 = util::spawn_model("wallbuy_fg42", spawn_loc.origin + VectorScale((-16*cos(spawn_loc.angles[1]), -16*sin(spawn_loc.angles[1]), -3), 1), spawn_loc.angles);
					break;
				case "zm_castle": //Der Eisendrache
					{
						if(!GetGametypeSetting(mutator_wallbuys_der_eisendrache) || GetGametypeSetting(mutator_wallbuys_der_eisendrache) == 1) //poyzee
							ent.var_47896610 = util::spawn_model("wallbuy_fg42", spawn_loc.origin + VectorScale((0, -16, -2), 1), spawn_loc.angles);
						else if(GetGametypeSetting(mutator_wallbuys_der_eisendrache) == 2) //Conn6orsuper117
							ent.var_47896610 = util::spawn_model("wallbuy_fg42", spawn_loc.origin + VectorScale((16, 0, -2), 1), spawn_loc.angles);
						
						break;
					}
				case "zm_island": //Zetsubou no Shima
					ent.var_47896610 = util::spawn_model("wallbuy_fg42", spawn_loc.origin + VectorScale((-16*cos(spawn_loc.angles[1])+1, -16*sin(spawn_loc.angles[1]), -2), 1), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_fg42", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t4_m1897":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_prototype":
					ent.var_47896610 = util::spawn_model("wallbuy_trenchgun", spawn_loc.origin + VectorScale((14, 0, -3), 1), spawn_loc.angles);
					break;
				case "zm_asylum":
					{
						if(trenchgun == 0) //German
							ent.var_47896610 = util::spawn_model("wallbuy_trenchgun", spawn_loc.origin + VectorScale((13, 0, -4), 1), spawn_loc.angles);
						else //American
							ent.var_47896610 = util::spawn_model("wallbuy_trenchgun", spawn_loc.origin + VectorScale((14, 0, -4), 1), spawn_loc.angles);
						
						trenchgun++;
						break;
					}
				case "zm_sumpf":
					ent.var_47896610 = util::spawn_model("wallbuy_trenchgun", spawn_loc.origin + VectorScale((-12, 0, -3), 1), spawn_loc.angles);
					break;
				case "zm_factory":
				case "zm_der_riese":
				case "zm_giant":
					ent.var_47896610 = util::spawn_model("wallbuy_trenchgun", spawn_loc.origin + VectorScale((-1, -15, -4), 1), spawn_loc.angles);
					break;
				case "zm_theater":
					ent.var_47896610 = util::spawn_model("wallbuy_trenchgun", spawn_loc.origin + VectorScale((0, 14, -3), 1), spawn_loc.angles);
					break;
				case "zm_coast":
					ent.var_47896610 = util::spawn_model("wallbuy_trenchgun", spawn_loc.origin + VectorScale((-14*cos(spawn_loc.angles[1]), -14*sin(spawn_loc.angles[1]), -3), 1), spawn_loc.angles);
					break;
				case "zm_tomb": //Origins
					ent.var_47896610 = util::spawn_model("wallbuy_trenchgun", spawn_loc.origin + VectorScale((-14, 0, -3), 1), spawn_loc.angles);
					break;
				case "zm_castle": //Der Eisendrache
					{
						if(!GetGametypeSetting(mutator_wallbuys_der_eisendrache) || GetGametypeSetting(mutator_wallbuys_der_eisendrache) == 1) //poyzee
						{
							if(trenchgun == 0) //Right from spawn 
								ent.var_47896610 = util::spawn_model("wallbuy_trenchgun", spawn_loc.origin + VectorScale((14, 2, -3), 1), spawn_loc.angles);
							else //Left from spawn
								ent.var_47896610 = util::spawn_model("wallbuy_trenchgun", spawn_loc.origin + VectorScale((0, -14, -3), 1), spawn_loc.angles);
								
							trenchgun++;
						}
						else if(GetGametypeSetting(mutator_wallbuys_der_eisendrache) == 2) //Conn6orsuper117
							ent.var_47896610 = util::spawn_model("wallbuy_trenchgun", spawn_loc.origin + VectorScale((-14, 0, -3), 1), spawn_loc.angles);
						
						break;
					}
				case "zm_island": //Zetsubou no Shima
					{
						if(trenchgun == 0)
							ent.var_47896610 = util::spawn_model("wallbuy_trenchgun", spawn_loc.origin + VectorScale((0, 14, -3), 1), spawn_loc.angles);
						else
							ent.var_47896610 = util::spawn_model("wallbuy_trenchgun", spawn_loc.origin + VectorScale((-14, 5, -4), 1), spawn_loc.angles);
						
						trenchgun++;
						break;
					}
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_trenchgun", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t4_db":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_prototype":
					ent.var_47896610 = util::spawn_model("wallbuy_doublebarrel", spawn_loc.origin + VectorScale((0, -13, -4), 1), spawn_loc.angles);
					break;
				case "zm_asylum":
					{
						if(doublebarrel == 0) //German
							ent.var_47896610 = util::spawn_model("wallbuy_doublebarrel", spawn_loc.origin + VectorScale((0, -13, -4), 1), spawn_loc.angles);
						else //American
							ent.var_47896610 = util::spawn_model("wallbuy_doublebarrel", spawn_loc.origin + VectorScale((13, -1, -4), 1), spawn_loc.angles);
						
						doublebarrel++;
						break;
					}
				case "zm_factory":
				case "zm_der_riese":
				case "zm_giant":
					ent.var_47896610 = util::spawn_model("wallbuy_doublebarrel", spawn_loc.origin + VectorScale((1, 12, -4), 1), spawn_loc.angles);
					break;
				case "zm_theater":
					{
						if(!GetGametypeSetting(mutator_wallbuys_kino_der_toten) || GetGametypeSetting(mutator_wallbuys_kino_der_toten) == 1) //Der Riese
							ent.var_47896610 = util::spawn_model("wallbuy_doublebarrel", spawn_loc.origin + VectorScale((12, 1, -4), 1), spawn_loc.angles);
						else if(GetGametypeSetting(mutator_wallbuys_kino_der_toten) == 3 || GetGametypeSetting(mutator_wallbuys_kino_der_toten) == 4) //Black Ops
							ent.var_47896610 = util::spawn_model("wallbuy_doublebarrel", spawn_loc.origin + VectorScale((0, 12, -4), 1), spawn_loc.angles);
						
						break;
					}
				case "zm_coast":
					ent.var_47896610 = util::spawn_model("wallbuy_doublebarrel", spawn_loc.origin + VectorScale((12*cos(spawn_loc.angles[1]), 12*sin(spawn_loc.angles[1]), -4), 1), spawn_loc.angles);
					break;
				case "zm_tomb": //Origins
					{
						if(doublebarrel == 0) //Generator 6
							ent.var_47896610 = util::spawn_model("wallbuy_doublebarrel", spawn_loc.origin + VectorScale((-12, 0, -4), 1), spawn_loc.angles);
						else //Workshop
							ent.var_47896610 = util::spawn_model("wallbuy_doublebarrel", spawn_loc.origin + VectorScale((0, 12, -4), 1), spawn_loc.angles);
						
						doublebarrel++;
						break;
					}
				case "zm_castle": //Der Eisendrache
					{
						if(!GetGametypeSetting(mutator_wallbuys_der_eisendrache) || GetGametypeSetting(mutator_wallbuys_der_eisendrache) == 1) //poyzee
						{
							if(doublebarrel == 0) //Right from Spawn
								ent.var_47896610 = util::spawn_model("wallbuy_doublebarrel", spawn_loc.origin + VectorScale((0, -13, -4), 1), spawn_loc.angles);
							else //Left from spawn
								ent.var_47896610 = util::spawn_model("wallbuy_doublebarrel", spawn_loc.origin + VectorScale((-1, -12, -4), 1), spawn_loc.angles);
							
							doublebarrel++;
						}
						else if(GetGametypeSetting(mutator_wallbuys_der_eisendrache) == 2) //Conn6orsuper117
							ent.var_47896610 = util::spawn_model("wallbuy_doublebarrel", spawn_loc.origin + VectorScale((-1, -12, -4), 1), spawn_loc.angles);
						
						break;
					}
				case "zm_island":
					ent.var_47896610 = util::spawn_model("wallbuy_doublebarrel", spawn_loc.origin + VectorScale((0, -12, -4), 1), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_doublebarrel", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t4_db_saw":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_prototype":
					ent.var_47896610 = util::spawn_model("wallbuy_sawedoff", spawn_loc.origin + VectorScale((0, -13, -4), 1), spawn_loc.angles);
					break;
				case "zm_asylum":
					ent.var_47896610 = util::spawn_model("wallbuy_sawedoff", spawn_loc.origin + VectorScale((14, 0, -5), 1), spawn_loc.angles);
					break;
				case "zm_theater":
					ent.var_47896610 = util::spawn_model("wallbuy_sawedoff", spawn_loc.origin + VectorScale((-14, 0, -5), 1), spawn_loc.angles);
					break;
				case "zm_castle": //Der Eisendrache
					ent.var_47896610 = util::spawn_model("wallbuy_sawedoff", spawn_loc.origin + VectorScale((0, -14, -4), 1), spawn_loc.angles);
					break;
				case "zm_island": //Zetsubou no Shima
					ent.var_47896610 = util::spawn_model("wallbuy_sawedoff", spawn_loc.origin + VectorScale((-14, 0, -4), 1), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_sawedoff", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t5_m14":
			case "t9_m14classic":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_cosmodrome": //Ascension
					ent.var_47896610 = util::spawn_model("wallbuy_m14", spawn_loc.origin + VectorScale((0, -1, 0), 1), spawn_loc.angles);
					break;
				case "zm_der_riese": //Der Riese: Declassified
				case "zm_factory": //The Giant
				case "zm_giant": // TrustInUma's DER RIESE
					ent.var_47896610 = util::spawn_model("wallbuy_m14", spawn_loc.origin + VectorScale((1, 0, 0), 1), spawn_loc.angles);
				case "zm_asylum": // Verrückt
					{
						if(m14 == 0) //M1 Garand
							ent.var_47896610 = util::spawn_model("wallbuy_m14", spawn_loc.origin + VectorScale((1, 0, 0), 1), spawn_loc.angles);
						else //Gewehr 43
							ent.var_47896610 = util::spawn_model("wallbuy_m14", spawn_loc.origin + VectorScale((0, 0, -1), 1), spawn_loc.angles);
						
						m14 = 1;
						break;
					}
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_m14", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t5_olympia":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_theater": //Kino der Toten
				case "zm_cosmodrome": //Ascension
				case "zm_temple": //Shangri-La
				case "zm_moon":
				case "zm_zod": //Shadows of Evil
				case "zm_der_riese": //Der Riese: Declassified
				case "zm_sumpf": //Shi no Numa
				case "zm_prototype": //Nacht der Untoten
				case "zm_factory": //The Giant
				case "zm_giant": // TrustInUma's DER RIESE
				case "zm_tomb": //Origins
					ent.var_47896610 = util::spawn_model("wallbuy_olympia", spawn_loc.origin + VectorScale((0, 0, -1), 1), spawn_loc.angles);
					break;
				case "zm_asylum": //Verrückt
				{
					if(olympia == 0) //Springfield
						ent.var_47896610 = util::spawn_model("wallbuy_olympia", spawn_loc.origin + VectorScale((0, 0, -2), 1), spawn_loc.angles);
					else //Kar98k
						ent.var_47896610 = util::spawn_model("wallbuy_olympia", spawn_loc.origin + VectorScale((1, 0, -2), 1), spawn_loc.angles);
						
					olympia = 1;
					break;
				}
				case "zm_nuked": //Nuketown Zombies
					ent.var_47896610 = util::spawn_model("wallbuy_olympia", spawn_loc.origin + VectorScale((1, 0, -2), 1), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_olympia", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t5_stakeout":
			case "t9_hauer77":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_theater": //Kino der Toten
				case "zm_cosmodrome": //Ascension
				case "zm_moon":
				case "zm_nuked": //Nuketown Zombies
					ent.var_47896610 = util::spawn_model("wallbuy_stakeout", spawn_loc.origin + VectorScale((0, -4, 0), 1), spawn_loc.angles);
					break;
				case "zm_temple": //Shangri-La
					ent.var_47896610 = util::spawn_model("wallbuy_stakeout", spawn_loc.origin + VectorScale((0, 3.5, 0.5), 1), spawn_loc.angles);
					break;
				case "zm_zod": //Shadows of Evil
					{
						if(stakeout == 0) //Junction
							ent.var_47896610 = util::spawn_model("wallbuy_stakeout", spawn_loc.origin + VectorScale((0, 5, 0), 1), spawn_loc.angles);
						else //Nero's Landing
							ent.var_47896610 = util::spawn_model("wallbuy_stakeout", spawn_loc.origin + VectorScale((5, 0, 0), 1), spawn_loc.angles);
						
						stakeout++;
						break;
					}
				case "zm_der_riese": //Der Riese: Declassified
					ent.var_47896610 = util::spawn_model("wallbuy_stakeout", spawn_loc.origin + VectorScale((-1, 2, 0), 1), spawn_loc.angles);
					break;
				case "zm_asylum": //Verrückt
					ent.var_47896610 = util::spawn_model("wallbuy_stakeout", spawn_loc.origin + VectorScale((-3, 0, 0), 1), spawn_loc.angles);
					break;
				case "zm_sumpf": //Shi no Numa
					ent.var_47896610 = util::spawn_model("wallbuy_stakeout", spawn_loc.origin + VectorScale((4, 0, 1), 1), spawn_loc.angles);
					break;
				case "zm_prototype": //Nacht der Untoten
					ent.var_47896610 = util::spawn_model("wallbuy_stakeout", spawn_loc.origin + VectorScale((0, 4, 0), 1), spawn_loc.angles);
					break;
				case "zm_factory": //The Giant
				case "zm_giant": // TrustInUma's DER RIESE
					ent.var_47896610 = util::spawn_model("wallbuy_stakeout", spawn_loc.origin + VectorScale((-1, 3, 1), 1), spawn_loc.angles);
					break;
				case "zm_tomb": //Origins
					if(stakeout == 0) //
					{
						ent.var_47896610 = util::spawn_model("wallbuy_stakeout", spawn_loc.origin + VectorScale((3, 0, 0), 1), spawn_loc.angles);
						stakeout = 1;
					}
					else //Generator Station 6
						ent.var_47896610 = util::spawn_model("wallbuy_stakeout", spawn_loc.origin + VectorScale((4, 0, 1), 1), spawn_loc.angles);
					
					break;
				case "zm_stalingrad": //Gorod Krovi
					ent.var_47896610 = util::spawn_model("wallbuy_stakeout", spawn_loc.origin + VectorScale((-3, 0, 0), 1), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_stakeout", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t5_mp40":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_asylum": //Verrückt
					ent.var_47896610 = util::spawn_model("wallbuy_mp40", spawn_loc.origin + VectorScale((0, 0.5, 0), 1), spawn_loc.angles);
					break;
				case "zm_theater": //Kino der Toten
					ent.var_47896610 = util::spawn_model("wallbuy_mp40", spawn_loc.origin + VectorScale((0, -1, 0), 1), spawn_loc.angles);
					break;
				case "zm_der_riese": //Der Riese: Declassified
					ent.var_47896610 = util::spawn_model("wallbuy_mp40", spawn_loc.origin + VectorScale((1, 1, -1), 1), spawn_loc.angles);
					break;
				case "zm_asylum": //Verrückt
					ent.var_47896610 = util::spawn_model("wallbuy_mp40", spawn_loc.origin + VectorScale((-1, 1, 0), 1), spawn_loc.angles);
					break;
				case "zm_factory": //The Giant
					ent.var_47896610 = util::spawn_model("wallbuy_mp40", spawn_loc.origin + VectorScale((1, 1, 0), 1), spawn_loc.angles);
					break;
				case "zm_giant": //TrustInUma's DER RIESE
					ent.var_47896610 = util::spawn_model("wallbuy_mp40", spawn_loc.origin + VectorScale((0, 1, 0), 1), spawn_loc.angles);
					break;
				case "zm_tomb": //Origins
					{
						if(!GetGametypeSetting(mutator_wallbuys_origins) || GetGametypeSetting(mutator_wallbuys_origins) == 1) //BO Layout 1
						{
							if(mp40 == 0) //Generator Station 4
							{
								ent.var_47896610 = util::spawn_model("wallbuy_mp40", spawn_loc.origin + VectorScale((-1, 0, 0), 1), spawn_loc.angles);
								mp40++;
							}
							else if(mp40 == 1) //No Man's Land
							{
								ent.var_47896610 = util::spawn_model("wallbuy_mp40", spawn_loc.origin + VectorScale((-1*cos(spawn_loc.angles[0]), -1*cos(spawn_loc.angles[0]), 0), 1), spawn_loc.angles);
								mp40++;
							}
							else //Generator Station 2
								ent.var_47896610 = util::spawn_model("wallbuy_mp40", spawn_loc.origin + VectorScale((1, 0, 0), 1), spawn_loc.angles);
						}
						else if(GetGametypeSetting(mutator_wallbuys_origins) == 2) //WaW Layout 1
							ent.var_47896610 = util::spawn_model("wallbuy_mp40", spawn_loc.origin + VectorScale((0, 0, 0), 1), spawn_loc.angles);
							//ent.var_47896610 = util::spawn_model("wallbuy_mp40", spawn_loc.origin + VectorScale((-14*cos(spawn_loc.angles[1]), -14*sin(spawn_loc.angles[1]), -5), 1), spawn_loc.angles);
							
						break;
					}
				case "zm_castle": //Der Eisendrache
					{
						if(mp40 == 0) //Living Quarters
							ent.var_47896610 = util::spawn_model("wallbuy_mp40", spawn_loc.origin + VectorScale((0, 1, 0), 1), spawn_loc.angles);
						else //Power door from spawn
							ent.var_47896610 = util::spawn_model("wallbuy_mp40", spawn_loc.origin + VectorScale((1, 0, 0), 1), spawn_loc.angles);
						
						mp40++;
						break;
					}
				case "zm_island": //Zetsubou no Shima
					{
						if(mp40 == 0)  //Outside Laboratory A
							ent.var_47896610 = util::spawn_model("wallbuy_mp40", spawn_loc.origin + VectorScale((-1, -1, 0), 1), spawn_loc.angles);
						else //Bunker
							ent.var_47896610 = util::spawn_model("wallbuy_mp40", spawn_loc.origin + VectorScale((1, 0, 0), 1), spawn_loc.angles);
				
						mp40++;
						break;
					}
				case "zm_stalingrad":
					ent.var_47896610 = util::spawn_model("wallbuy_mp40", spawn_loc.origin + VectorScale((1, 0, 0), 1), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_mp40", spawn_loc.origin + VectorScale((0, 0, 0), 1), spawn_loc.angles);
					break;
				}
				break;
			}
			case "t5_mpl":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_theater": //Kino der Toten
				case "zm_cosmodrome": //Ascension
					ent.var_47896610 = util::spawn_model("wallbuy_mpl", spawn_loc.origin + VectorScale((1, -1, 0), 1), spawn_loc.angles);
					break;
				case "zm_temple": //Shangri-La
					ent.var_47896610 = util::spawn_model("wallbuy_mpl", spawn_loc.origin + VectorScale((0, 0, 0), 1), spawn_loc.angles);
					break;
				case "zm_moon":
					ent.var_47896610 = util::spawn_model("wallbuy_mpl", spawn_loc.origin + VectorScale((0, -1, 0), 1), spawn_loc.angles);
					break;
				case "zm_der_riese": //Der Riese: Declassified
					ent.var_47896610 = util::spawn_model("wallbuy_mpl", spawn_loc.origin + VectorScale((1, 0, -1), 1), spawn_loc.angles);
					break;
				case "zm_asylum": //Verrückt
					ent.var_47896610 = util::spawn_model("wallbuy_mpl", spawn_loc.origin + VectorScale((0, -1, -1), 1), spawn_loc.angles);
					break;
				case "zm_factory": //The Giant
				case "zm_giant": // TrustInUma's DER RIESE
					ent.var_47896610 = util::spawn_model("wallbuy_mpl", spawn_loc.origin + VectorScale((1, 1, 0), 1), spawn_loc.angles);
					break;
				case "zm_stalingrad": //Gorod Krovi
					ent.var_47896610 = util::spawn_model("wallbuy_mpl", spawn_loc.origin + VectorScale((1*cos(spawn_loc.angles[1]), 1*sin(spawn_loc.angles[1]), 0), 1), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_mpl", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t5_pm63":
			case "t9_amp63":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_theater": //Kino der Toten
					ent.var_47896610 = util::spawn_model("wallbuy_pm63", spawn_loc.origin + VectorScale((5, -0.75, 0.75), 1), spawn_loc.angles);
					break;
				case "zm_cosmodrome": //Ascension
					ent.var_47896610 = util::spawn_model("wallbuy_pm63", spawn_loc.origin + VectorScale((-6, 0.75, 0.75), 1), spawn_loc.angles);
					break;
				case "zm_temple": //Shangri-La
					ent.var_47896610 = util::spawn_model("wallbuy_pm63", spawn_loc.origin + VectorScale((6, -1, 0.5), 1), spawn_loc.angles);
					break;
				case "zm_moon":
					ent.var_47896610 = util::spawn_model("wallbuy_pm63", spawn_loc.origin + VectorScale((5, 0, 0), 1), spawn_loc.angles);
					break;
				case "zm_zod": //Shadows of Evil
					{
						if(pm63 == 0)
						{
							ent.var_47896610 = util::spawn_model("wallbuy_pm63", spawn_loc.origin + VectorScale((5*cos(spawn_loc.angles[0]), 5*cos(spawn_loc.angles[1]), 5*sin(spawn_loc.angles[0])), 1), spawn_loc.angles);
							pm63 = 1;
						}
						else
							ent.var_47896610 = util::spawn_model("wallbuy_pm63", spawn_loc.origin + VectorScale((-6*cos(spawn_loc.angles[1]), -6*sin(spawn_loc.angles[1]), 0), 1), spawn_loc.angles);
						break;
					}
				case "zm_der_riese": //Der Riese: Declassified
				case "zm_factory": //The Giant
				case "zm_giant": // TrustInUma's DER RIESE
					ent.var_47896610 = util::spawn_model("wallbuy_pm63", spawn_loc.origin + VectorScale((-5, 1, 1), 1), spawn_loc.angles);
					break;
				case "zm_asylum": //Verrückt
					ent.var_47896610 = util::spawn_model("wallbuy_pm63", spawn_loc.origin + VectorScale((0, -5, 1), 1), spawn_loc.angles);
					break;
				case "zm_sumpf": //Shi no Numa 
				case "zm_prototype": //Nacht der Untoten
					ent.var_47896610 = util::spawn_model("wallbuy_pm63", spawn_loc.origin + VectorScale((5, 0, 0), 1), spawn_loc.angles);
					break;
				case "zm_stalingrad": //Gorod Krovi
					ent.var_47896610 = util::spawn_model("wallbuy_pm63", spawn_loc.origin + VectorScale((5*cos(spawn_loc.angles[0]), 5*cos(spawn_loc.angles[1]), 5*sin(spawn_loc.angles[0])), 1), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_pm63", spawn_loc.origin, spawn_loc.angles);
					break;
				}				
				break;
			}
			case "t5_ak74u":
			case "t9_ak74u":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_theater": //Kino der Toten
					ent.var_47896610 = util::spawn_model("wallbuy_ak74u", spawn_loc.origin + VectorScale((0, -2, 0), 1), spawn_loc.angles);
					break;
				case "zm_cosmodrome": //Ascension
					ent.var_47896610 = util::spawn_model("wallbuy_ak74u", spawn_loc.origin + VectorScale((0, -1.5, -0.5), 1), spawn_loc.angles);
					break;
				case "zm_temple": //Shangri-La
					ent.var_47896610 = util::spawn_model("wallbuy_ak74u", spawn_loc.origin + VectorScale((0, 1, 0), 1), spawn_loc.angles);
					break;
				case "zm_moon":
					ent.var_47896610 = util::spawn_model("wallbuy_ak74u", spawn_loc.origin, spawn_loc.angles);
					break;
				case "zm_zod": //Shadows of Evil
					switch(ak74u)
					{
					case 0: //Footlight District
						{
							ent.var_47896610 = util::spawn_model("wallbuy_ak74u", spawn_loc.origin + VectorScale((-1*cos(spawn_loc.angles[1]), -1*sin(spawn_loc.angles[1]), 0), 1), spawn_loc.angles);
							ak74u++;
							break;
						}
					case 1: //Canal District
						{
							ent.var_47896610 = util::spawn_model("wallbuy_ak74u", spawn_loc.origin + VectorScale((0, 1, 0), 1), spawn_loc.angles);
							ak74u++;
							break;
						}
					case 2: //Waterfront High Street
						{
							ent.var_47896610 = util::spawn_model("wallbuy_ak74u", spawn_loc.origin + VectorScale((1*cos(spawn_loc.angles[1]), 1*sin(spawn_loc.angles[1]), 0), 1), spawn_loc.angles);
							ak74u++;
							break;
						}
					}
					break;
				case "zm_der_riese": //Der Riese: Declassified
				case "zm_factory": //The Giant
				case "zm_giant": // TrustInUma's DER RIESE
					ent.var_47896610 = util::spawn_model("wallbuy_ak74u", spawn_loc.origin + VectorScale((-1, 1, 0), 1), spawn_loc.angles);
					break;
				case "zm_asylum": //Verrückt
					ent.var_47896610 = util::spawn_model("wallbuy_ak74u", spawn_loc.origin + VectorScale((-1, -1, 0), 1), spawn_loc.angles);
					break;
				case "zm_sumpf": //Shi no Numa
					ent.var_47896610 = util::spawn_model("wallbuy_ak74u", spawn_loc.origin + VectorScale((-6, -1, 0), 1), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_ak74u", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t5_mp5k":
			case "t9_mp5k":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_theater": //Kino der Toten
				case "zm_moon":
					ent.var_47896610 = util::spawn_model("wallbuy_mp5k", spawn_loc.origin + VectorScale((0, 0.5, 1.1), 1), spawn_loc.angles);
					break;
				case "zm_cosmodrome": //Ascension
					ent.var_47896610 = util::spawn_model("wallbuy_mp5k", spawn_loc.origin + VectorScale((0, -0.5, 1.1), 1), spawn_loc.angles);
					break;
				case "zm_temple": //Shangri-La
					ent.var_47896610 = util::spawn_model("wallbuy_mp5k", spawn_loc.origin + VectorScale((-0.5 , 0.5, 1.1), 1), spawn_loc.angles);
					break;
				case "zm_der_riese": //Der Riese: Declassified
				case "zm_giant": // TrustInUma's DER RIESE
					ent.var_47896610 = util::spawn_model("wallbuy_mp5k", spawn_loc.origin + VectorScale((0, -2, 0), 1), spawn_loc.angles);
					break;
				case "zm_factory": //The Giant
					ent.var_47896610 = util::spawn_model("wallbuy_mp5k", spawn_loc.origin + VectorScale((0, -1, 0), 1), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_mp5k", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t5_m16a1":
			case "t9_m16":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_theater": //Kino der Toten
					ent.var_47896610 = util::spawn_model("wallbuy_m16a1", spawn_loc.origin + VectorScale((-2.5, -1, 1.2), 1), spawn_loc.angles);
					break;
				case "zm_cosmodrome": //Ascension
					ent.var_47896610 = util::spawn_model("wallbuy_m16a1", spawn_loc.origin + VectorScale((1, 3, 1.2), 1), spawn_loc.angles);
					break;
				case "zm_temple": //Shangri-La
					ent.var_47896610 = util::spawn_model("wallbuy_m16a1", spawn_loc.origin + VectorScale((0.5, 2.6, 0.5), 1), spawn_loc.angles);
					break;
				case "zm_moon":
					ent.var_47896610 = util::spawn_model("wallbuy_m16a1", spawn_loc.origin + VectorScale((-2, -1, 2), 1), spawn_loc.angles);
					break;
				case "zm_zod": //Shadows of Evil
					{
						switch(m16)
						{
						case 0: //Waterfront District
							{
								ent.var_47896610 = util::spawn_model("wallbuy_m16a1", spawn_loc.origin + VectorScale((-3*cos(spawn_loc.angles[1]), -3*sin(spawn_loc.angles[1]), 0), 1), spawn_loc.angles);
								m16++;
								break;
							}
						case 1: //Footlight District
						case 2: //Canal District
							{
								ent.var_47896610 = util::spawn_model("wallbuy_m16a1", spawn_loc.origin + VectorScale((-3*cos(spawn_loc.angles[1]), -3*sin(spawn_loc.angles[1]), 1), 1), spawn_loc.angles);
								m16++;
								break;
							}
						}	
						break;
					}
				case "zm_der_riese": //Der Riese: Declassified
				case "zm_factory": //The Giant
				case "zm_giant": // TrustInUma's DER RIESE
					ent.var_47896610 = util::spawn_model("wallbuy_m16a1", spawn_loc.origin + VectorScale((-1, -3, 1), 1), spawn_loc.angles);
					break;
				case "zm_asylum": //Verrückt
					ent.var_47896610 = util::spawn_model("wallbuy_m16a1", spawn_loc.origin + VectorScale((3, 0, 1), 1), spawn_loc.angles);
					break;
				case "zm_sumpf": //Shi no Numa
					ent.var_47896610 = util::spawn_model("wallbuy_m16a1", spawn_loc.origin + VectorScale((-2*cos(spawn_loc.angles[1]), -2*sin(spawn_loc.angles[1]), 1), 1), spawn_loc.angles);
					break;
				case "zm_prototype": //Nacht der Untoten
				case "zm_tomb": //Origins
				case "zm_stalingrad": //Gorod Krovi
					ent.var_47896610 = util::spawn_model("wallbuy_m16a1", spawn_loc.origin + VectorScale((0, 3, 1), 1), spawn_loc.angles);
					break;
				case "zm_nuked": //Nuketown Zombies
					ent.var_47896610 = util::spawn_model("wallbuy_m16a1", spawn_loc.origin + VectorScale((-2.5, 0, 1.2), 1), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_m16a1", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t5_aug":
			//case "t9_aug":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch(GetDvarString("mapname"))
				{
				case "zm_theater": //Kino der Toten
					ent.var_47896610 = util::spawn_model("wallbuy_aug", spawn_loc.origin + VectorScale((8, 0, 0), 1), spawn_loc.angles);
					break;
				case "zm_der_riese": //Der Riese: Declassified
				case "zm_giant": // TrustInUma's DER RIESE
					ent.var_47896610 = util::spawn_model("wallbuy_aug", spawn_loc.origin + VectorScale((-11, 1, 0), 1), spawn_loc.angles);
					break;
				case "zm_factory": //The Giant
					ent.var_47896610 = util::spawn_model("wallbuy_aug", spawn_loc.origin + VectorScale((-9, 1, 0), 1), spawn_loc.angles);
					break;
				case "zm_tomb": //Origins
					ent.var_47896610 = util::spawn_model("wallbuy_aug", spawn_loc.origin + VectorScale((-1, 9, 0), 1), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_aug", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "s2_fg42":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				ent.var_47896610 = util::spawn_model("wallbuy_s2_fg42", spawn_loc.origin + VectorScale((-5, 1, 1), 1), spawn_loc.angles);
				break;
			}
			case "s2_gewehr43":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				ent.var_47896610 = util::spawn_model("wallbuy_s2_gewehr43", spawn_loc.origin + VectorScale((1, 2, 0), 1), spawn_loc.angles);
				break;
			}
			case "s2_kar98k_irons":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				ent.var_47896610 = util::spawn_model("wallbuy_s2_kar98k", spawn_loc.origin + VectorScale((1, 2, 0), 1), spawn_loc.angles);
				break;
			}
			case "s2_m1a1carbine":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				ent.var_47896610 = util::spawn_model("wallbuy_s2_m1a1carbine", spawn_loc.origin + VectorScale((-4, 1, -1), 1), spawn_loc.angles);
				break;
			}
			case "s2_m30":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				ent.var_47896610 = util::spawn_model("wallbuy_s2_m30", spawn_loc.origin + VectorScale((1, 1, -2), 1), spawn_loc.angles);
				break;
			}
			case "s2_type100":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				ent.var_47896610 = util::spawn_model("wallbuy_s2_type100", spawn_loc.origin + VectorScale((2, -1, 0), 1), spawn_loc.angles);
				break;
			}
			case "t8_m1897":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				ent.var_47896610 = util::spawn_model("wallbuy_t8_m1897", spawn_loc.origin + VectorScale((-1, -2, -1), 1), spawn_loc.angles);
				break;
			}
			case "s2_mp40":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				ent.var_47896610 = util::spawn_model("wallbuy_s2_mp40", spawn_loc.origin + VectorScale((1, 7, -2), 1), spawn_loc.angles);
				break;
			}
			case "s2_stg44":
			case "ar_stg44":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch(GetDvarString("mapname"))
				{
				case "zm_der_riese": //Der Riese: Declassified
					ent.var_47896610 = util::spawn_model("wallbuy_s2_stg44", spawn_loc.origin + VectorScale((-1, -9, -1), 1), spawn_loc.angles);
					break;
				case "zm_tomb": //Origins
					{
						if(stg44 == 0) //Church
						{
							ent.var_47896610 = util::spawn_model("wallbuy_s2_stg44", spawn_loc.origin + VectorScale((2, 10, -2), 1), spawn_loc.angles);
							stg44 = 1;
						}
						else //The Crazy Place
							ent.var_47896610 = util::spawn_model("wallbuy_s2_stg44", spawn_loc.origin + VectorScale((10, 0, -2), 1), spawn_loc.angles);
						
						break;
					}
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_s2_stg44", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "s2_thompsonm1a1":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				ent.var_47896610 = util::spawn_model("wallbuy_s2_m1a1thompson", spawn_loc.origin + VectorScale((-12, 1, -2), 1), spawn_loc.angles);
				break;
			}
			case "s2_sten":
			{
				if(GetDvarString("mapname") == "zm_asylum")
				{
					if(sten == 1) //Upstairs BAR
					{
						spawn_loc = struct::get(ent.target, "targetname");
						ent.var_47896610 = util::spawn_model("wallbuy_t7_sten", spawn_loc.origin + VectorScale((0, 4, -1), 1), spawn_loc.angles);
					}
					sten = 1;
				}
				else
				{
					spawn_loc = struct::get(ent.target, "targetname");
					ent.var_47896610 = util::spawn_model("wallbuy_t7_sten", spawn_loc.origin + VectorScale((-6*cos(spawn_loc.angles[1]), -6*sin(spawn_loc.angles[1]), -1), 1), spawn_loc.angles);
					ent.var_47896610 = util::spawn_model("wallbuy_t7_sten", spawn_loc.origin + VectorScale((-6*cos(spawn_loc.angles[1]), -6*sin(spawn_loc.angles[1]), -1), 1), spawn_loc.angles);
				}
				break;
			}
			case "t5_l96a1":
			case "t5_l96a1_overlay":
			case "t5_l96a1_switch":
			case "t9_lw3_tundra":
			case "t9_lw3_tundra_overlay":
			case "t9_lw3_tundra_switch":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				ent.var_47896610 = util::spawn_model("wallbuy_l115", spawn_loc.origin + VectorScale((0, 1, -2), 1), spawn_loc.angles);
				break;
			}
			case "smg_thompson":
			{
				//only Origins for now
				spawn_loc = struct::get(ent.target, "targetname");
				ent.var_47896610 = util::spawn_model("wallbuy_t7_m1927", spawn_loc.origin + VectorScale((9, 0, -1), 1), spawn_loc.angles);
				break;
			}
		}
	} }
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
		case "zm_nuked":
		case "zm_zod":
		case "zm_castle":
		case "zm_island":
			{
				claymore = Spawn("trigger_radius_use", spawn_loc.origin, 0, 84, 72);
				claymore.targetname = "claymore_trigger";
				claymore zm_unitrigger::create_unitrigger( "Hold ^3&&1^7 to buy Claymores [Cost: 1000]" , 20, &visibility_and_update_prompt);
				break;
			}
		case "zm_sumpf": //Shi no Numa
		case "zm_factory": //The Giant
			{
				if(GetGametypeSetting(mutator_waw_wall_weapons) == 2)
				{
					claymore = Spawn("trigger_radius_use", spawn_loc.origin, 0, 84, 72);
					claymore.targetname = "claymore_trigger";
					claymore zm_unitrigger::create_unitrigger( "Hold ^3&&1^7 to buy Claymores [Cost: 1000]" , 20, &visibility_and_update_prompt);
				}
				else
					betty = ent;
				
				break;
			}
		case "zm_asylum": //Verrückt
			{
				if(GetGametypeSetting(mutator_waw_wall_weapons) == 2)
				{
					if(count == 1) //American side
					{
						claymore = Spawn("trigger_radius_use", spawn_loc.origin, 0, 84, 72);
						claymore.targetname = "claymore_trigger";
						claymore zm_unitrigger::create_unitrigger( "Hold ^3&&1^7 to buy Claymores [Cost: 1000]" , 20, &visibility_and_update_prompt);
					}
					else
						betty = ent;
					
					count = 1;
				}
				else
					betty = ent;
				
				break;
			}
		}
		if(isdefined(claymore))
			claymore.var_47896610 = util::spawn_model("wallbuy_claymore", spawn_loc.origin + VectorScale((0, -0.5, 0), 1), spawn_loc.angles);
		else if(isdefined(betty))
			betty.var_47896610 = util::spawn_model("wallbuy_bouncingbetty", spawn_loc.origin + VectorScale((-7*cos(spawn_loc.angles[1]), -7*sin(spawn_loc.angles[1]), 0), 1), spawn_loc.angles);
	}
	if(GetDvarString("mapname") == "zm_stalingrad")
	{
		foreach(ent in struct::get_array("weapon_upgrade", "targetname"))
		{
			if(ent.zombie_weapon_upgrade != "ar_accurate")
				continue;
				
			claymore = Spawn("trigger_radius_use", ent.origin + VectorScale((-30, -30, 0), 1), 0, 84, 72);
			claymore.targetname = "claymore_trigger";
			claymore zm_unitrigger::create_unitrigger( "Hold ^3&&1^7 to buy Claymores [Cost: 1000]" , 20, &visibility_and_update_prompt);
			
			claymore.var_47896610 = util::spawn_model("wallbuy_claymore", ent.origin, ent.angles);
						
			ent struct::delete();
			break;
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