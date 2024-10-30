// ------------------------------------------
// Zombie Mutators - by Scobalula
// Credits: JariK - Lua Decompiler
// ------------------------------------------
// Includes
#using scripts\codescripts\struct;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\array_shared;
#using scripts\shared\util_shared;
#using scripts\shared\callbacks_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_spawner;
// #using scripts\zm\_zm_scob_utility;
#using scripts\zm\_zm_unitrigger;

#using scripts\zm\_zm_weapons;
#using scripts\shared\aat_shared;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_audio;

// Inserts
#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;
#insert scripts\zm\_zm_mutators.gsh;
#insert scripts\zm\_zm_perks.gsh;
//#insert scripts\zm\_zm_scob_utility.gsh;
// Namespace
#namespace zm_mutators;

REGISTER_SYSTEM_EX("zm_mutators", &__init__, &__main__, undefined)

function private __init__()
{
	DEFAULT(level.zm_mutators, 				[]);

	register_mutators();

	foreach(name, mutator in level.zm_mutators)
	{
		if(isdefined(mutator.prefunc) && IsFunctionPtr(mutator.prefunc))
		{
			level thread [[mutator.prefunc]](GetDvarInt(mutator.dvar));
		}
	}
}

function private __main__()
{
	foreach(name, mutator in level.zm_mutators)
	{
		if(isdefined(mutator.postfunc) && IsFunctionPtr(mutator.postfunc))
		{
			level thread [[mutator.postfunc]](GetDvarInt(mutator.dvar));
		}
	}
}

/@
"Name: register_mutator(<mutator_name>, <dvar_name>, [pre_func], [post_func])"
"Summary: Registers the given mutator with the required data."
"MandatoryArg: <mutator_name> : Mutator Name"
"MandatoryArg: <dvar_name> : Mutator Dvar, must match the Mutators Lua file"
"OptionalArg: [pre_func] : Function called pre-load, required if the mutator requires pre-load set up such as callbacks, etc."
"OptionalArg: [post_func] : Function called post-load, required if the mutator requires post-load set up"
"Example: zm_mutators::register_mutator(MUTATOR_PERKS_NAME, MUTATOR_PERKS_DVAR, undefined, &disable_perks);"
"SPMP: both"
@/
function register_mutator(mutator_name, dvar_name, pre_func, post_func)
{
	Assert(isdefined(mutator_name), 						"Mutator Name must be defined");
	Assert(isdefined(dvar_name), 							"Mutator Dvar Name must be defined");
	Assert(!isdefined(level.zm_mutators[mutator_name]), 	"Mutator " + mutator_name + " is already registered");

	// Spawn a struct to store our info
	level.zm_mutators[mutator_name] = SpawnStruct();

	level.zm_mutators[mutator_name].name 		= mutator_name;
	level.zm_mutators[mutator_name].dvar 		= dvar_name;
	level.zm_mutators[mutator_name].postfunc 	= post_func;
	level.zm_mutators[mutator_name].prefunc 	= pre_func;
}

