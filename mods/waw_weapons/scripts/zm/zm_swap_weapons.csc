#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;

#namespace zm_swap_weapons;

/*
	Name: __init__sytem__
	Namespace: namespace_934d772b
	Checksum: 0x2BB7BA7F
	Offset: 0x250
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
	Offset: 0x298
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
	Checksum: 0x9ACF73B8
	Offset: 0x2A8
	Size: 0x3
	Parameters: 0
	Flags: None
*/
function main()
{
}

/*
	Name: function_5d00cefc
	Namespace: namespace_934d772b
	Checksum: 0xB18D26BB
	Offset: 0x2B8
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

