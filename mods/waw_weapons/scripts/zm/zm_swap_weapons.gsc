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
	if(GetDvarString("mapname") != "zm_factory_classic")
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
	
	if(GetDvarInt("mutator_revive_anim") == 1)
		level.weaponrevivetool = getweapon("legacy_syrette");
		
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
		level.pack_a_punch_camo_index = 142;
	
	if(GetDvarInt("mutator_camo_disable") == 2)
		level.pack_a_punch_camo_index = 127; //blank camo, this is actually for Dempsey's Matryoshka Doll 
	
	//if(GetDvarString("mutator_startingweapon") != "Use Map")
	if(!GetDvarInt("mutator_startingweapon") || GetDvarInt("mutator_startingweapon") != 3)
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
	/*wpnname = GetDvarString("mutator_startingweapon");
	starting_weapon = GetWeapon(wpnname);
	wpnname_pap = wpnname;*/
	wpnname = "";
	if(!GetDvarInt("mutator_startingweapon"))
		wpnname = "t4_m1911";
	wpnname_pap = "";
	switch(GetDvarInt("mutator_startingweapon"))
	//switch(wpnname)
	{
	case 1:
	//case "t4_m1911":
		wpnname = "t4_m1911";
		wpnname_pap = "t4_m1911_up";
		//wpnname_pap += "_up";
		break;
	case 2:
	//case "t5_m1911":
		wpnname = "t5_m1911";
		wpnname_pap = "t5_m1911_rdw_up";
		//wpnname_pap += "_rdw_up";
		break;
	/*default:
		wpnname_pap += "_upgraded";
		break;*/
	}
	starting_weapon = GetWeapon(wpnname);
	starting_weapon_pap = GetWeapon(wpnname_pap);
	level.start_weapon = starting_weapon;
	level.default_laststandpistol = starting_weapon;
	level.default_solo_laststandpistol = starting_weapon_pap;
	thread zm::last_stand_pistol_rank_init();
	
	level flag::wait_till("initial_blackscreen_passed");
	
	foreach(player in GetPlayers())
	{
		if(player GetCurrentWeapon() != starting_weapon)
		{
			player TakeWeapon(player GetCurrentWeapon());
			player zm_weapons::weapon_give(starting_weapon, 0, 0, 1, 1);
		}
	}
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
				if(!GetDvarInt("mutator_wallbuys_kino_der_toten") || GetDvarInt("mutator_wallbuys_kino_der_toten") == 1) //Der Riese
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
				if(GetDvarInt("mutator_wallbuys_kino_der_toten") == 3 || GetDvarInt("mutator_wallbuys_kino_der_toten") == 4) //Black Ops
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
				if(!GetDvarInt("mutator_wallbuys_gorod_krovi") || GetDvarInt("mutator_wallbuys_gorod_krovi") == 1)
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
				else if(GetDvarInt("mutator_wallbuys_gorod_krovi") == 2) //HzRetro
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
		
		if(GetDvarInt("mutator_wallbuybox") == 2)
		{
			level.zombie_weapons[GetWeapon(ent.zombie_weapon_upgrade)].is_in_box = false;
			zm_utility::include_weapon( ent.zombie_weapon_upgrade, false);
		}
		
		if(isdefined(ent.target) && isdefined(VAL))
		{
			struct::get(ent.target, "targetname").model = GetWeapon(ent.zombie_weapon_upgrade).worldmodel;
		}
	}
	foreach(ent in struct::get_array("claymore_purchase", "targetname"))
	{
		ent.zombie_weapon_upgrade = "bo1_bouncingbetty";
		
		if(GetDvarString("mapname") == "zm_moon")
		{
			ent.origin += (0, 0, 3);
			spawn_loc = struct::get(ent.target, "targetname");
			spawn_loc.origin += (0, 0, 3);
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
	grenade = 0;
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
				case "zm_theater":																		
				case "zm_moon": 																		// ↔   ↔  ↕
					ent.var_47896610 = util::spawn_model("wallbuy_kar98k", spawn_loc.origin + VectorScale((0, 13, -3), 1), spawn_loc.angles);
					break;
				case "zm_asylum":
					{
						if((GetDvarInt("mutator_verruckt_springfield") == 1 || !GetDvarInt("mutator_verruckt_springfield")) && kar98k == 0)
							ent.var_47896610 = util::spawn_model("wallbuy_kar98k", spawn_loc.origin + VectorScale((-14, 0, -4), 1), spawn_loc.angles);
						else
							ent.var_47896610 = util::spawn_model("wallbuy_kar98k", spawn_loc.origin + VectorScale((1, 14, -4), 1), spawn_loc.angles);
						
						kar98k++;
						break;
					}
				case "zm_coast":
					ent.var_47896610 = util::spawn_model("wallbuy_kar98k", spawn_loc.origin + VectorScale((0, -13, -3), 1), spawn_loc.angles);
					break;
				case "zm_cosmodrome": //Ascension
					ent.var_47896610 = util::spawn_model("wallbuy_kar98k", spawn_loc.origin + VectorScale((13, -1, -3), 1), spawn_loc.angles);
					break;
				case "zm_tomb": //Origins
					ent.var_47896610 = util::spawn_model("wallbuy_kar98k", spawn_loc.origin + VectorScale((-13, 0, -4), 1), spawn_loc.angles);
					break;
				case "zm_castle": //Der Eisendrache
					ent.var_47896610 = util::spawn_model("wallbuy_kar98k", spawn_loc.origin + VectorScale((12, 2, -3), 1), spawn_loc.angles);
					break;
				case "zm_stalingrad": //Gorod Krovi
					ent.var_47896610 = util::spawn_model("wallbuy_kar98k", spawn_loc.origin + VectorScale((-13*cos(spawn_loc.angles[1]), -13*sin(spawn_loc.angles[1])-2, -3), 1), spawn_loc.angles);
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
				case "zm_temple": //Shangri La
					ent.var_47896610 = util::spawn_model("wallbuy_arisaka", spawn_loc.origin + VectorScale((0, 12, -3), 1), spawn_loc.angles);
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
				case "zm_cosmodrome": //Ascension
				case "zm_temple": //Shangri La
				case "zm_moon":
					ent.var_47896610 = util::spawn_model("wallbuy_gewehr43", spawn_loc.origin + VectorScale((0, -13, -2), 1), spawn_loc.angles);
					break;
				case "zm_tomb": //Origins
					ent.var_47896610 = util::spawn_model("wallbuy_gewehr43", spawn_loc.origin + VectorScale((0, 13, -2), 1), spawn_loc.angles);
					break;
				case "zm_castle": //Der Eisendrache
					ent.var_47896610 = util::spawn_model("wallbuy_gewehr43", spawn_loc.origin + VectorScale((2, -13, -2), 1), spawn_loc.angles);
					break;
				case "zm_island": //Zetsubou no Shima
					ent.var_47896610 = util::spawn_model("wallbuy_gewehr43", spawn_loc.origin + VectorScale((0, 13, -2), 1), spawn_loc.angles);
					break;
				case "zm_stalingrad": //Gorod Krovi
					ent.var_47896610 = util::spawn_model("wallbuy_gewehr43", spawn_loc.origin + VectorScale((-13*cos(spawn_loc.angles[1]), -13*sin(spawn_loc.angles[1]), -2), 1), spawn_loc.angles);
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
				case "zm_temple": //Shangri La
				case "zm_tomb": //Origins
					ent.var_47896610 = util::spawn_model("wallbuy_stg44", spawn_loc.origin + VectorScale((-20*cos(spawn_loc.angles[1]), -20*sin(spawn_loc.angles[1]), -4), 1), spawn_loc.angles);
					break;
				case "zm_factory":
				case "zm_der_riese":
				case "zm_giant":
					ent.var_47896610 = util::spawn_model("wallbuy_stg44", spawn_loc.origin + VectorScale((-1, -20, -4), 1), spawn_loc.angles);
					break;
				case "zm_theater":
					{
						if(GetDvarInt("mutator_wallbuys_kino_der_toten") == 2) //Conn6orsuper117
							ent.var_47896610 = util::spawn_model("wallbuy_stg44", spawn_loc.origin + VectorScale((0, 20, -4), 1), spawn_loc.angles);
						else
							ent.var_47896610 = util::spawn_model("wallbuy_stg44", spawn_loc.origin + VectorScale((-20, 0, -4), 1), spawn_loc.angles);
						
						break;
					}
				case "zm_cosmodrome": //Ascension
					ent.var_47896610 = util::spawn_model("wallbuy_stg44", spawn_loc.origin + VectorScale((-20*cos(spawn_loc.angles[1]), -20*sin(spawn_loc.angles[1])-1, -4), 1), spawn_loc.angles);
					break;
				case "zm_castle": //Der Eisendrache
					{
						if(!GetDvarInt("mutator_wallbuys_der_eisendrache") || GetDvarInt("mutator_wallbuys_der_eisendrache") == 1) //poyzee
							ent.var_47896610 = util::spawn_model("wallbuy_stg44", spawn_loc.origin + VectorScale((-20, 0, -4), 1), spawn_loc.angles);
						else if(GetDvarInt("mutator_wallbuys_der_eisendrache") == 2) //Conn6orsuper117
						{
							if(stg44 == 0) //Mission Control
								ent.var_47896610 = util::spawn_model("wallbuy_stg44", spawn_loc.origin + VectorScale((0, -20, -4), 1), spawn_loc.angles);
							else //Undercroft
								ent.var_47896610 = util::spawn_model("wallbuy_stg44", spawn_loc.origin + VectorScale((-20, 0, -4), 1), spawn_loc.angles);
							
							stg44++;
						}
						break;
					}
				case "zm_coast":
					ent.var_47896610 = util::spawn_model("wallbuy_stg44", spawn_loc.origin + VectorScale((-20*cos(spawn_loc.angles[1]), -20*sin(spawn_loc.angles[1]), -3), 1), spawn_loc.angles);
					break;
				case "zm_moon":
				case "zm_island": //Zetsubou no Shima
				case "zm_stalingrad": //Gorod Krovi
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
				case "zm_cosmodrome": //Ascension
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
				case "zm_moon":
					ent.var_47896610 = util::spawn_model("wallbuy_m1carbine", spawn_loc.origin + VectorScale((-1, -16, -2), 1), spawn_loc.angles);
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
				case "zm_stalingrad": //Gorod Krovi
					ent.var_47896610 = util::spawn_model("wallbuy_m1carbine", spawn_loc.origin + VectorScale((-16*cos(spawn_loc.angles[1]), -16*sin(spawn_loc.angles[1]), -4), 1), spawn_loc.angles);
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
				case "zm_stalingrad": //Gorod Krovi
					ent.var_47896610 = util::spawn_model("wallbuy_m1garand", spawn_loc.origin + VectorScale((-13*cos(spawn_loc.angles[1]), -13*sin(spawn_loc.angles[1]), -3), 1), spawn_loc.angles);
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
				case "zm_temple": //Shangri La
					ent.var_47896610 = util::spawn_model("wallbuy_type100", spawn_loc.origin + VectorScale((14, -1, -4), 1), spawn_loc.angles);
					break;
				case "zm_theater":
				case "zm_tomb": //Origins
					ent.var_47896610 = util::spawn_model("wallbuy_type100", spawn_loc.origin + VectorScale((0, 14, -4), 1), spawn_loc.angles);
					break;
				case "zm_coast":
					ent.var_47896610 = util::spawn_model("wallbuy_type100", spawn_loc.origin + VectorScale((-14, 0, -4), 1), spawn_loc.angles);
					break;
				case "zm_moon":
					ent.var_47896610 = util::spawn_model("wallbuy_type100", spawn_loc.origin + VectorScale((14, 0, -4), 1), spawn_loc.angles);
					break;
				case "zm_castle": //Der Eisendrache
					{
						if(!GetDvarInt("mutator_wallbuys_der_eisendrache") || GetDvarInt("mutator_wallbuys_der_eisendrache") == 1) //poyzee
							ent.var_47896610 = util::spawn_model("wallbuy_type100", spawn_loc.origin + VectorScale((-5, 14, -4), 1), spawn_loc.angles);
						else if(GetDvarInt("mutator_wallbuys_der_eisendrache") == 2) //Conn6orsuper117
							ent.var_47896610 = util::spawn_model("wallbuy_type100", spawn_loc.origin + VectorScale((-14*cos(spawn_loc.angles[1]), -14*sin(spawn_loc.angles[1]), -4), 1), spawn_loc.angles);
						
						break;
					}
				case "zm_cosmodrome": //Ascension
				case "zm_island": //Zetsubou no Shima
				case "zm_stalingrad": //Gorod Krovi
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
				case "zm_temple": //Shangri La
				case "zm_tomb": //Origins
					ent.var_47896610 = util::spawn_model("wallbuy_thompson", spawn_loc.origin + VectorScale((-19, 0, -4), 1), spawn_loc.angles);
					break;
				case "zm_castle": //Der Eisendrache
					ent.var_47896610 = util::spawn_model("wallbuy_thompson", spawn_loc.origin + VectorScale((-19*cos(spawn_loc.angles[1]), -19*sin(spawn_loc.angles[1]), -4), 1), spawn_loc.angles);
					break;
				case "zm_island": //Zetsubou no Shima
					ent.var_47896610 = util::spawn_model("wallbuy_thompson", spawn_loc.origin + VectorScale((-19*cos(spawn_loc.angles[1]), -19*sin(spawn_loc.angles[1])-1, -4), 1), spawn_loc.angles);
					break;
				case "zm_cosmodrome": //Ascension
				case "zm_moon":
					ent.var_47896610 = util::spawn_model("wallbuy_thompson", spawn_loc.origin + VectorScale((0, -19, -4), 1), spawn_loc.angles);
				case "zm_stalingrad": //Gorod Krovi
					if(!GetDvarInt("mutator_wallbuys_gorod_krovi") || GetDvarInt("mutator_wallbuys_gorod_krovi") == 1)
						ent.var_47896610 = util::spawn_model("wallbuy_thompson", spawn_loc.origin + VectorScale((0, -19, -4), 1), spawn_loc.angles);
					else if(GetDvarInt("mutator_wallbuys_gorod_krovi") == 2)
						ent.var_47896610 = util::spawn_model("wallbuy_thompson", spawn_loc.origin + VectorScale((-19*cos(spawn_loc.angles[1]), -19*sin(spawn_loc.angles[1]), -4), 1), spawn_loc.angles);
					
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
				case "zm_temple": //Shangri La
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
						if(GetDvarInt("mutator_wallbuys_kino_der_toten") == 3 || GetDvarInt("mutator_wallbuys_kino_der_toten") == 4) //Black Ops
							ent.var_47896610 = util::spawn_model("wallbuy_bar", spawn_loc.origin + VectorScale((10, 0, -3), 1), spawn_loc.angles);
						else if(GetDvarInt("mutator_wallbuys_kino_der_toten") == 2) //Conn6orsuper117
							ent.var_47896610 = util::spawn_model("wallbuy_bar", spawn_loc.origin + VectorScale((-10, 0, -3), 1), spawn_loc.angles);

						break;
					}
				case "zm_cosmodrome": //Ascension
					ent.var_47896610 = util::spawn_model("wallbuy_bar", spawn_loc.origin + VectorScale((0, -12, -3), 1), spawn_loc.angles);
					break;
				case "zm_tomb": //Origins
					ent.var_47896610 = util::spawn_model("wallbuy_bar", spawn_loc.origin + VectorScale((0, 12, -3), 1), spawn_loc.angles);
					break;
				case "zm_castle": //Der Eisendrache
					ent.var_47896610 = util::spawn_model("wallbuy_bar", spawn_loc.origin + VectorScale((-3, 12, -3), 1), spawn_loc.angles);
					break;
				case "zm_island": //Zetsubou no Shima
					ent.var_47896610 = util::spawn_model("wallbuy_bar", spawn_loc.origin + VectorScale((-11*cos(spawn_loc.angles[1]), -11*sin(spawn_loc.angles[1]), -3), 1), spawn_loc.angles);
					break;
				case "zm_stalingrad": //Gorod Krovi
					ent.var_47896610 = util::spawn_model("wallbuy_bar", spawn_loc.origin + VectorScale((10, 0, -3), 1), spawn_loc.angles);
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
				case "zm_cosmodrome": //Ascension
					ent.var_47896610 = util::spawn_model("wallbuy_fg42", spawn_loc.origin + VectorScale((1, 15, -2), 1), spawn_loc.angles);
					break;
				case "zm_tomb": //Origins
					ent.var_47896610 = util::spawn_model("wallbuy_fg42", spawn_loc.origin + VectorScale((-16*cos(spawn_loc.angles[1]), -16*sin(spawn_loc.angles[1]), -3), 1), spawn_loc.angles);
					break;
				case "zm_castle": //Der Eisendrache
					{
						if(!GetDvarInt("mutator_wallbuys_der_eisendrache") || GetDvarInt("mutator_wallbuys_der_eisendrache") == 1) //poyzee
							ent.var_47896610 = util::spawn_model("wallbuy_fg42", spawn_loc.origin + VectorScale((0, -16, -2), 1), spawn_loc.angles);
						else if(GetDvarInt("mutator_wallbuys_der_eisendrache") == 2) //Conn6orsuper117
							ent.var_47896610 = util::spawn_model("wallbuy_fg42", spawn_loc.origin + VectorScale((16, 0, -2), 1), spawn_loc.angles);
						
						break;
					}
				case "zm_island": //Zetsubou no Shima
					ent.var_47896610 = util::spawn_model("wallbuy_fg42", spawn_loc.origin + VectorScale((-16*cos(spawn_loc.angles[1])+1, -16*sin(spawn_loc.angles[1]), -2), 1), spawn_loc.angles);
					break;
				case "zm_stalingrad": //Gorod Krovi
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
				case "zm_stalingrad": //Gorod Krovi
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
				case "zm_cosmodrome": //Ascension
				case "zm_moon":
					ent.var_47896610 = util::spawn_model("wallbuy_trenchgun", spawn_loc.origin + VectorScale((0, 14, -3), 1), spawn_loc.angles);
					break;
				case "zm_coast":
					ent.var_47896610 = util::spawn_model("wallbuy_trenchgun", spawn_loc.origin + VectorScale((-14*cos(spawn_loc.angles[1]), -14*sin(spawn_loc.angles[1]), -3), 1), spawn_loc.angles);
					break;
				case "zm_temple": //Shangri La
					ent.var_47896610 = util::spawn_model("wallbuy_trenchgun", spawn_loc.origin + VectorScale((0, -14, -3), 1), spawn_loc.angles);
					break;
				case "zm_tomb": //Origins
					ent.var_47896610 = util::spawn_model("wallbuy_trenchgun", spawn_loc.origin + VectorScale((-14, 0, -3), 1), spawn_loc.angles);
					break;
				case "zm_castle": //Der Eisendrache
					{
						if(!GetDvarInt("mutator_wallbuys_der_eisendrache") || GetDvarInt("mutator_wallbuys_der_eisendrache") == 1) //poyzee
						{
							if(trenchgun == 0) //Right from spawn 
								ent.var_47896610 = util::spawn_model("wallbuy_trenchgun", spawn_loc.origin + VectorScale((14, 2, -3), 1), spawn_loc.angles);
							else //Left from spawn
								ent.var_47896610 = util::spawn_model("wallbuy_trenchgun", spawn_loc.origin + VectorScale((0, -14, -3), 1), spawn_loc.angles);
								
							trenchgun++;
						}
						else if(GetDvarInt("mutator_wallbuys_der_eisendrache") == 2) //Conn6orsuper117
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
						if(!GetDvarInt("mutator_wallbuys_kino_der_toten") || GetDvarInt("mutator_wallbuys_kino_der_toten") == 1) //Der Riese
							ent.var_47896610 = util::spawn_model("wallbuy_doublebarrel", spawn_loc.origin + VectorScale((12, 1, -4), 1), spawn_loc.angles);
						else if(GetDvarInt("mutator_wallbuys_kino_der_toten") == 3 || GetDvarInt("mutator_wallbuys_kino_der_toten") == 4) //Black Ops
							ent.var_47896610 = util::spawn_model("wallbuy_doublebarrel", spawn_loc.origin + VectorScale((0, 12, -4), 1), spawn_loc.angles);
						
						break;
					}
				case "zm_coast":
					ent.var_47896610 = util::spawn_model("wallbuy_doublebarrel", spawn_loc.origin + VectorScale((12*cos(spawn_loc.angles[1]), 12*sin(spawn_loc.angles[1]), -4), 1), spawn_loc.angles);
					break;
				case "zm_cosmodrome": //Ascension
					ent.var_47896610 = util::spawn_model("wallbuy_doublebarrel", spawn_loc.origin + VectorScale((-12, 1, -4), 1), spawn_loc.angles);
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
						if(!GetDvarInt("mutator_wallbuys_der_eisendrache") || GetDvarInt("mutator_wallbuys_der_eisendrache") == 1) //poyzee
						{
							if(doublebarrel == 0) //Right from Spawn
								ent.var_47896610 = util::spawn_model("wallbuy_doublebarrel", spawn_loc.origin + VectorScale((0, -13, -4), 1), spawn_loc.angles);
							else //Left from spawn
								ent.var_47896610 = util::spawn_model("wallbuy_doublebarrel", spawn_loc.origin + VectorScale((-1, -12, -4), 1), spawn_loc.angles);
							
							doublebarrel++;
						}
						else if(GetDvarInt("mutator_wallbuys_der_eisendrache") == 2) //Conn6orsuper117
							ent.var_47896610 = util::spawn_model("wallbuy_doublebarrel", spawn_loc.origin + VectorScale((-1, -12, -4), 1), spawn_loc.angles);
						
						break;
					}
				case "zm_island": //Zetsubou no Shima
					ent.var_47896610 = util::spawn_model("wallbuy_doublebarrel", spawn_loc.origin + VectorScale((0, -12, -4), 1), spawn_loc.angles);
					break;
				case "zm_stalingrad": //Gorod Krovi
					ent.var_47896610 = util::spawn_model("wallbuy_doublebarrel", spawn_loc.origin + VectorScale((-12*cos(spawn_loc.angles[1]), -12*sin(spawn_loc.angles[1]), -4), 1), spawn_loc.angles);
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
				case "zm_der_riese": //Der Riese: Declassified
				case "zm_giant": //TrustInUma's DER RIESE
					ent.var_47896610 = util::spawn_model("wallbuy_mp40_waw", spawn_loc.origin + VectorScale((1, 14, -4), 1), spawn_loc.angles);
					break;
				case "zm_theater": //Kino der Toten
					ent.var_47896610 = util::spawn_model("wallbuy_mp40_waw", spawn_loc.origin + VectorScale((-0.5, -14, -4), 1), spawn_loc.angles);
					break;
				case "zm_cosmodrome": //Ascension
					ent.var_47896610 = util::spawn_model("wallbuy_mp40_waw", spawn_loc.origin + VectorScale((0, -14, -4), 1), spawn_loc.angles);
					break;
				case "zm_temple": //Shangri La
					ent.var_47896610 = util::spawn_model("wallbuy_mp40_waw", spawn_loc.origin + VectorScale((-14, 0, -4), 1), spawn_loc.angles);
					break;
				case "zm_coast":
				case "zm_tomb": //Origins
					ent.var_47896610 = util::spawn_model("wallbuy_mp40_waw", spawn_loc.origin + VectorScale((-14*cos(spawn_loc.angles[1]), -14*sin(spawn_loc.angles[1]), -5), 1), spawn_loc.angles);
					break;
				case "zm_moon":
					ent.var_47896610 = util::spawn_model("wallbuy_mp40_waw", spawn_loc.origin + VectorScale((0, 14, -4), 1), spawn_loc.angles);
					break;
				case "zm_castle": //Der Eisendrache
					{
						if(mp40 == 0) //Living Quarters
							ent.var_47896610 = util::spawn_model("wallbuy_mp40_waw", spawn_loc.origin + VectorScale((0, 14, -4), 1), spawn_loc.angles);
						else //Power door from spawn
							ent.var_47896610 = util::spawn_model("wallbuy_mp40_waw", spawn_loc.origin + VectorScale((15, 0, -5), 1), spawn_loc.angles);
						
						mp40++;
						break;
					}
				case "zm_island": //Zetsubou no Shima
					{
						if(mp40 == 0)  //Outside Laboratory A
							ent.var_47896610 = util::spawn_model("wallbuy_mp40_waw", spawn_loc.origin + VectorScale((-1, -14, -4), 1), spawn_loc.angles);
						else //Bunker
							ent.var_47896610 = util::spawn_model("wallbuy_mp40_waw", spawn_loc.origin + VectorScale((14, 0, -4), 1), spawn_loc.angles);
				
						mp40++;
						break;
					}
				case "zm_stalingrad": //Gorod Krovi
					ent.var_47896610 = util::spawn_model("wallbuy_mp40_waw", spawn_loc.origin + VectorScale((-14*cos(spawn_loc.angles[1]), -14*sin(spawn_loc.angles[1]), -5), 1), spawn_loc.angles);
					break;
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_mp40_waw", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
			case "t4_dp28":
			{
				//Only Gorod Krovi for now
				spawn_loc = struct::get(ent.target, "targetname");
				ent.var_47896610 = util::spawn_model("wallbuy_dp27", spawn_loc.origin + VectorScale((10, 0, -4), 1), spawn_loc.angles);
				break;
			}
			case "frag_grenade_potato_masher":
			{
				spawn_loc = struct::get(ent.target, "targetname");
				switch( GetDvarString("mapname") )
				{
				case "zm_prototype":
				case "zm_cosmodrome": //Ascension
					ent.var_47896610 = util::spawn_model("wallbuy_grenade_bag", spawn_loc.origin + VectorScale((-5, 0, 5), 1), spawn_loc.angles);
					break;
				case "zm_asylum":
					{
						if(grenade == 0) //Speed Cola room
							ent.var_47896610 = util::spawn_model("wallbuy_grenade_bag", spawn_loc.origin + VectorScale((5, 0, 5), 1), spawn_loc.angles);
						else if(grenade == 1) //German Spawn
							ent.var_47896610 = util::spawn_model("wallbuy_grenade_bag", spawn_loc.origin + VectorScale((-5, 0, 5), 1), spawn_loc.angles);
						else if(grenade == 2) //American Hallway
							ent.var_47896610 = util::spawn_model("wallbuy_grenade_bag", spawn_loc.origin + VectorScale((7.5, 0, 0), 1), spawn_loc.angles);
						else //German Hallway
							ent.var_47896610 = util::spawn_model("wallbuy_grenade_bag", spawn_loc.origin + VectorScale((0, -5, 5), 1), spawn_loc.angles);
						
						grenade++;
						break;
					}
				case "zm_sumpf":
				case "zm_moon":
					ent.var_47896610 = util::spawn_model("wallbuy_grenade_bag", spawn_loc.origin + VectorScale((5, 0, 5), 1), spawn_loc.angles);
					break;
				case "zm_factory": //The Giant
					{
						if(grenade == 0) //Teleporter A
							ent.var_47896610 = util::spawn_model("wallbuy_grenade_bag", spawn_loc.origin + VectorScale((-1, -5, 5), 1), spawn_loc.angles);
						else if(grenade == 1) //Teleporter B
							ent.var_47896610 = util::spawn_model("wallbuy_grenade_bag", spawn_loc.origin + VectorScale((-5*cos(spawn_loc.angles[1]), -5*sin(spawn_loc.angles[1]), 5), 1), spawn_loc.angles);
						else //Teleporter C
							ent.var_47896610 = util::spawn_model("wallbuy_grenade_bag", spawn_loc.origin + VectorScale((0, -5, 5), 1), spawn_loc.angles);
						
						grenade++;
						break;
					}
				case "zm_theater":
					ent.var_47896610 = util::spawn_model("wallbuy_grenade_bag", spawn_loc.origin + VectorScale((0, 5, 5), 1), spawn_loc.angles);
					break;
				case "zm_temple":
					ent.var_47896610 = util::spawn_model("wallbuy_grenade_bag", spawn_loc.origin + VectorScale((-5*cos(spawn_loc.angles[1]), -5*sin(spawn_loc.angles[1]), 5), 1), spawn_loc.angles);
					break;
				case "zm_stalingrad": //Gorod Krovi
					ent.var_47896610 = util::spawn_model("wallbuy_grenade_bag", spawn_loc.origin + VectorScale((-5, 0, 0), 1), spawn_loc.angles);
				default:
					ent.var_47896610 = util::spawn_model("wallbuy_grenade_bag", spawn_loc.origin, spawn_loc.angles);
					break;
				}
				break;
			}
		}
	}
	foreach(ent in struct::get_array("claymore_purchase", "targetname"))
	{
		spawn_loc = struct::get(ent.target, "targetname");
		ent.var_47896610 = util::spawn_model("wallbuy_bouncingbetty", spawn_loc.origin + VectorScale((-7*cos(spawn_loc.angles[1]), -7*sin(spawn_loc.angles[1]), 0), 1), spawn_loc.angles);
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