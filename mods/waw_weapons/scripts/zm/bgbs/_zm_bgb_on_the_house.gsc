// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\codescripts\struct;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm;
#using scripts\zm\_zm_stats;

#namespace zm_bgb_on_the_house;

/*
	Name: __init__sytem__
	Namespace: zm_bgb_on_the_house
	Checksum: 0xC51104C2
	Offset: 0x178
	Size: 0x34
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__sytem__()
{
	system::register("zm_bgb_on_the_house", &__init__, undefined, "bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_on_the_house
	Checksum: 0xE8DD6036
	Offset: 0x1B8
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
	bgb::register("zm_bgb_on_the_house", "activated", 1, undefined, undefined, undefined, &activation);
}

function register(name, limit_type, limit, enable_func, disable_func, validation_func, activation_func)
{
	
}

/*
	Name: activation
	Namespace: zm_bgb_on_the_house
	Checksum: 0x3431E142
	Offset: 0x218
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function activation()
{
	self thread function_dea74fb0("free_perk");
}

function function_dea74fb0(str_powerup, v_origin = self get_player_dropped_powerup_origin())
{
	var_93eb638b = zm_powerups::specific_powerup_drop(str_powerup, v_origin);
	var_93eb638b.gbg_drop = true;
	wait(1);
	if(isdefined(var_93eb638b) && (!var_93eb638b zm::in_enabled_playable_area() && !var_93eb638b zm::in_life_brush()))
	{
		level thread function_434235f9(var_93eb638b);
	}
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