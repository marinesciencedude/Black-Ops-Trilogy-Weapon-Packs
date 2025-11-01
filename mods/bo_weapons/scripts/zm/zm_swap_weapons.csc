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
	if(GetDvarInt("mutator_bocw_mp5k") == 2)
	{
		zm_weapons::include_weapon( "t9_mp5k", false, 1000, undefined );
		zm_weapons::include_upgraded_weapon( "t9_mp5k", "t9_mp5k_up", false, 1000, undefined );
	}
	
	if(GetDvarInt("mutator_bocw_ak74u") == 2)
	{
		zm_weapons::include_weapon( "t9_ak74u", false, 1200, undefined );
		zm_weapons::include_upgraded_weapon( "t9_ak74u", "t9_ak74u_up", false, 1200, undefined );
	}
	
	if(GetDvarInt("mutator_bocw_pm63") == 2)
	{
		zm_weapons::include_weapon( "t9_amp63", false, 1000, undefined );
		zm_weapons::include_upgraded_weapon( "t9_amp63", "t9_amp63_up", false, 1000, undefined );
	}
	
	if(GetDvarInt("mutator_bocw_hauer77") == 2)
	{
		zm_weapons::include_weapon( "t9_hauer77", false, 1500, undefined );
		zm_weapons::include_upgraded_weapon( "t9_hauer77", "t9_hauer77_up", false, 1500, undefined );
	}
	
	if(GetDvarInt("mutator_bocw_m14") == 2)
	{
		zm_weapons::include_weapon( "t9_m14classic", false, 500, undefined );
		zm_weapons::include_upgraded_weapon( "t9_m14classic", "t9_m14classic_up", false, 500, undefined );
	}
	
	if(GetDvarInt("mutator_bocw_m16") == 2)
	{
		zm_weapons::include_weapon( "t9_m16", false, 1200, undefined );
		zm_weapons::include_upgraded_weapon( "t9_m16", "t9_m16_up", false, 1200, undefined );
	}
	
	/*if(GetDvarInt("mutator_bocw_aug") == 2)
	{
		zm_weapons::include_weapon( "t9_aug", false, 1200, undefined );
		zm_weapons::include_upgraded_weapon( "t9_aug", "t9_aug_up", false, 1200, undefined );
		RemoveZombieBoxWeapon(GetWeapon("t5_aug"));
	}*/
	
	switch(GetGametypeSetting(mutator_scopeads))
	{
		case 1:
		{
			if(GetDvarInt("mutator_bocw_l96a1") == 2)
			{
				zm_weapons::include_weapon( "t9_lw3_tundra_overlay", true, 1900, 500 );
				zm_weapons::include_upgraded_weapon( "t9_lw3_tundra_overlay", "t9_lw3_tundra_up_overlay", false, 1900, 500 );
			}
			else
			{
				zm_weapons::include_weapon( "t5_l96a1_overlay", true, 1900, 500 );
				zm_weapons::include_upgraded_weapon( "t5_l96a1_overlay", "t5_l96a1_up_overlay", false, 1900, 500 );
			}
			RemoveZombieBoxWeapon(GetWeapon("t5_l96a1"));
			
			break;
		}
		case 2:
		{
			if(GetDvarInt("mutator_bocw_l96a1") == 2)
			{
				zm_weapons::include_weapon( "t9_lw3_tundra", true, 1900, 500 );
				zm_weapons::include_upgraded_weapon( "t9_lw3_tundra", "t9_lw3_tundra_up", false, 1900, 500 );
				RemoveZombieBoxWeapon(GetWeapon("t5_l96a1"));
			}
			
			break;
		}
		case 3:
		{
			if(GetDvarInt("mutator_bocw_l96a1") == 2)
			{	
				zm_weapons::include_weapon( "t9_lw3_tundra_switch", true, 1900, 500 );
				zm_weapons::include_upgraded_weapon( "t9_lw3_tundra_switch", "t9_lw3_tundra_up_switch", false, 1900, 500 );
			}
			else
			{
				zm_weapons::include_weapon( "t5_l96a1_switch", true, 1900, 500 );
				zm_weapons::include_upgraded_weapon( "t5_l96a1_switch", "t5_l96a1_up_switch", false, 1900, 500 );
			}
			RemoveZombieBoxWeapon(GetWeapon("t5_l96a1"));
			
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
					if(GetGametypeSetting(mutator_aug) == 1 && (!GetDvarInt("mutator_wallbuys_kino_der_toten") || GetDvarInt("mutator_wallbuys_kino_der_toten") == 5))
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
				
				if(!GetDvarInt("mutator_wallbuys_kino_der_toten") || GetDvarInt("mutator_wallbuys_kino_der_toten") == 5) //Black Ops
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
				else if(GetDvarInt("mutator_wallbuys_kino_der_toten") == 1) //Der Riese
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
				else if(GetDvarInt("mutator_wallbuys_kino_der_toten") == 3 || GetDvarInt("mutator_wallbuys_kino_der_toten") == 4) //WaW - Black Ops-style
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
								if(GetDvarInt("mutator_wallbuys_kino_der_toten") == 3)
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
								if(GetDvarInt("mutator_wallbuys_kino_der_toten") == 3)
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
				else if(GetDvarInt("mutator_wallbuys_kino_der_toten") == 2) //Conn6orsuper117
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
				case "ar_accurate": //ICR-1
					ent struct::delete();
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
		
		if(ent.zombie_weapon_upgrade == "sticky_grenade_custom" && GetDvarInt("mutator_grenade_wallbuy") == 2)
			ent.zombie_weapon_upgrade = "frag_grenade";
		else if(ent.zombie_weapon_upgrade == "frag_grenade" && GetDvarInt("mutator_grenade_wallbuy") == 3)
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

