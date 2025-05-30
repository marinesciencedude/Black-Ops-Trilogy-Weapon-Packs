// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_stats;

#namespace zm_bgb_im_feelin_lucky;

/*
	Name: __init__sytem__
	Namespace: zm_bgb_im_feelin_lucky
	Checksum: 0x3327B3A5
	Offset: 0x198
	Size: 0x34
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__sytem__()
{
	system::register("zm_bgb_im_feelin_lucky", &__init__, undefined, "bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_im_feelin_lucky
	Checksum: 0x618ABAC6
	Offset: 0x1D8
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register("zm_bgb_im_feelin_lucky", "activated", 2, undefined, undefined, undefined, &activation);
}

/*
	Name: activation
	Namespace: zm_bgb_im_feelin_lucky
	Checksum: 0x13E16015
	Offset: 0x238
	Size: 0x1BC
	Parameters: 0
	Flags: Linked
*/
function activation()
{
	powerup_origin = self get_player_dropped_powerup_origin();
	var_a8c63b5d = 0.75;
	n_roll = randomfloatrange(0, 1);
	if(n_roll < var_a8c63b5d)
	{
		var_93eb638b = zm_powerups::specific_powerup_drop(zm_powerups::get_regular_random_powerup_name(), powerup_origin);
	}
	else
	{
		if(isdefined(level.var_2d0e5eb6))
		{
			str_powerup = [[level.var_2d0e5eb6]]();
		}
		else
		{
			str_powerup = function_29a9b9b8();
		}
		if(str_powerup === "free_perk")
		{
			if(isdefined(level.var_2d0e5eb6))
			{
				str_powerup = [[level.var_2d0e5eb6]]();
			}
			else
			{
				str_powerup = function_29a9b9b8();
			}
		}
		var_93eb638b = zm_powerups::specific_powerup_drop(str_powerup, powerup_origin, undefined, undefined, undefined, self);
		var_93eb638b.gbg_drop = true;
	}
	var_bc1994bd = zm_utility::check_point_in_enabled_zone(var_93eb638b.origin, undefined, undefined);
	wait(1);
	if(!var_bc1994bd)
	{
		level thread function_434235f9(var_93eb638b);
	}
}

/*
	Name: function_29a9b9b8
	Namespace: zm_bgb_im_feelin_lucky
	Checksum: 0x43562EDC
	Offset: 0x400
	Size: 0xF2
	Parameters: 0
	Flags: Linked
*/
function function_29a9b9b8()
{
	var_d7a75a6e = getarraykeys(level.zombie_powerups);
	var_d7a75a6e = array::randomize(var_d7a75a6e);
	foreach(str_key in var_d7a75a6e)
	{
		if(level.zombie_powerups[str_key].player_specific === 1)
		{
			arrayremovevalue(var_d7a75a6e, str_key);
		}
	}
	return var_d7a75a6e[0];
}

function get_player_dropped_powerup_origin()
{
	powerup_origin = (self.origin + vectorscale(anglestoforward((0, self getplayerangles()[1], 0)), 60)) + vectorscale((0, 0, 1), 5);
	self zm_stats::increment_challenge_stat("GUM_GOBBLER_POWERUPS");
	return powerup_origin;
}

function function_434235f9(var_93eb638b)
{
	if(!isdefined(var_93eb638b))
	{
		return;
	}
	var_93eb638b ghost();
	var_93eb638b.clone_model = util::spawn_model(var_93eb638b.model, var_93eb638b.origin, var_93eb638b.angles);
	var_93eb638b.clone_model linkto(var_93eb638b);
	direction = var_93eb638b.origin;
	direction = (direction[1], direction[0], 0);
	if(direction[1] < 0 || (direction[0] > 0 && direction[1] > 0))
	{
		direction = (direction[0], direction[1] * -1, 0);
	}
	else if(direction[0] < 0)
	{
		direction = (direction[0] * -1, direction[1], 0);
	}
	if(!(isdefined(var_93eb638b.sndnosamlaugh) && var_93eb638b.sndnosamlaugh))
	{
		players = getplayers();
		for(i = 0; i < players.size; i++)
		{
			if(isalive(players[i]))
			{
				players[i] playlocalsound(level.zmb_laugh_alias);
			}
		}
	}
	playfxontag(level._effect["samantha_steal"], var_93eb638b, "tag_origin");
	var_93eb638b.clone_model unlink();
	var_93eb638b.clone_model movez(60, 1, 0.25, 0.25);
	var_93eb638b.clone_model vibrate(direction, 1.5, 2.5, 1);
	var_93eb638b.clone_model waittill("movedone");
	if(isdefined(self.damagearea))
	{
		self.damagearea delete();
	}
	var_93eb638b.clone_model delete();
	if(isdefined(var_93eb638b))
	{
		if(isdefined(var_93eb638b.damagearea))
		{
			var_93eb638b.damagearea delete();
		}
		var_93eb638b zm_powerups::powerup_delete();
	}
}