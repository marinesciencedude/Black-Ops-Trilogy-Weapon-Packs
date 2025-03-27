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
	
	starting_weapon = GetWeapon("t4_m1911");
	starting_weapon_pap = GetWeapon("t4_m1911_up");
		
	level.start_weapon = starting_weapon;
	level.default_laststandpistol = starting_weapon;
	level.default_solo_laststandpistol = starting_weapon_pap;
	thread zm::last_stand_pistol_rank_init();
	starter_weapon_extra();
	
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
	
	starting_weapon = GetWeapon("t4_m1911");
	starting_weapon_pap = GetWeapon("t4_m1911_up");
	
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
	level.pack_a_punch_camo_index = 141;
	/*foreach(player in GetPlayers())
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
	rk5 = 0;
	vesper = 0;
	kuda = 0;
	m8a7 = 0;
	krm262 = 0;
	argus = 0;
	sheiva = 0;
	foreach(ent in struct::get_array("weapon_upgrade", "targetname"))
	{
		VAL = ent.zombie_weapon_upgrade;
		if(!isdefined(VAL))
		{
			continue;
		}
		
		if(VAL == "smg_mp40_1940" || VAL == "s2_mp40" )
			ent.zombie_weapon_upgrade = "t4_mp40";
		
		switch( GetDvarString("mapname") )
		{
		case "zm_prototype": //Nacht der Untoten
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
				break;
			}
		case "zm_asylum": //Verrückt
			{
				switch(VAL)
				{
				case "ar_marksman": //Sheiva
					{
						if(sheiva == 0)
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
				break;
			}
		case "zm_sumpf": //Shi no Numa
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
						ent.zombie_weapon_upgrade = "t4_bar";
					
						ent.origin += (9*cos(spawn_loc.angles[1]), 9*sin(spawn_loc.angles[1]), 4);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (9*cos(spawn_loc.angles[1]), 9*sin(spawn_loc.angles[1]), 4);
						break;
					}
				case "ar_standard": //KN-44
					ent.zombie_weapon_upgrade = "t4_type100";
					break;
				case "shotgun_precision": //Argus
				case "smg_standard": //Kuda
				case "smg_versatile": //VMP
				case "ar_cqb": //HVK-30
				case "ar_accurate": //ICR-1
					ent struct::delete();
					break;
				}
				break;
			}
		case "zm_factory": //The Giant
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
						ent.zombie_weapon_upgrade = "t4_mp40";
						ent.origin += (4, 0, 0);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (4, 0, 0);
						break;
					}
				case "ar_cqb": //HVK-30
					ent.zombie_weapon_upgrade = "t4_type100";
					break;
				case "ar_standard": //KN-44
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
		}
		
		if(isdefined(ent.target) && isdefined(VAL))
		{
			struct::get(ent.target, "targetname").model = GetWeapon(ent.zombie_weapon_upgrade).worldmodel;
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
			case "t4_kar98k":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_prototype":
				case "zm_factory":
				case "zm_der_riese":																	// ↔   ↔  ↕
					ent.var_47896610 = util::spawn_model("wallbuy_kar98k", spawn_loc.origin + VectorScale((0, 13, -3), 1), spawn_loc.angles);
					break;
				case "zm_asylum":
					ent.var_47896610 = util::spawn_model("wallbuy_kar98k", spawn_loc.origin + VectorScale((1, 14, -4), 1), spawn_loc.angles);
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
				ent.var_47896610 = util::spawn_model("wm_kar98k_scope", spawn_loc.origin + VectorScale((1, -4, 0), 1), spawn_loc.angles);
				ent.var_47896611 = util::spawn_model("wm_kar98k_scope", spawn_loc.origin + VectorScale((0, 2, 0), 1), (-spawn_loc.angles[0],spawn_loc.angles[1],spawn_loc.angles[2]));
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
					ent.var_47896610 = util::spawn_model("wallbuy_gewehr43", spawn_loc.origin + VectorScale((1, 13, -2), 1), spawn_loc.angles);
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
					ent.var_47896610 = util::spawn_model("wallbuy_stg44", spawn_loc.origin + VectorScale((-1, -20, -4), 1), spawn_loc.angles);
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
					ent.var_47896610 = util::spawn_model("wallbuy_m1carbine", spawn_loc.origin + VectorScale((16, 0, -4), 1), spawn_loc.angles);
					break;
				case "zm_factory":
				case "zm_der_riese":
					ent.var_47896610 = util::spawn_model("wallbuy_m1carbine", spawn_loc.origin + VectorScale((-16, 1, -4), 1), spawn_loc.angles);
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
					ent.var_47896610 = util::spawn_model("wallbuy_type100", spawn_loc.origin + VectorScale((14, -1, -4), 1), spawn_loc.angles);
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
					ent.var_47896610 = util::spawn_model("wallbuy_thompson", spawn_loc.origin + VectorScale((-1, -19, -4), 1), spawn_loc.angles);
					break;
				case "zm_factory":
				case "zm_der_riese":
					ent.var_47896610 = util::spawn_model("wallbuy_thompson", spawn_loc.origin + VectorScale((-19, 1, -4), 1), spawn_loc.angles);
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
					ent.var_47896610 = util::spawn_model("wallbuy_fg42", spawn_loc.origin + VectorScale((-15, 1, -2), 1), spawn_loc.angles);
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
					ent.var_47896610 = util::spawn_model("wallbuy_trenchgun", spawn_loc.origin + VectorScale((-1, -15, -4), 1), spawn_loc.angles);
					break;
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
					ent.var_47896610 = util::spawn_model("wallbuy_doublebarrel", spawn_loc.origin + VectorScale((1, 12, -4), 1), spawn_loc.angles);
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
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_sawedoff", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t4_mp40":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_asylum": //Verrückt
					ent.var_47896610 = util::spawn_model("wallbuy_mp40_waw", spawn_loc.origin + VectorScale((-14, 0.5, -4), 1), spawn_loc.angles);
					break;
				case "zm_sumpf":
					ent.var_47896610 = util::spawn_model("wallbuy_mp40_waw", spawn_loc.origin + VectorScale((-14*cos(spawn_loc.angles[1]), -14*sin(spawn_loc.angles[1]), -4), 1), spawn_loc.angles);
					break;
				case "zm_factory": //The Giant
					ent.var_47896610 = util::spawn_model("wallbuy_mp40_waw", spawn_loc.origin + VectorScale((1, 14, -4), 1), spawn_loc.angles);
					break;
				case "zm_der_riese": //Der Riese: Declassified
					ent.var_47896610 = util::spawn_model("wallbuy_mp40_waw", spawn_loc.origin + VectorScale((1, 14, -4), 1), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_mp40", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
		}
	}
}

function visibility_and_update_prompt( player )
{
    if(isdefined(self.hint_string))
    {
        self SetHintString( self.hint_string );
    }
    return true;
}