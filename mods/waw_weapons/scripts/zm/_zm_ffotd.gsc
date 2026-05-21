// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\callbacks_shared;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm;

#using scripts\shared\spawner_shared;
//#using scripts\zm\_hb21_zm_behavior;
#using scripts\shared\clientfield_shared;
#using scripts\zm\quick_revive;
#using scripts\shared\flag_shared;

#using scripts\zm\zm_flamethrower;
#using scripts\zm\dive;
#using scripts\zm\_zm_t4_hud;
#using scripts\zm\_zm_weap_bo1bouncingbetty;
#using scripts\zm\_zm_xmodelalias;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\animation_state_machine_utility;

#insert scripts\zm\_zm_perks.gsh;
#insert scripts\shared\version.gsh;
#insert scripts\zm\_zm_mutators.gsh;
#insert scripts\shared\ai\systems\behavior_tree.gsh;
#insert scripts\shared\ai\systems\behavior.gsh;

#namespace zm_ffotd;

/*
	Name: main_start
	Namespace: zm_ffotd
	Checksum: 0x99EC1590
	Offset: 0x128
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function main_start()
{
	if(GetGametypeSetting(mutator_random_perk_machines) == BOOLMUTATOR_ONOFF_OFF)
		level.randomize_perk_machine_location = 0;
}

/*
	Name: main_end
	Namespace: zm_ffotd
	Checksum: 0x7CCBC53E
	Offset: 0x138
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function main_end()
{
	difficulty = 1;
	column = int(difficulty) + 1;
	zombie_utility::set_zombie_var("zombie_move_speed_multiplier", 4, 0, column);
	
	//spawner::add_archetype_spawn_function( "zombie", &test );
	
	if(!IsInArray(getarraykeys(level.exert_sounds[1]), "burp"))
	{
		level.exert_sounds[1]["burp"][0] = "evt_belch";
		level.exert_sounds[1]["burp"][1] = "evt_belch";
		level.exert_sounds[1]["burp"][2] = "evt_belch";
		level.exert_sounds[2]["burp"][0] = "evt_belch";
		level.exert_sounds[2]["burp"][1] = "evt_belch";
		level.exert_sounds[2]["burp"][2] = "evt_belch";
		level.exert_sounds[3]["burp"][0] = "evt_belch";
		level.exert_sounds[3]["burp"][1] = "evt_belch";
		level.exert_sounds[3]["burp"][2] = "evt_belch";
		level.exert_sounds[4]["burp"][0] = "evt_belch";
		level.exert_sounds[4]["burp"][1] = "evt_belch";
		level.exert_sounds[4]["burp"][2] = "evt_belch";
	}
	
	if(GetDvarInt("mutator_mystery_box_fx") == 2)
	{
		level._effect["lght_marker"] = "custom/magic_box_og/fx_weapon_box_marker_og";
		level._effect["lght_marker_flare"] = "custom/magic_box_og/fx_weapon_box_marker_fl_og";
	}
	
	zm_flamethrower::init();
	
	if(GetDvarString("mapname") != "zm_der_riese" || GetDvarString("mapname") != "zm_factory_classic")
	{
		zm_utility::register_lethal_grenade_for_level( "frag_grenade_potato_masher" );
		level.zombie_lethal_grenade_player_init = GetWeapon( "frag_grenade_potato_masher" );
	}
	
	if(GetGametypeSetting(mutator_quickrevive) == BOOLMUTATOR_ONOFF_ON && GetDvarString("mapname") == "zm_factory_classic")
	{
		level.check_quickrevive_hotjoin = &quick_revive::check_quickrevive_for_hotjoin;
		level flag::init( "solo_revive" );
		level._custom_perks[ PERK_QUICK_REVIVE ].cost = &quick_revive::revive_cost_override;
		level._custom_perks[ PERK_QUICK_REVIVE ].player_thread_give = &quick_revive::give_quick_revive_perk; //three downs system works, disappearing machine doesn't work
		level._custom_perks[ PERK_QUICK_REVIVE ].perk_machine_power_override_thread = &quick_revive::turn_revive_on; //doesn't work at all
	}
	
	
	if(GetDvarInt("mutator_bo_perk_icons") == 1)
	{
		clientfield::register( "clientuimodel", "hudItems.perks.quick_revive_bo", VERSION_SHIP, 2, "int" );
		clientfield::register( "clientuimodel", "hudItems.perks.additional_primary_weapon_bo", VERSION_SHIP, 2, "int" );
		clientfield::register( "clientuimodel", "hudItems.perks.dead_shot_bo", VERSION_SHIP, 2, "int" );
		clientfield::register( "clientuimodel", "hudItems.perks.electric_cherry_bo", VERSION_SHIP, 2, "int" );
		clientfield::register( "clientuimodel", "hudItems.perks.juggernaut_bo", VERSION_SHIP, 2, "int" );
		clientfield::register( "clientuimodel", "hudItems.perks.sleight_of_hand_bo", VERSION_SHIP, 2, "int" );
		clientfield::register( "clientuimodel", "hudItems.perks.marathon_bo", VERSION_SHIP, 2, "int" );
		clientfield::register( "clientuimodel", "hudItems.perks.widows_wine_bo", VERSION_SHIP, 2, "int" );
		clientfield::register( "clientuimodel", "hudItems.perks.doubletap_bo", 1, 2, "int");
	}
	else if(GetDvarInt("mutator_bo_perk_icons") == 2)
	{
		clientfield::register( "clientuimodel", "hudItems.perks.quick_revive_recolour", VERSION_SHIP, 2, "int" );
		clientfield::register( "clientuimodel", "hudItems.perks.additional_primary_weapon_recolour", VERSION_SHIP, 2, "int" );
		clientfield::register( "clientuimodel", "hudItems.perks.dead_shot_recolour", VERSION_SHIP, 2, "int" );
		clientfield::register( "clientuimodel", "hudItems.perks.electric_cherry_recolour", VERSION_SHIP, 2, "int" );
		clientfield::register( "clientuimodel", "hudItems.perks.juggernaut_recolour", VERSION_SHIP, 2, "int" );
		clientfield::register( "clientuimodel", "hudItems.perks.sleight_of_hand_recolour", VERSION_SHIP, 2, "int" );
		clientfield::register( "clientuimodel", "hudItems.perks.marathon_recolour", VERSION_SHIP, 2, "int" );
		clientfield::register( "clientuimodel", "hudItems.perks.widows_wine_recolour", VERSION_SHIP, 2, "int" );
		clientfield::register( "clientuimodel", "hudItems.perks.doubletap_recolour", 1, 2, "int");
	}
	else if(GetDvarString("mapname") != "zm_factory_classic")
		clientfield::register( "clientuimodel", "hudItems.perks.doubletap", 1, 2, "int");
	
	if(GetDvarInt("mutator_bo_perk_icons") != 3 && GetDvarString("mapname") != "zm_factory_classic")
	{
		if(isdefined(level._custom_perks[ PERK_QUICK_REVIVE ]))
			level._custom_perks[ PERK_QUICK_REVIVE ].clientfield_set = &quick_revive_set_clientfield;
		if(isdefined(level._custom_perks[ PERK_ADDITIONAL_PRIMARY_WEAPON ]))
			level._custom_perks[ PERK_ADDITIONAL_PRIMARY_WEAPON ].clientfield_set = &additional_primary_weapon_set_clientfield;
		if(isdefined(level._custom_perks[ PERK_DEAD_SHOT ]))
			level._custom_perks[ PERK_DEAD_SHOT ].clientfield_set = &deadshot_set_clientfield;
		if(isdefined(level._custom_perks[ PERK_ELECTRIC_CHERRY ]))
			level._custom_perks[ PERK_ELECTRIC_CHERRY ].clientfield_set = &electric_cherry_set_clientfield;
		if(isdefined(level._custom_perks[ PERK_JUGGERNOG ]))
			level._custom_perks[ PERK_JUGGERNOG ].clientfield_set = &juggernaut_set_clientfield;
		if(isdefined(level._custom_perks[ PERK_SLEIGHT_OF_HAND ]))
			level._custom_perks[ PERK_SLEIGHT_OF_HAND ].clientfield_set = &sleight_of_hand_set_clientfield;
		if(isdefined(level._custom_perks[ PERK_STAMINUP ]))
			level._custom_perks[ PERK_STAMINUP ].clientfield_set = &staminup_set_clientfield;
		if(isdefined(level._custom_perks[ PERK_WIDOWS_WINE ]))
			level._custom_perks[ PERK_WIDOWS_WINE ].clientfield_set = &widows_wine_set_clientfield;
		if(isdefined(level._custom_perks[ "specialty_rof" ]))
			level._custom_perks[ "specialty_rof" ].clientfield_set = &doubletap_set_clientfield;
	}
	else if(GetGametypeSetting(mutator_doubletap ) == 2 && GetDvarString("mapname") == "zm_factory_classic")
		level._custom_perks[ PERK_DOUBLETAP2 ].clientfield_set = level._custom_perks[ "specialty_rof" ].clientfield_set;
	
	if(GetGametypeSetting(mutator_falldamage) == BOOLMUTATOR_OFFON_ON)
	{
		//as per https://www.thetechgame.com/Archives/t=2401729/all-black-ops-patch-gpd-codes-dvar-list-l-updated-l.html
		setdvar("bg_fallDamageMinHeight", 128);
		setdvar("bg_fallDamageMaxHeight", 300); //whatever this sets the max to, certainly receive more damage when you fall further than this
												//closest height in testing is 136 (1 damage) and farthest height before death is 563 (98 damage)
												//136-564 range giving a difference of 428 being equal to 128+300 is probably a coincidence
	}
	
	level._custom_perks[ PERK_DEAD_SHOT ].cost = &deadshot_cost;
	
	if(GetDvarInt("mutator_bo_powerup_icons") == 1)
	{
		clientfield::register("toplayer", "powerup_instant_kill_bo", 1, 2, "int");
		level.zombie_powerups["insta_kill"].client_field_name = "powerup_instant_kill_bo";
		clientfield::register("toplayer", "powerup_double_points_bo", 1, 2, "int");
		level.zombie_powerups["double_points"].client_field_name = "powerup_double_points_bo";
		clientfield::register("toplayer", "powerup_fire_sale_bo", 1, 2, "int");
		level.zombie_powerups["fire_sale"].client_field_name = "powerup_fire_sale_bo";
		clientfield::register("toplayer", "powerup_mini_gun_bo", 1, 2, "int");
		level.zombie_powerups["minigun"].client_field_name = "powerup_mini_gun_bo";
		clientfield::register("toplayer", "powerup_zombie_blood_bo", 1, 2, "int");
		level.zombie_powerups["zombie_blood"].client_field_name = "powerup_zombie_blood_bo";
	}
	
	if(GetGametypeSetting(mutator_runtobarrier) && GetGametypeSetting(mutator_runtobarrier) != 1)
		BT_REGISTER_ACTION( "zombieMoveToEntranceAction", &zombieMoveToEntranceAction, undefined, &zombieMoveToEntranceActionTerminate );
}

function zombieMoveToEntranceAction( behaviorTreeEntity, asmStateName )
{	
	behaviorTreeEntity.got_to_entrance = false;
	AnimationStateNetworkUtility::RequestState( behaviorTreeEntity, asmStateName );
	
	switch(GetGametypeSetting(mutator_runtobarrier))
	{
	case 2:
		move_speed = "walk";
		break;
	case 3:
		move_speed = "run";
		break;
	case 4:
		move_speed = "sprint";
		break;
	case 5:
		move_speed = "super_sprint";
		break;
	}
	
	behaviorTreeEntity zombie_utility::set_zombie_run_cycle(move_speed);
	
	return BHTN_RUNNING;
}

function zombieMoveToEntranceActionTerminate( behaviorTreeEntity, asmStateName )
{
	if ( zombieIsAtEntrance( behaviorTreeEntity ) )
	{
		behaviorTreeEntity.got_to_entrance = true;
	}
	
	original_speed = behaviorTreeEntity.zombie_move_speed_original;
	behaviorTreeEntity zombie_utility::set_zombie_run_cycle(behaviorTreeEntity.zombie_move_speed_original);
	behaviorTreeEntity.zombie_move_speed_original = original_speed;

	return BHTN_SUCCESS;	
}

function zombieIsAtEntrance( behaviorTreeEntity )
{
	isAtScriptGoal = behaviorTreeEntity IsAtGoal();
	isAtEntrance = IsDefined( behaviorTreeEntity.first_node ) && isAtScriptGoal;

	return isAtEntrance;
}


function deadshot_cost()
{
	if(GetGametypeSetting(mutator_deadshot_price) == BOOLMUTATOR_ONOFF_ON)
		return 1000;
	else
		return 1500;
}

function quick_revive_set_clientfield( state )
{
	if(GetDvarInt("mutator_bo_perk_icons") == 1 && GetDvarString("mapname") != "zm_der_riese") //doesn't need to be done on Der Riese: Declassified
	{
		self clientfield::set_player_uimodel( "hudItems.perks.quick_revive_bo", state );
	}
	else if(GetDvarInt("mutator_bo_perk_icons") == 2)
	{
		self clientfield::set_player_uimodel( "hudItems.perks.quick_revive_recolour", state );
	}
	else
	{
		self clientfield::set_player_uimodel( PERK_CLIENTFIELD_QUICK_REVIVE, state );
	}
}

function additional_primary_weapon_set_clientfield( state )
{
	if(GetDvarInt("mutator_bo_perk_icons") == 1 && GetDvarString("mapname") != "zm_der_riese") //doesn't need to be done on Der Riese: Declassified
	{
		self clientfield::set_player_uimodel( "hudItems.perks.additional_primary_weapon_bo", state );
	}
	else if(GetDvarInt("mutator_bo_perk_icons") == 2)
	{
		self clientfield::set_player_uimodel( "hudItems.perks.additional_primary_weapon_recolour", state );
	}
	else
	{
		self clientfield::set_player_uimodel( PERK_CLIENTFIELD_ADDITIONAL_PRIMARY_WEAPON, state );
	}
}

function deadshot_set_clientfield( state )
{
	if(GetDvarInt("mutator_bo_perk_icons") == 1 && GetDvarString("mapname") != "zm_der_riese") //doesn't need to be done on Der Riese: Declassified
	{
		self clientfield::set_player_uimodel( "hudItems.perks.dead_shot_bo", state );
	}
	else if(GetDvarInt("mutator_bo_perk_icons") == 2)
	{
		self clientfield::set_player_uimodel( "hudItems.perks.dead_shot_recolour", state );
	}
	else
	{
		self clientfield::set_player_uimodel( PERK_CLIENTFIELD_DEAD_SHOT, state );
	}
}

function electric_cherry_set_clientfield( state )
{
	if(GetDvarInt("mutator_bo_perk_icons") == 1 && GetDvarString("mapname") != "zm_der_riese") //doesn't need to be done on Der Riese: Declassified
	{
		self clientfield::set_player_uimodel( "hudItems.perks.electric_cherry_bo", state );
	}
	else if(GetDvarInt("mutator_bo_perk_icons") == 2)
	{
		self clientfield::set_player_uimodel( "hudItems.perks.electric_cherry_recolour", state );
	}
	else
	{
		self clientfield::set_player_uimodel( PERK_CLIENTFIELD_ELECTRIC_CHERRY, state );
	}
}

function juggernaut_set_clientfield( state )
{
	if(GetDvarInt("mutator_bo_perk_icons") == 1 && GetDvarString("mapname") != "zm_der_riese") //doesn't need to be done on Der Riese: Declassified
	{
		self clientfield::set_player_uimodel( "hudItems.perks.juggernaut_bo", state );
	}
	else if(GetDvarInt("mutator_bo_perk_icons") == 2)
	{
		self clientfield::set_player_uimodel( "hudItems.perks.juggernaut_recolour", state );
	}
	else
	{
		self clientfield::set_player_uimodel( PERK_CLIENTFIELD_JUGGERNAUT, state );
	}
}

function sleight_of_hand_set_clientfield( state )
{
	if(GetDvarInt("mutator_bo_perk_icons") == 1 && GetDvarString("mapname") != "zm_der_riese") //doesn't need to be done on Der Riese: Declassified
	{
		self clientfield::set_player_uimodel( "hudItems.perks.sleight_of_hand_bo", state );
	}
	else if(GetDvarInt("mutator_bo_perk_icons") == 2)
	{
		self clientfield::set_player_uimodel( "hudItems.perks.sleight_of_hand_recolour", state );
	}
	else
	{
		self clientfield::set_player_uimodel( PERK_CLIENTFIELD_SLEIGHT_OF_HAND, state );
	}
}

function staminup_set_clientfield( state )
{
	if(GetDvarInt("mutator_bo_perk_icons") == 1 && GetDvarString("mapname") != "zm_der_riese") //doesn't need to be done on Der Riese: Declassified
	{
		self clientfield::set_player_uimodel( "hudItems.perks.marathon_bo", state );
	}
	else if(GetDvarInt("mutator_bo_perk_icons") == 2)
	{
		self clientfield::set_player_uimodel( "hudItems.perks.marathon_recolour", state );
	}
	else
	{
		self clientfield::set_player_uimodel( PERK_CLIENTFIELD_STAMINUP, state );
	}
}

function widows_wine_set_clientfield( state )
{
	if(GetDvarInt("mutator_bo_perk_icons") == 1 && GetDvarString("mapname") != "zm_der_riese") //doesn't need to be done on Der Riese: Declassified
	{
		self clientfield::set_player_uimodel( "hudItems.perks.widows_wine_bo", state );
	}
	else if(GetDvarInt("mutator_bo_perk_icons") == 2)
	{
		self clientfield::set_player_uimodel( "hudItems.perks.widows_wine_recolour", state );
	}
	else
	{
		self clientfield::set_player_uimodel( PERK_CLIENTFIELD_WIDOWS_WINE, state );
	}
}

function doubletap_set_clientfield(state)
{
	if(GetDvarInt("mutator_bo_perk_icons") == 1 && GetDvarString("mapname") != "zm_der_riese") //doesn't need to be done on Der Riese: Declassified
	{
		self clientfield::set_player_uimodel( "hudItems.perks.doubletap_bo", state );
	}
	else if(GetDvarInt("mutator_bo_perk_icons") == 2)
	{
		self clientfield::set_player_uimodel( "hudItems.perks.doubletap_recolour", state );
	}
	else
	{
		self clientfield::set_player_uimodel("hudItems.perks.doubletap", state);
	}
}

/*
	Name: optimize_for_splitscreen
	Namespace: zm_ffotd
	Checksum: 0xCBCB8C24
	Offset: 0x1A8
	Size: 0x50
	Parameters: 0
	Flags: Linked
*/
function optimize_for_splitscreen()
{
	if(!isdefined(level.var_7064bd2e))
	{
		level.var_7064bd2e = 3;
	}
	if(level.var_7064bd2e)
	{
		if(getdvarint("splitscreen_playerCount") >= level.var_7064bd2e)
		{
			return true;
		}
	}
	return false;
}

/*function test()
{
	if(GetGametypeSetting(mutator_sidestep) == BOOLMUTATOR_OFFON_ON)
		self hb21_zm_behavior::enable_side_step();
}*/