function private register_mutators()
{
	// Register a single death event for all mutators
	//zm_spawner::register_zombie_death_event_callback(&zombie_mutators_on_death);
	//zm::register_vehicle_damage_callback(&vehicle_mutators_on_death);

	register_mutator("MutatorSettings_DoublePackaPunch", "mutator_double_packapunch", undefined, &double_packapunch);
	//register_mutator("MutatorSettings_PhDWidows", "mutator_phd_widows", undefined, &phd_widows); //handled using GetDvarInt
	register_mutator("MutatorSettings_WidowsWine", "mutator_widowswine_existence", undefined, &widowswine_existence);
	//register_mutator("MutatorSettings_BOPerkIcons", "mutator_bo_perk_icons", undefined, &bo_perk_icons); //handled using GetDvarInt
	//register_mutator("MutatorSettings_Deadshot", "mutator_deadshot_price", undefined, &deadshot_price); //handled using GetDvarInt
	register_mutator("MutatorSettings_Gobblegum", "mutator_enable_gobblegum", undefined, &enable_gobblegum);
	//register_mutator("MutatorSettings_AUG", "mutator_aug", undefined, &enable_aug); //handled using GetDvarInt
	//register_mutator("MutatorSettings_Claymore", "mutator_claymore", undefined, &enable_claymore); //handled using GetDvarInt
	register_mutator("MutatorSettings_SpaceMonkey", "mutator_spacemonkey", undefined, &spacemonkey);
	//handle weapons using GetDvarInt
	//register_mutator("MutatorSettings_AK47", "mutator_ak47", undefined, &enable_ak47);
	//register_mutator("MutatorSettings_Uzi", "mutator_uzi", undefined, &enable_uzi);
	//register_mutator("MutatorSettings_Skorpion", "mutator_skorpion", undefined, &enable_skorpion);
	//register_mutator("MutatorSettings_Stoner63", "mutator_stoner63", undefined, &enable_stoner63);
	//register_mutator("MutatorSettings_RayGunMkII", "mutator_raygunmkii", undefined, &enable_raygunmkii);
	register_mutator("MutatorSettings_Wunderfizz", "mutator_enable_wunderfizz", undefined, &enable_wunderfizz);
	register_mutator("MutatorSettings_CamoDarkMatter", "mutator_camo_dark_matter", &camo_dark_matter, undefined);
	register_mutator("MutatorSettings_CamoRitual", "mutator_camo_ritual", undefined, &camo_ritual);
	register_mutator("MutatorSettings_CamoEtching", "mutator_camo_etching", &camo_etching, undefined);
	register_mutator("MutatorSettings_CamoDerEisendrache", "mutator_camo_der_eisendrache", &camo_der_eisendrache, undefined);
	register_mutator("MutatorSettings_CamoOvergrowth", "mutator_camo_overgrowth", &camo_overgrowth, undefined);
	register_mutator("MutatorSettings_CamoGorodKrovi", "mutator_camo_gorod_krovi", &camo_gorod_krovi, undefined);
	register_mutator("MutatorSettings_CamoRevelations", "mutator_camo_revelations", &camo_revelations, undefined);
	register_mutator("MutatorSettings_CamoOrigins", "mutator_camo_origins", &camo_origins, undefined);
	register_mutator("MutatorSettings_CamoKino", "mutator_camo_kino", &camo_kino, undefined);
	register_mutator("MutatorSettings_CamoWorldAtWar", "mutator_camo_world_at_war", &camo_waw, undefined);
	register_mutator("MutatorSettings_CamoIce", "mutator_camo_ice", &camo_ice, undefined);
	register_mutator("MutatorSettings_CamoWeaponized115", "mutator_camo_weaponized_115", &camo_weaponized_115, undefined);
	register_mutator("MutatorSettings_CamoBlackOps", "mutator_camo_black_ops", &camo_black_ops, undefined); //don't create array if unneeded
	register_mutator("MutatorSettings_GeorgeReward", "mutator_george_reward", undefined, &george_reward);
	register_mutator("MutatorSettings_RoundMusic", "mutator_round_music", undefined, &round_music);
	register_mutator("MutatorSettings_WeaponRest", "mutator_weapon_rest", undefined, &weapon_rest);
	register_mutator("MutatorSettings_DoubleTap", "mutator_doubletap", undefined, &doubletap);
	register_mutator("MutatorSettings_DoubleTapExistence", "mutator_doubletap_existence", undefined, &doubletap_existence);
	register_mutator("MutatorSettings_DeadshotExistence", "mutator_deadshot_existence", undefined, &deadshot_existence);
	//register_mutator("MutatorSettings_CharacterVoicelines", "mutator_character_voicelines", undefined, &character_voicelines);
}

function private double_packapunch(dvar_value)
{
	if(dvar_value == MUTATOR_ONOFF_OFF)
		level.double_packapunch = false;
}

function private widowswine_existence(dvar_value)
{
	if(dvar_value == 2 && isdefined(level._random_perk_machine_perk_list))
		ArrayRemoveValue(level._random_perk_machine_perk_list, PERK_WIDOWS_WINE);
	else if(dvar_value == 3)
	{
		if(isdefined(level._random_perk_machine_perk_list))
			ArrayRemoveValue(level._random_perk_machine_perk_list, PERK_WIDOWS_WINE);
		level._custom_perks = Array::remove_index(level._custom_perks, "specialty_widowswine", 1);
	}
}

