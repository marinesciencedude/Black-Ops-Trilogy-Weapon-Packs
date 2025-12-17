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
	rk5 = 0;
	vesper = 0;
	kuda = 0;
	m8a7 = 0;
	krm262 = 0;
	argus = 0;
	sheiva = 0;
	lcar9 = 0;
	vmp = 0;
	kn44 = 0;
	hvk30 = 0;
	icr = 0;
	grenade = 0;
	foreach(ent in struct::get_array("weapon_upgrade", "targetname"))
	{
		VAL = ent.zombie_weapon_upgrade;
		if(!isdefined(VAL))
		{
			continue;
		}
		
		if(VAL == "smg_mp40_1940" || VAL == "s2_mp40" )
			ent.zombie_weapon_upgrade = "t4_mp40";
		
		if(VAL == "frag_grenade")
		{
			ent.zombie_weapon_upgrade = "frag_grenade_potato_masher";
			spawn_loc = struct::get(ent.target, "targetname");
			
			rotate = (25, 0, 0);
			if(GetDvarString("mapname") == "zm_asylum")
			{
				if(grenade == 2) //American Hallway
					rotate = (0, 0, 0);
				
				if(grenade == 3) //German Hallway
				{
					ent.origin += (0, -30, 0);
					spawn_loc.origin += (0, -30, 0);
				}
			}
			
			ent.angles += rotate;
			spawn_loc.angles += rotate;
			
			grenade++;
		}
		
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
				break;
			}
		case "zm_asylum": //Verrückt
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
		/*case "zm_factory_classic": //gcp345's DER RIESE
			{
				if(GetDvarInt("mutator_factory_classic") == 2) {
				switch(VAL)
				{
				case "zombie_kar98k":
					{
						ent.zombie_weapon_upgrade = "t4_kar98k";
						ent.origin += (0, -10, 0.5);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (0, -10, 0.5);
						break;
					}
				case "zombie_gewehr43":
					{
						ent.zombie_weapon_upgrade = "t4_g43";
						ent.origin += (0, -10, 1);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (0, -10, 1);
						break;
					}
				case "zombie_doublebarrel":
					{
						ent.zombie_weapon_upgrade = "t4_db";
						ent.origin += (0, -10, 2);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (0, -10, 2);
						break;
					}
				case "zombie_thompson":
					{
						ent.zombie_weapon_upgrade = "t4_thompson";
						ent.origin += (9, 0, 2);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (9, 0, 2);
						break;
					}
				case "zombie_m1carbine":
					{
						ent.zombie_weapon_upgrade = "t4_carbine";
						ent.origin += (12, 0, 0.5);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (12, 0, 0.5);
						break;
					}
				case "zombie_fg42":
					{
						ent.zombie_weapon_upgrade = "t4_fg42";
						ent.origin += (9, 0, 2);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (9, 0, 2);
						break;
					}
				case "zombie_shotgun":
					{
						ent.zombie_weapon_upgrade = "t4_m1897";
						ent.origin += (0, 10, 2);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (0, 10, 2);
						break;
					}
				case "zombie_mp40":
					{
						ent.zombie_weapon_upgrade = "t4_mp40";
						ent.origin += (0, -9, 2);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (0, -9, 2);
						break;
					}
				case "zombie_type100_smg":
					{
						ent.zombie_weapon_upgrade = "t4_type100";
						ent.origin += (-10.5, 0, 2.5);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (-10.5, 0, 2.5);
						break;
					}
				case "zombie_stg44":
					{
						ent.zombie_weapon_upgrade = "t4_mp44";
						ent.origin += (0, 10, 2);
						spawn_loc = struct::get(ent.target, "targetname");
						spawn_loc.origin += (0, 10, 2);
						break;
					}
				} }
			}*/
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
				if(!GetGametypeSetting(mutator_wallbuys_kino_der_toten) || GetGametypeSetting(mutator_wallbuys_kino_der_toten) == 1) //Der Riese
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
				if(GetGametypeSetting(mutator_wallbuys_kino_der_toten) == 3 || GetGametypeSetting(mutator_wallbuys_kino_der_toten) == 4) //WaW - Black Ops-style
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
		case "zm_coast":
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
						ent.zombie_weapon_upgrade = "t4_mp40";
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
				break;
			}
		case "zm_cosmodrome": //Ascension
		{//SexyTurtle
			switch(VAL)
			{
			case "ar_marksman": //Sheiva
				ent.zombie_weapon_upgrade = "t4_kar98k";
				break;
			case "pistol_burst": //RK5
				{
					if (rk5 == 0)
						ent.zombie_weapon_upgrade = "t4_g43";
					else
						ent.zombie_weapon_upgrade = "t4_mp40";
					
					rk5 = 1;
					break;
				}
			case "pistol_fullauto": //L-CAR 9
				{
					ent.zombie_weapon_upgrade = "t4_carbine";
					
					ent.origin += (10, 0, 0);
					spawn_loc = struct::get(ent.target, "targetname");
					spawn_loc.origin += (10, 0, 0);
					
					break;
				}
			case "smg_versatile": //VMP
				ent.zombie_weapon_upgrade = "t4_db";
				break;
			case "smg_fastfire": //Vesper
				ent.zombie_weapon_upgrade = "t4_thompson";
				break;
			case "ar_accurate": //ICR-1
				{
					ent.zombie_weapon_upgrade = "t4_type100";
					
					ent.origin += (10*cos(spawn_loc.angles[1]), 10*sin(spawn_loc.angles[1]), 0);
					spawn_loc = struct::get(ent.target, "targetname");
					spawn_loc.origin += (10*cos(spawn_loc.angles[1]), 10*sin(spawn_loc.angles[1]), 0);
					
					break;
				}
			case "smg_standard": //Kuda
				ent.zombie_weapon_upgrade = "t4_mp44";
				break;
			case "shotgun_precision": //Argus
				ent.zombie_weapon_upgrade = "t4_m1897";
				break;
			case "ar_standard": //KN-44
				ent.zombie_weapon_upgrade = "t4_bar";
				break;
			case "ar_cqb": //HVK-30
				{
					ent.zombie_weapon_upgrade = "t4_fg42";
					
					ent.origin += (0, -10, 0);
					spawn_loc = struct::get(ent.target, "targetname");
					spawn_loc.origin += (0, -10, 0);
					
					break;
				}
			}
			break;
		}
		case "zm_temple": //Shangri La
		{//SexyTurtle
			switch(VAL)
			{
			case "pistol_burst": //RK5
				ent.zombie_weapon_upgrade = "t4_type99r";
				break;
			case "ar_marksman": //Sheiva
				ent.zombie_weapon_upgrade = "t4_g43";
				break;
			case "pistol_fullauto": //L-CAR 9
				ent.zombie_weapon_upgrade = "t4_type100";
				break;
			case "smg_fastfire": //Vesper
				ent.zombie_weapon_upgrade = "t4_mp40";
				break;
			case "ar_accurate": //ICR-1
				ent.zombie_weapon_upgrade = "t4_m1897";
				break;
			case "smg_burst": //Pharo
				ent.zombie_weapon_upgrade = "t4_thompson";
				break;
			case "smg_standard": //Kuda
				ent.zombie_weapon_upgrade = "t4_mp44";
				break;
			case "ar_standard": //KN-44
				ent.zombie_weapon_upgrade = "t4_bar";
				break;
			}
			break;
		}
		case "zm_moon":
		{//SexyTurtle
			switch(VAL)
			{
			case "pistol_burst": //RK5
				ent.zombie_weapon_upgrade = "t4_kar98k";
				break;
			case "ar_marksman": //Sheiva
				{
					ent.zombie_weapon_upgrade = "t4_g43";
					
					ent.origin += (0, 5, 0);
					spawn_loc = struct::get(ent.target, "targetname");
					spawn_loc.origin += (0, 5, 0);
					
					break;
				}
			case "pistol_fullauto": //L-CAR 9
				{
					ent.zombie_weapon_upgrade = "t4_carbine";
					
					ent.origin += (0, 20, 0);
					spawn_loc = struct::get(ent.target, "targetname");
					spawn_loc.origin += (0, 20, 0);
					
					break;
				}
			case "smg_burst": //Pharo
				ent.zombie_weapon_upgrade = "t4_type100";
				break;
			case "smg_standard": //Kuda
				ent.zombie_weapon_upgrade = "t4_thompson";
				break;
			case "shotgun_precision": //Argus
				ent.zombie_weapon_upgrade = "t4_m1897";
				break;
			case "ar_standard": //KN-44
				ent.zombie_weapon_upgrade = "t4_mp44";
				break;
			case "smg_versatile": //VMP
				ent.zombie_weapon_upgrade = "t4_mp40";
			}
			break;
		}
		case "zm_tomb": //Origins
		{//HzRetro
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
					ent.zombie_weapon_upgrade = "t4_mp40";
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
					ent.zombie_weapon_upgrade = "t4_mp40";
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
							ent.zombie_weapon_upgrade = "t4_mp40";
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
							ent.zombie_weapon_upgrade = "t4_ppsh";
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
									ent.zombie_weapon_upgrade = "t4_mp40";
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
							ent.zombie_weapon_upgrade = "t4_mp40";
						
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
							ent.zombie_weapon_upgrade = "t4_mp40";
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
			{
				if(!GetGametypeSetting(mutator_wallbuys_gorod_krovi) || GetGametypeSetting(mutator_wallbuys_gorod_krovi) == 1)
				{ 
					switch(VAL)
					{
					case "ar_marksman": //Sheiva
						ent.zombie_weapon_upgrade = "t4_g43";
						break;
					case "pistol_burst": //RK5
						ent.zombie_weapon_upgrade = "t4_kar98k";
						break;
					case "shotgun_pump": //KRM-262
						ent.zombie_weapon_upgrade = "t4_db";
						break;
					case "pistol_fullauto": //L-CAR 9
						ent.zombie_weapon_upgrade = "t4_carbine";
						break;
					case "smg_burst": //Pharo
						ent.zombie_weapon_upgrade = "t4_m1";
						break;
					case "smg_standard": //Kuda
						ent.zombie_weapon_upgrade = "t4_mp40";
						break;
					case "shotgun_precision": //Argus
						{
							ent.zombie_weapon_upgrade = "t4_m1897";
							
							ent.origin += (-5, 0, 0);
							spawn_loc = struct::get(ent.target, "targetname");
							spawn_loc.origin += (-5, 0, 0);
							
							break;
						}
					case "ar_standard": //KN-44
						ent.zombie_weapon_upgrade = "t4_thompson";
						break;
					case "ar_cqb": //HVK-30
						{
							ent.zombie_weapon_upgrade = "t4_fg42";
							
							ent.origin += (5, 0, 0);
							spawn_loc = struct::get(ent.target, "targetname");
							spawn_loc.origin += (5, 0, 0);
							
							break;
						}
					case "ar_accurate": //ICR-1
						{
							ent.zombie_weapon_upgrade = "t4_type100";
							
							ent.origin += (20*cos(spawn_loc.angles[1]), 20*sin(spawn_loc.angles[1]), 0);
							spawn_loc = struct::get(ent.target, "targetname");
							spawn_loc.origin += (20*cos(spawn_loc.angles[1]), 20*sin(spawn_loc.angles[1]), 0);
							
							break;
						}
					case "smg_versatile": //VMP
						ent.zombie_weapon_upgrade = "t4_bar";
						break;
					case "smg_fastfire": //Vesper
						ent.zombie_weapon_upgrade = "t4_dp28";
						break;
					case "ar_longburst": //M8A7
						ent.zombie_weapon_upgrade = "t4_mp44";
						break;
					}
				}
				else if(GetGametypeSetting(mutator_wallbuys_gorod_krovi) == 2) //HzRetro
				{	
					switch(VAL)
					{
					case "ar_marksman": //Sheiva
						ent.zombie_weapon_upgrade = "t4_g43";
						break;
					case "pistol_burst": //RK5
						ent.zombie_weapon_upgrade = "t4_kar98k";
						break;
					case "shotgun_pump": //KRM-262
						ent.zombie_weapon_upgrade = "t4_db";
						break;
					case "pistol_fullauto": //L-CAR 9
						ent.zombie_weapon_upgrade = "t4_carbine";
						break;
					case "smg_burst": //Pharo
					case "ar_standard": //KN-44
						ent struct::delete();
						break;
					case "smg_standard": //Kuda
						ent.zombie_weapon_upgrade = "t4_thompson";
						break;
					case "shotgun_precision": //Argus
						{
							ent.zombie_weapon_upgrade = "t4_m1897";
							
							ent.origin += (-5, 0, 0);
							spawn_loc = struct::get(ent.target, "targetname");
							spawn_loc.origin += (-5, 0, 0);
							
							break;
						}
					case "ar_cqb": //HVK-30
						{
							ent.zombie_weapon_upgrade = "frag_grenade_potato_masher";
							
							/*ent.origin += (5, 0, 0);
							spawn_loc = struct::get(ent.target, "targetname");
							spawn_loc.origin += (5, 0, 0);*/
							
							break;
						}
					case "ar_accurate": //ICR-1
						{
							ent struct::delete();
							//Implement Trip Mines/Bouncing Betties here later
							break;
						}
					case "smg_versatile": //VMP
						ent.zombie_weapon_upgrade = "t4_type100";
						break;
					case "smg_fastfire": //Vesper
						ent.zombie_weapon_upgrade = "t4_mp40";
						break;
					case "ar_longburst": //M8A7
						ent.zombie_weapon_upgrade = "t4_mp44";
						break;
					}
				}
				break;
			}	
		}
		
		if(GetGametypeSetting(mutator_wallbuybox) == BOOLMUTATOR_ONOFF_OFF)
			RemoveZombieBoxWeapon(GetWeapon(ent.zombie_weapon_upgrade));
		
		if(isdefined(ent.target) && isdefined(VAL))
		{
			struct::get(ent.target, "targetname").model = GetWeapon(ent.zombie_weapon_upgrade).worldmodel;
		}
	}
}

