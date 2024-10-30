// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\callbacks_shared;
#using scripts\zm\_zm_utility;

#using scripts\shared\spawner_shared;
#using scripts\zm\_hb21_zm_behavior;

#precache( "fx", "custom/magic_box_og/fx_weapon_box_marker_fl_og" );
#precache( "fx", "custom/magic_box_og/fx_weapon_box_marker_og" );

/*#precache( "fx", "zombie/fx_glow_eye_orange" );
#precache( "fx", "zombie/fx_glow_eye_orange_zod" );
#precache( "fx", "dlc1/castle/fx_glow_eye_orange_castle" );
#precache( "fx", "dlc3/stalingrad/fx_glow_eye_red_stal" );
#precache( "fx", "dlc5/zmhd/fx_zombie_eye_single_blue" );
#precache( "fx", "zombie/fx_glow_eye_white" );
#precache( "fx",  "zombie/fx_glow_eye_green");*/

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
	if(GetDvarInt("mutator_mystery_box_fx")== 2)
	{
		level._effect["lght_marker"] = "custom/magic_box_og/fx_weapon_box_marker_og";
		level._effect["lght_marker_flare"] = "custom/magic_box_og/fx_weapon_box_marker_fl_og";
	}
	
	if(GetDvarInt("mutator_random_perk_machines") == 2)
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
	
	spawner::add_archetype_spawn_function( "zombie", &test );
	
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

function test()
{
	if(GetDvarInt("mutator_sidestep") == 2)
		self hb21_zm_behavior::enable_side_step();
}