/*function private bo_perk_icons(dvar_value)
{
	if(dvar_value == MUTATOR_ONOFF_ON)
		level.bo_perk_icons = 1;
}*/

function private enable_gobblegum(dvar_value)
{
	//handle Disabled (dvar_value == 2) in _zm_mod.gsc
	//if(dvar_value == 2)
	//	level.enable_gobblegum = dvar_value;
	if(dvar_value == 3)
	{
		foreach(ent in GetEntArray("bgb_machine_use", "targetname"))
		{
			gbg_machine = struct::get(ent.target, "targetname");
			origin = gbg_machine.origin;
			angles = gbg_machine.angles;
			ent delete();
			model = util::spawn_model("p7_barrel_metal_55gal", origin, angles);
		}
	}
}

function private spacemonkey(dvar_value)
{
	if(dvar_value == MUTATOR_ONOFF_OFF && GetDvarString("mapname") == "zm_cosmodrome")
	{
		level.nextMonkeyStealRound = 0;
		level.next_monkey_round = 0;
		level thread Sand();
	}
}

function Sand() //I wonder why when decompiling from Cypress' Monkey Exterminiation Mod
{
	while(1)
	{
		level waittill("end_of_round");
		level.nextMonkeyStealRound = 0;
		level.next_monkey_round = 0;
	}
}

/*function private enable_ak47(dvar_value)
{
	level.ak47 = dvar_value;
}

function private enable_uzi(dvar_value)
{
	level.uzi = dvar_value;
}

function private enable_skorpion(dvar_value)
{
	level.skorpion = dvar_value;
}

function private enable_stoner63(dvar_value)
{
	level.stoner63 = dvar_value;
}

function private enable_raygunmkii(dvar_value)
{
	level.raygunmkii = dvar_value;
}*/

function private enable_wunderfizz(dvar_value)
{
	if(dvar_value == 3)
	{
		foreach(ent in GetEntArray("perk_random_machine", "targetname"))
		{
			random_perk_machine = struct::get(ent.target, "targetname");
			origin = random_perk_machine.origin;
			angles = random_perk_machine.angles;
			ent delete();
			model = util::spawn_model("p7_barrel_metal_55gal", origin, angles);
		}
	}
}

function camo_black_ops(dvar_value)
{
	if(dvar_value == MUTATOR_ONOFF_ON && isdefined(level.pack_a_punch_camo_list))
		level.pack_a_punch_camo_list[level.pack_a_punch_camo_list.size] = 132;
}

function camo_dark_matter(dvar_value)
{
	if(dvar_value == MUTATOR_OFFON_ON)
	{
		if(!isdefined(level.pack_a_punch_camo_list))
		{
			level.pack_a_punch_camo_list = [];
			level.pack_a_punch_camo_list[0] = 17;
		}
		else
			level.pack_a_punch_camo_list[level.pack_a_punch_camo_list.size] = 17;
	}
}

function camo_ritual(dvar_value)
{
	if(dvar_value == MUTATOR_OFFON_ON)
	{
		if(!isdefined(level.pack_a_punch_camo_list))
		{
			level.pack_a_punch_camo_list = [];
			level.pack_a_punch_camo_list[0] = 26;
		}
		else
			level.pack_a_punch_camo_list[level.pack_a_punch_camo_list.size] = 26;
	}
}

function camo_etching(dvar_value)
{
	if(dvar_value == MUTATOR_OFFON_ON)
	{
		if(!isdefined(level.pack_a_punch_camo_list))
		{
			level.pack_a_punch_camo_list = [];
			level.pack_a_punch_camo_list[0] = 42;
		}
		else
			level.pack_a_punch_camo_list[level.pack_a_punch_camo_list.size] = 42;
	}
}

function camo_der_eisendrache(dvar_value)
{
	if(dvar_value == MUTATOR_OFFON_ON)
	{
		if(!isdefined(level.pack_a_punch_camo_list))
		{
			level.pack_a_punch_camo_list = [];
			level.pack_a_punch_camo_list[0] = 75;
		}
		else
			level.pack_a_punch_camo_list[level.pack_a_punch_camo_list.size] = 75;
	}
}

