#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;

#insert scripts\zm\_zm_mutators.gsh;

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
	thread starter_weapon();
}

function starter_weapon()
{
	wait(1);
	
	//Treyarch Troll
	if(GetDvarString("mapname") == "zm_alcatraz_island" || GetDvarString("mapname") == "zm_prison")
		AddZombieBoxWeapon(GetWeapon("t6_m1911"), GetWeapon("t6_m1911").worldModel, false);
	
	if(GetDvarString("mapname") == "zm_town"
		 || GetDvarString("mapname") == "zm_farm_hd"
		 || GetDvarString("mapname") == "zm_town_hd"
		 || GetDvarString("mapname") == "zm_diner")
	{
		if(GetDvarString("mapname") == "zm_town")
		{
			//remove other weapons in zm_t6_weapons.csv from mystery box
			RemoveZombieBoxWeapon(GetWeapon("t6_pdw57"));
			RemoveZombieBoxWeapon(GetWeapon("t6_ak47"));
			RemoveZombieBoxWeapon(GetWeapon("t6_lsat"));
			RemoveZombieBoxWeapon(GetWeapon("t6_death_machine"));
			if(GetGametypeSetting(mutator_town_pdw57) == BOOLMUTATOR_OFFON_ON)
			{
				zm_weapons::include_weapon( "t6_pdw57", false, 1200 );
				zm_weapons::include_upgraded_weapon( "t6_pdw57", "t6_pdw57_up", false, 1200 );
			}
		}
		else
		{
			//for Town Reimagined these are in zm_t6_weapons.csv
			zm_weapons::include_weapon( "t6_fiveseven_rdw", true, 1100 );
			zm_weapons::include_upgraded_weapon( "t6_fiveseven_rdw", "t6_fiveseven_rdw_up", false, 1100 );
			
			zm_weapons::include_weapon( "t6_fal", true, 600 );
			zm_weapons::include_upgraded_weapon( "t6_fal", "t6_fal_up", false, 600 );
			
			zm_weapons::include_weapon( "t6_mtar", true, 1300 );
			zm_weapons::include_upgraded_weapon( "t6_mtar", "t6_mtar_up", false, 1300 );
			
			zm_weapons::include_weapon( "t6_galil", true, 1400 );
			zm_weapons::include_upgraded_weapon( "t6_galil", "t6_galil_up", false, 1400 );
			
			zm_weapons::include_weapon( "t6_s12", true, 1250 );
			zm_weapons::include_upgraded_weapon( "t6_s12", "t6_s12_up", false, 1250 );
			
			zm_weapons::include_weapon( "t6_m82a1", true, 2000 );
			zm_weapons::include_upgraded_weapon( "t6_m82a1", "t6_m82a1_up", false, 2000 );
			
			zm_weapons::include_weapon( "t6_dsr50", true, 2000 );
			zm_weapons::include_upgraded_weapon( "t6_dsr50", "t6_dsr50_up", false, 2000 );
			
			zm_weapons::include_weapon( "t6_rpg", true, 3000 );
			zm_weapons::include_upgraded_weapon( "t6_rpg", "t6_rpg_up", false, 3000 );
		}
		
		zm_weapons::include_weapon( "t6_fiveseven", true, 900 );
		zm_weapons::include_upgraded_weapon( "t6_fiveseven", "t6_fiveseven_up", false, 900 );
		
		zm_weapons::include_weapon( "t6_kap40", true, 900 );
		zm_weapons::include_upgraded_weapon( "t6_kap40", "t6_kap40_rdw_up", false, 900 );
		
		zm_weapons::include_weapon( "t6_python", true, 1000 );
		zm_weapons::include_upgraded_weapon( "t6_python", "t6_python_up", false, 1000 );
		
		zm_weapons::include_weapon( "t6_chicom_cqb", true, 1000 );
		zm_weapons::include_upgraded_weapon( "t6_chicom_cqb", "t6_chicom_cqb_up", false, 1000 );
		
		zm_weapons::include_weapon( "t6_smr", true, 600 );
		zm_weapons::include_upgraded_weapon( "t6_smr", "t6_smr_up", false, 600 );
		
		zm_weapons::include_weapon( "t6_m8a1", true, 1250 );
		zm_weapons::include_upgraded_weapon( "t6_m8a1", "t6_m8a1_up", false, 1250 );
		
		zm_weapons::include_weapon( "t6_type25", true, 1200 );
		zm_weapons::include_upgraded_weapon( "t6_type25", "t6_type25_up", false, 1200 );
		
		zm_weapons::include_weapon( "t6_m1216", true, 1300 );
		zm_weapons::include_upgraded_weapon( "t6_m1216", "t6_m1216_up", false, 1300 );
		
		zm_weapons::include_weapon( "t6_hamr", true, 2500 );
		zm_weapons::include_upgraded_weapon( "t6_hamr", "t6_hamr_up", false, 2500 );
		
		zm_weapons::include_weapon( "t6_rpd", true, 2500 );
		zm_weapons::include_upgraded_weapon( "t6_rpd", "t6_rpd_up", false, 2500 );
		
		zm_weapons::include_weapon( "t5_bk_base_normal", true, 0 );
		zm_weapons::include_upgraded_weapon( "t5_bk_base_normal", "t5_bk_base_upgraded", false, 0 );
		zm_weapons::include_weapon( "t5_bk_bowie_normal", true, 0 );
		zm_weapons::include_upgraded_weapon( "t5_bk_bowie_normal", "t5_bk_bowie_upgraded", false, 0 );
		
		zm_weapons::include_weapon( "t6_war_machine", true, 1700 );
		zm_weapons::include_upgraded_weapon( "t6_war_machine", "t6_war_machine_up", false, 1700 );
	}
	else if(GetDvarString("mapname") == "zm_cellblock")
	{
		zm_weapons::include_weapon( "t6_m1911", true, 300 );
		//zm_weapons::include_upgraded_weapon( "t6_m1911", "t6_m1911_rdw_up", false, 300 );
		
		zm_weapons::include_weapon( "t6_fiveseven_rdw", true, 1100 );
		zm_weapons::include_upgraded_weapon( "t6_fiveseven_rdw", "t6_fiveseven_rdw_up", false, 1100 );
		
		zm_weapons::include_weapon( "t6_executioner", true, 600 );
		zm_weapons::include_upgraded_weapon( "t6_executioner", "t6_executioner_up", false, 600 );
		
		zm_weapons::include_weapon( "t6_pdw57", true, 1000 );
		zm_weapons::include_upgraded_weapon( "t6_pdw57", "t6_pdw57_up", false, 1000 );
		
		zm_weapons::include_weapon( "t6_m1927", true, 1500 );
		zm_weapons::include_upgraded_weapon( "t6_m1927", "t6_m1927_up", false, 1500 );
		
		zm_weapons::include_weapon( "t6_fal", true, 600 );
		zm_weapons::include_upgraded_weapon( "t6_fal", "t6_fal_up", false, 600 );
			
		zm_weapons::include_weapon( "t6_mtar", true, 1300 );
		zm_weapons::include_upgraded_weapon( "t6_mtar", "t6_mtar_up", false, 1300 );
		
		zm_weapons::include_weapon( "t6_ak47", true, 1400 );
		zm_weapons::include_upgraded_weapon( "t6_ak47", "t6_ak47_up", false, 1400 );
		
		zm_weapons::include_weapon( "t6_galil", true, 1400 );
		zm_weapons::include_upgraded_weapon( "t6_galil", "t6_galil_up", false, 1400 );
			
		zm_weapons::include_weapon( "t6_rem870mcs", true, 1200 );
		zm_weapons::include_upgraded_weapon( "t6_rem870mcs", "t6_rem870mcs_up", false, 1200 );
		
		zm_weapons::include_weapon( "t6_s12", true, 1250 );
		zm_weapons::include_upgraded_weapon( "t6_s12", "t6_s12_up", false, 1250 );
		
		zm_weapons::include_weapon( "t6_m82a1", true, 2000 );
		zm_weapons::include_upgraded_weapon( "t6_m82a1", "t6_m82a1_up", false, 2000 );
			
		zm_weapons::include_weapon( "t6_dsr50", true, 2000 );
		zm_weapons::include_upgraded_weapon( "t6_dsr50", "t6_dsr50_up", false, 2000 );
		
		zm_weapons::include_weapon( "t6_lsat", true, 2000 );
		zm_weapons::include_upgraded_weapon( "t6_lsat","t6_lsat_up", false, 2000 );
		
		zm_weapons::include_weapon( "t6_death_machine", true, 5000 );
		zm_weapons::include_upgraded_weapon( "t6_death_machine","t6_death_machine_up", false, 5000 );
		
		zm_weapons::include_weapon( "t6_rpg", true, 3000 );
		zm_weapons::include_upgraded_weapon( "t6_rpg", "t6_rpg_up", false, 3000 );
		
		zm_weapons::include_weapon( "t8_shotgun_blundergat", true, 5000 );
		zm_weapons::include_upgraded_weapon( "t8_shotgun_blundergat", "t8_shotgun_blundergat_upgraded", false, 5000 );
	}
	else if(GetDvarString("mapname") == "zm_prison") //copforthat's Mob of the Dead
	{
		zm_weapons::include_weapon( "t6_fiveseven_rdw", true, 1100 );
		zm_weapons::include_upgraded_weapon( "t6_fiveseven_rdw", "t6_fiveseven_rdw_up", false, 1100 );
		
		zm_weapons::include_weapon( "t6_executioner", true, 600 );
		zm_weapons::include_upgraded_weapon( "t6_executioner", "t6_executioner_up", false, 600 );
		
		zm_weapons::include_weapon( "t6_pdw57", true, 1000 );
		zm_weapons::include_upgraded_weapon( "t6_pdw57", "t6_pdw57_up", false, 1000 );
		
		zm_weapons::include_weapon( "t6_fal", true, 600 );
		zm_weapons::include_upgraded_weapon( "t6_fal", "t6_fal_up", false, 600 );
			
		zm_weapons::include_weapon( "t6_mtar", true, 1300 );
		zm_weapons::include_upgraded_weapon( "t6_mtar", "t6_mtar_up", false, 1300 );
		
		zm_weapons::include_weapon( "t6_ak47", true, 1400 );
		zm_weapons::include_upgraded_weapon( "t6_ak47", "t6_ak47_up", false, 1400 );
		
		zm_weapons::include_weapon( "t6_galil", true, 1400 );
		zm_weapons::include_upgraded_weapon( "t6_galil", "t6_galil_up", false, 1400 );
		
		zm_weapons::include_weapon( "t6_s12", true, 1250 );
		zm_weapons::include_upgraded_weapon( "t6_s12", "t6_s12_up", false, 1250 );
		
		zm_weapons::include_weapon( "t6_m82a1", true, 2000 );
		zm_weapons::include_upgraded_weapon( "t6_m82a1", "t6_m82a1_up", false, 2000 );
			
		zm_weapons::include_weapon( "t6_dsr50", true, 2000 );
		zm_weapons::include_upgraded_weapon( "t6_dsr50", "t6_dsr50_up", false, 2000 );
		
		zm_weapons::include_weapon( "t6_lsat", true, 2000 );
		zm_weapons::include_upgraded_weapon( "t6_lsat","t6_lsat_up", false, 2000 );
		
		zm_weapons::include_weapon( "t6_death_machine", true, 5000 );
		zm_weapons::include_upgraded_weapon( "t6_death_machine","t6_death_machine_up", false, 5000 );
		
		zm_weapons::include_weapon( "t6_rpg", true, 3000 );
		zm_weapons::include_upgraded_weapon( "t6_rpg", "t6_rpg_up", false, 3000 );
		
		zm_weapons::include_weapon( "t6_xl_raygun_mark2", true, 10000 );
		zm_weapons::include_upgraded_weapon( "t6_xl_raygun_mark2", "t6_xl_raygun_mark2_up", false, 10000 );
		
		zm_weapons::include_weapon( "t8_blundergat", true, 10000 );
		zm_weapons::include_upgraded_weapon( "t8_blundergat", "t8_blundergat_upgraded", false, 10000 );
	}
	
	if(GetDvarString("mapname") == "zm_town_hd")
	{
		zm_weapons::include_weapon( "raygun_mark2", true, 5000 );
		zm_weapons::include_upgraded_weapon( "raygun_mark2", "raygun_mark2_upgraded", false, 5000 );
		
		zm_weapons::include_weapon( "knife_ballistic", true, 1000 );
		zm_weapons::include_upgraded_weapon( "knife_ballistic", "knife_ballistic_upgraded", false, 1000 );
	}
	else if(GetDvarString("mapname") == "zm_diner")
	{	
		zm_weapons::include_weapon( "t7_raygun_mark2", true, 10000 );
		zm_weapons::include_upgraded_weapon( "t7_raygun_mark2", "t7_raygun_mark2_upgraded", false, 10000 );
	}
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
	if(GetDvarString("mapname") == "zm_prototype")
	{
		switch(GetGametypeSetting(mutator_scopeads))
		{
			case 1:
			{
				zm_weapons::include_weapon( "t6_dsr50_overlay", false, 1500, undefined );
				zm_weapons::include_upgraded_weapon( "t6_dsr50_overlay", "t6_dsr50_up_overlay", false, 1500, undefined );
				break;
			}
			case 3:
			{
				zm_weapons::include_weapon( "t6_dsr50_switch", false, 1500, undefined );
				zm_weapons::include_upgraded_weapon( "t6_dsr50_switch", "t6_dsr50_up_switch", false, 1500, undefined );
				break;
			}
		}
	}
	else if(GetDvarString("mapname") == "zm_die")
	{
		switch(GetGametypeSetting(mutator_scopeads))
		{
			case 1:
			{
				zm_weapons::include_weapon( "t6_svu_as_overlay", false, 1000, undefined );
				zm_weapons::include_upgraded_weapon( "t6_svu_as_overlay", "t6_svu_as_up_overlay", false, 1000, undefined );
				break;
			}
			case 3:
			{
				zm_weapons::include_weapon( "t6_dsr50_switch", false, 1000, undefined );
				zm_weapons::include_upgraded_weapon( "t6_svu_as_switch", "t6_svu_as_up_switch", false, 1000, undefined );
				break;
			}
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
						switch(GetGametypeSetting(mutator_scopeads))
						{
						case 1:
							ent.zombie_weapon_upgrade = "t6_dsr50_overlay";
							break;
						case 3:
							ent.zombie_weapon_upgrade = "t6_dsr50_switch";
							break;
						default:
							ent.zombie_weapon_upgrade = "t6_dsr50";
							break;
						}
						
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
					if(GetGametypeSetting(mutator_town_ballista) == BOOLMUTATOR_OFFON_OFF)
						ent struct::delete();
					else
						ent.zombie_weapon_upgrade = "t6_ballista";
					break;
				case "t6_smg_pdw57":
					if(GetGametypeSetting(mutator_town_pdw57) == BOOLMUTATOR_OFFON_OFF)
						ent struct::delete();
					else
						ent.zombie_weapon_upgrade = "t6_pdw57";
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
					{
						switch(GetGametypeSetting(mutator_scopeads))
						{
						case 1:
							ent.zombie_weapon_upgrade = "t6_svu_as_overlay";
							break;
						case 3:
							ent.zombie_weapon_upgrade = "t6_svu_as_switch";
							break;
						default:
							ent.zombie_weapon_upgrade = "t6_svu_as";
							break;
						}
						
						break;
					}
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
		case "zm_cellblock": //Hyb's Cell Block Survival
			{
				switch(VAL)
				{
				case "t6_xl_b23r":
					ent.zombie_weapon_upgrade = "t6_b23r";
					break;
				case "t6_xl_olympia":
					ent.zombie_weapon_upgrade = "t6_olympia";
					break;
				case "t6_xl_mp5":
					ent.zombie_weapon_upgrade = "t6_mp5";
					break;
				case "smg_thompson":
					ent.zombie_weapon_upgrade = "t6_uzi";
					break;
				}
				break;
			}
		case "zm_pentagon": //FIVE Remastered
			{
				switch(VAL)
				{
				//case "t5_m14":
				case "t9_tr_dmr":
					ent.zombie_weapon_upgrade = "t6_m14";
					break;
				//case "t5_olympia":
				case "t9_sh_ironhide":
					ent.zombie_weapon_upgrade = "t6_olympia";
					break;
				//case "t5_mpl":
				case "t9_smg_ots9":
					ent.zombie_weapon_upgrade = "t6_b23r";
					break;
				//case "t5_pm63":
				case "t9_pi_amp63":
					ent.zombie_weapon_upgrade = "t6_pdw57";
					break;
				//case "t5_mp5":
				case "t9_smg_mp5":
					ent.zombie_weapon_upgrade = "t6_mp5";
					break;
				//case "t5_stakeout":
				case "t9_sh_hauer":
					ent.zombie_weapon_upgrade = "t6_rem870mcs";
					break;
				//case "t5_ak74u":
				case "t9_smg_ak74u":
					ent.zombie_weapon_upgrade = "t6_ak74u";
					break;
				//case "t5_m16a1":
				case "t9_tr_m16":
					ent.zombie_weapon_upgrade = "t6_m16a1";
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
			if(!isdefined(level._included_weapons[GetWeapon("sticky_grenade_custom")]))
				zm_weapons::include_weapon( "sticky_grenade_custom", false, 250, 250);
			
			ent.zombie_weapon_upgrade = "sticky_grenade_custom";
		}
		
		if(isdefined(ent.target) && isdefined(VAL))
		{
			struct::get(ent.target, "targetname").model = GetWeapon(ent.zombie_weapon_upgrade).worldmodel;
		}
	}
	
	if(GetGametypeSetting(mutator_claymore) == BOOLMUTATOR_ONOFF_ON && GetDvarString("mapname") != "zm_die")
	{
		foreach(ent in struct::get_array("claymore_purchase", "targetname"))
		{
			spawn_loc = struct::get(ent.target, "targetname");
			if(GetDvarString("mapname") != "zm_pentagon" && GetDvarString("mapname") != "zm_prison")
			{
				ent.zombie_weapon_upgrade = "claymore_custom";
				spawn_loc.angles -= (0, -90, 0);
			}
			spawn_loc.script_vector = (0, -90, 0);
		}
	}
	
	//Add M14 to Hybs' Cell Block Survival but skip DanWj's Cell Block
	if(GetDvarString("ui_mapname") == "3551452640" || GetDvarString("ui_mapname") == "zm_cellblock_hd")
	{
		wallbuy = spawnstruct();
		wallbuy.targetname = "weapon_upgrade";
		wallbuy.zombie_weapon_upgrade = "t6_m14";
		wallbuy.angles = (0, 90, 0);
		wallbuy.origin = (2111, 10504, 1390);
		wallbuy struct::init();
		
		claymorebuy = spawnstruct();
		claymorebuy.targetname = "claymore_purchase";
		claymorebuy.zombie_weapon_upgrade = "claymore_custom";
		claymorebuy.angles = (0, 90, 0);
		claymorebuy.origin = (3395, 9877, 1390);
		claymorebuy struct::init();
	}
	else if(GetDvarString("ui_mapname") == "zm_cellblock" || GetDvarString("ui_mapname") == "2553596961")
	{
		claymorebuy = spawnstruct();
		claymorebuy.targetname = "claymore_purchase";
		claymorebuy.zombie_weapon_upgrade = "claymore_custom";
		claymorebuy.angles = (0, 90, 0);
		claymorebuy.origin = (3675, 570, 60);
		claymorebuy struct::init();
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
	
	if(GetDvarString("mapname") == "zm_die")
	{
		foreach(ent in GetEntArray("weapon_upgrade_chalk_set_t6", "targetname"))
			ent delete();
	}
}

