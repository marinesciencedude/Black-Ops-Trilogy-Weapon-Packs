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
	level.zombie_powerup_weapon["minigun"] = GetWeapon("t6_minigun");
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
				if(GetDvarInt("mutator_waw_wall_weapons") == 1 || !GetDvarInt("mutator_waw_wall_weapons"))
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
							/*switch(GetDvarInt("mutator_scopeads"))
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
				else if(GetDvarInt("mutator_waw_wall_weapons") == 2)
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
								switch(GetDvarInt("mutator_scopeads"))
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
								switch(GetDvarInt("mutator_scopeads"))
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
				if(GetDvarInt("mutator_waw_wall_weapons") == 1 || !GetDvarInt("mutator_waw_wall_weapons"))
				{
					switch(VAL)
					{
					case "ar_marksman": //Sheiva
						{
							if(sheiva == 0 && GetDvarInt("mutator_verruckt_springfield") == 2)
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
				else if(GetDvarInt("mutator_waw_wall_weapons") == 2)
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
				if(GetDvarInt("mutator_waw_wall_weapons") == 1 || !GetDvarInt("mutator_waw_wall_weapons"))
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
				else if(GetDvarInt("mutator_waw_wall_weapons") == 2)
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
				if(GetDvarInt("mutator_waw_wall_weapons") == 1 || !GetDvarInt("mutator_waw_wall_weapons"))
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
				else if(GetDvarInt("mutator_waw_wall_weapons") == 2)
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
				if(GetDvarInt("mutator_waw_wall_weapons") != 2 || !GetDvarInt("mutator_waw_wall_weapons"))
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
				else if(GetDvarInt("mutator_waw_wall_weapons") == 2)
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
				if(GetDvarInt("mutator_waw_wall_weapons") == 1 || !GetDvarInt("mutator_waw_wall_weapons"))
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
				else if(GetDvarInt("mutator_waw_wall_weapons") == 2)
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
				if(!GetDvarInt("mutator_wallbuys_origins") || GetDvarInt("mutator_wallbuys_origins") == 1)
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
				else if(GetDvarInt("mutator_wallbuys_origins") == 2)
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
				if(!GetDvarInt("mutator_wallbuys_der_eisendrache") || GetDvarInt("mutator_wallbuys_der_eisendrache") == 1) //poyzee
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
				else if(GetDvarInt("mutator_wallbuys_der_eisendrache") == 2) //Conn6orsuper117	
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
									/*switch(GetDvarInt("mutator_scopeads"))
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
		}
		
		if(ent.zombie_weapon_upgrade == "sticky_grenade_custom" && GetDvarInt("mutator_grenade_wallbuy") == 2)
			ent.zombie_weapon_upgrade = "frag_grenade";
		else if(ent.zombie_weapon_upgrade == "frag_grenade" && GetDvarInt("mutator_grenade_wallbuy") == 3)
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

	if(GetDvarInt("mutator_claymore") == 1)
	{
		count = 0;
		foreach(ent in struct::get_array("claymore_purchase", "targetname"))
		{
			VAL = ent.zombie_weapon_upgrade;
			if(!isdefined(VAL))
			{
				continue;
			}
			if(GetDvarString("mapname") != "zm_asylum" || GetDvarString("mapname") != "zm_asylum" && count != 0) //Don't delete German side
				ent struct::delete();
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
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_olympia_bo2", spawn_loc.origin, spawn_loc.angles);
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
					ent.var_47896610 = util::spawn_model("wallbuy_b23r", spawn_loc.origin + VectorScale((2, 0, 0), 1), spawn_loc.angles);
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
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_pdw57", spawn_loc.origin, spawn_loc.angles);
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
				//case "zm_theater":
				//	ent.var_47896610 = util::spawn_model("wallbuy_mp40_bo2", spawn_loc.origin + VectorScale((0, 0, 0), 1), spawn_loc.angles);
				//	break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_mp40_bo2", spawn_loc.origin, spawn_loc.angles);
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
			else
				claymore.var_47896610 = util::spawn_model("wallbuy_claymore", spawn_loc.origin + VectorScale((0, -0.5, 0), 1), spawn_loc.angles);
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