function camo_overgrowth(dvar_value)
{
	if(dvar_value == MUTATOR_OFFON_ON)
	{
		if(!isdefined(level.pack_a_punch_camo_list))
		{
			level.pack_a_punch_camo_list = [];
			level.pack_a_punch_camo_list[0] = 81;
		}
		else
			level.pack_a_punch_camo_list[level.pack_a_punch_camo_list.size] = 81;
	}
}

function camo_gorod_krovi(dvar_value)
{
	if(dvar_value == MUTATOR_OFFON_ON)
	{
		if(!isdefined(level.pack_a_punch_camo_list))
		{
			level.pack_a_punch_camo_list = [];
			level.pack_a_punch_camo_list[0] = 84;
		}
		else
			level.pack_a_punch_camo_list[level.pack_a_punch_camo_list.size] = 84;
	}
}

function camo_revelations(dvar_value)
{
	if(dvar_value == MUTATOR_OFFON_ON)
	{
		if(!isdefined(level.pack_a_punch_camo_list))
		{
			level.pack_a_punch_camo_list = [];
			level.pack_a_punch_camo_list[0] = 121;
		}
		else
			level.pack_a_punch_camo_list[level.pack_a_punch_camo_list.size] = 121;
	}
}

function camo_origins(dvar_value)
{
	if(dvar_value == MUTATOR_OFFON_ON)
	{
		if(!isdefined(level.pack_a_punch_camo_list))
		{
			level.pack_a_punch_camo_list = [];
			level.pack_a_punch_camo_list[0] = 133;
		}
		else
			level.pack_a_punch_camo_list[level.pack_a_punch_camo_list.size] = 133;
	}
}

function camo_kino(dvar_value)
{
	if(dvar_value == MUTATOR_OFFON_ON)
	{
		if(!isdefined(level.pack_a_punch_camo_list))
		{
			level.pack_a_punch_camo_list = [];
			level.pack_a_punch_camo_list[0] = 140;
		}
		else
			level.pack_a_punch_camo_list[level.pack_a_punch_camo_list.size] = 140;
	}
}

function camo_waw(dvar_value)
{
	if(dvar_value == MUTATOR_OFFON_ON)
	{
		if(!isdefined(level.pack_a_punch_camo_list))
		{
			level.pack_a_punch_camo_list = [];
			level.pack_a_punch_camo_list[0] = 141;
		}
		else
			level.pack_a_punch_camo_list[level.pack_a_punch_camo_list.size] = 141;
	}
}

function george_reward(dvar_value)
{
	if (dvar_value == MUTATOR_OFFON_ON && GetDvarString("mapname") == "zm_coast")
	{
		for (;;)
		{
			level waittill("powerup_dropped", powerup);
			if(powerup.powerup_name == "minigun" && !powerup.gbg_drop)
			{
				origin = powerup.origin;
				for(i = 0; i < level.active_powerups.size; i++)
				{
					if(level.active_powerups[i].powerup_name == "free_perk" && !powerup.gbg_drop && DistanceSquared(level.active_powerups[i].origin, origin) < 3600) //must be sufficiently close and not spawned from Gobblegum
					{
						powerup zm_powerups::powerup_delete();
						zm_powerups::specific_powerup_drop("tesla", origin);
					}
				}
			}
		}
	}
}

function round_music(dvar_value)
{
	if(dvar_value == MUTATOR_ONOFF_ON && GetDvarString("mapname") != "zm_prototype")
	{
		level flag::wait_till("start_zombie_round_logic");
		
		for(i = 0; i < level.musicsystem.states["round_start"].musarray.size; i++)
			level.musicsystem.states["round_start"].musarray[i] = "round_start_prototype_1";

		for(i = 0; i < level.musicsystem.states["round_start_short"].musarray.size; i++)
			level.musicsystem.states["round_start_short"].musarray[i] = "round_start_prototype_1";

		if(GetDvarString("mapname") == "zm_cosmodrome")
		{
			for(i = 0; i < level.musicsystem.states["round_start_first_lander"].musarray.size; i++)
				level.musicsystem.states["round_start_first_lander"].musarray[i] = "round_start_first_ascension";
		}
		else
		{
			for(i = 0; i < level.musicsystem.states["round_start_first"].musarray.size; i++)
				level.musicsystem.states["round_start_first"].musarray[i] = "round_start_prototype_1";
		}

		for(i = 0; i < level.musicsystem.states["round_end"].musarray.size; i++)
			level.musicsystem.states["round_end"].musarray[i] = "round_end_prototype_1";
	}
}

function camo_ice(dvar_value)
{
	if(dvar_value == MUTATOR_OFFON_ON)
	{
		if(!isdefined(level.pack_a_punch_camo_list))
		{
			level.pack_a_punch_camo_list = [];
			level.pack_a_punch_camo_list[0] = 43;
		}
		else
			level.pack_a_punch_camo_list[level.pack_a_punch_camo_list.size] = 43;
	}
}

function weapon_rest(dvar_value)
{
	if(dvar_value == MUTATOR_OFFON_ON)
		SetDvar( "weaponrest_enabled", 1 );
}

function private doubletap_existence(dvar_value)
{
	if(dvar_value == 2 && isdefined(level._random_perk_machine_perk_list))
	{
		ArrayRemoveValue(level._random_perk_machine_perk_list, PERK_DOUBLETAP2);
		ArrayRemoveValue(level._random_perk_machine_perk_list, "specialty_rof");
	}
	else if(dvar_value == 3)
	{
		if(isdefined(level._random_perk_machine_perk_list))
		{
			ArrayRemoveValue(level._random_perk_machine_perk_list, PERK_DOUBLETAP2);
			ArrayRemoveValue(level._random_perk_machine_perk_list, "specialty_rof");
		}
		level._custom_perks = Array::remove_index(level._custom_perks, PERK_DOUBLETAP2, 1);
		level._custom_perks = Array::remove_index(level._custom_perks, "specialty_rof", 1);
	}
}

function private deadshot_existence(dvar_value)
{
	if(dvar_value == 2 && isdefined(level._random_perk_machine_perk_list))
		ArrayRemoveValue(level._random_perk_machine_perk_list, PERK_DEAD_SHOT);
	else if(dvar_value == 3)
	{
		if(isdefined(level._random_perk_machine_perk_list))
			ArrayRemoveValue(level._random_perk_machine_perk_list, PERK_DEAD_SHOT);
		level._custom_perks = Array::remove_index(level._custom_perks, PERK_DEAD_SHOT, 1);
	}
}

function private doubletap(dvar_value)
{
	if(dvar_value == 1)
	{
		if(isdefined(level._random_perk_machine_perk_list))
		{	
			if(IsInArray(level._random_perk_machine_perk_list, PERK_DOUBLETAP2))
				level._random_perk_machine_perk_list[level._random_perk_machine_perk_list.size] = "specialty_rof";
			ArrayRemoveValue(level._random_perk_machine_perk_list, PERK_DOUBLETAP2);
		}
		level._custom_perks = Array::remove_index(level._custom_perks, PERK_DOUBLETAP2, 1);
	}
	else
	{
		if(isdefined(level._random_perk_machine_perk_list))
			ArrayRemoveValue(level._random_perk_machine_perk_list, "specialty_rof");
		level._custom_perks = Array::remove_index(level._custom_perks, "specialty_rof", 1);
	}
}

function camo_weaponized_115(dvar_value)
{
	if(dvar_value == MUTATOR_OFFON_ON)
	{
		if(!isdefined(level.pack_a_punch_camo_list))
		{
			level.pack_a_punch_camo_list = [];
			level.pack_a_punch_camo_list[0] = 28;
		}
		else
			level.pack_a_punch_camo_list[level.pack_a_punch_camo_list.size] = 28;
	}
}

/*function character_voicelines(dvar_value)
{
	if(dvar_value == 3)
	{
		
	}
}*/

function private nullfunc()
{
	// Use this function to detour level function ptrs to disable them
}