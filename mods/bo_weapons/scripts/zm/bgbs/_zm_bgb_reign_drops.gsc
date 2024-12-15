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

#namespace zm_bgb_reign_drops;

/*
	Name: __init__sytem__
	Namespace: zm_bgb_reign_drops
	Checksum: 0xDED1DE76
	Offset: 0x1E0
	Size: 0x34
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__sytem__()
{
	system::register("zm_bgb_reign_drops", &__init__, undefined, "bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_reign_drops
	Checksum: 0xEFAB241D
	Offset: 0x220
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register("zm_bgb_reign_drops", "activated", 2, undefined, undefined, &validation, &activation);
}

/*
	Name: validation
	Namespace: zm_bgb_reign_drops
	Checksum: 0x7F3D91FE
	Offset: 0x290
	Size: 0x22
	Parameters: 0
	Flags: Linked
*/
function validation()
{
	if(isdefined(self.var_b90dda44) && self.var_b90dda44)
	{
		return false;
	}
	return true;
}

/*
	Name: activation
	Namespace: zm_bgb_reign_drops
	Checksum: 0x1CC28CDD
	Offset: 0x2C0
	Size: 0x1E4
	Parameters: 0
	Flags: Linked
*/
function activation()
{
	self endon("disconnect");
	self endon("bled_out");
	level thread function_dea74fb0("minigun", self function_ed573cc2(1));
	self thread function_b18c3b2d(self function_ed573cc2(2));
	level thread function_dea74fb0("nuke", self function_ed573cc2(3));
	level thread function_dea74fb0("carpenter", self function_ed573cc2(4));
	level thread function_dea74fb0("free_perk", self function_ed573cc2(5));
	level thread function_dea74fb0("fire_sale", self function_ed573cc2(6));
	level thread function_dea74fb0("insta_kill", self function_ed573cc2(7));
	level thread function_dea74fb0("full_ammo", self function_ed573cc2(8));
	level thread function_dea74fb0("double_points", self function_ed573cc2(9));
	self.var_b90dda44 = 1;
	self thread function_7892610e();
}

function get_player_dropped_powerup_origin()
{
	powerup_origin = (self.origin + vectorscale(anglestoforward((0, self getplayerangles()[1], 0)), 60)) + vectorscale((0, 0, 1), 5);
	self zm_stats::increment_challenge_stat("GUM_GOBBLER_POWERUPS");
	return powerup_origin;
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

function function_b18c3b2d(origin)
{
	self endon("disconnect");
	self endon("bled_out");
	var_93eb638b = zm_powerups::specific_powerup_drop("bonus_points_player", origin, undefined, undefined, 0.1);
	var_93eb638b.bonus_points_powerup_override = &function_3258dd42;
	wait(1);
	if(isdefined(var_93eb638b) && (!var_93eb638b zm::in_enabled_playable_area() && !var_93eb638b zm::in_life_brush()))
	{
		level thread function_434235f9(var_93eb638b);
	}
}

function function_3258dd42()
{
	return 1250;
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

/*
	Name: function_7892610e
	Namespace: zm_bgb_reign_drops
	Checksum: 0x495E79A9
	Offset: 0x4B0
	Size: 0x92
	Parameters: 0
	Flags: Linked
*/
function function_7892610e()
{
	wait(0.05);
	n_start_time = gettime();
	n_total_time = 0;
	while(isdefined(level.active_powerups) && level.active_powerups.size)
	{
		wait(0.5);
		n_current_time = gettime();
		n_total_time = (n_current_time - n_start_time) / 1000;
		if(n_total_time >= 28)
		{
			break;
		}
	}
	self.var_b90dda44 = undefined;
}

/*
	Name: function_ed573cc2
	Namespace: zm_bgb_reign_drops
	Checksum: 0xAB8C78BA
	Offset: 0x550
	Size: 0x282
	Parameters: 1
	Flags: Linked
*/
function function_ed573cc2(n_position)
{
	v_powerup = self get_player_dropped_powerup_origin();
	v_up = vectorscale((0, 0, 1), 5);
	var_8e2dcc47 = (v_powerup + (anglestoforward(self.angles) * 60)) + v_up;
	var_682b51de = (var_8e2dcc47 + (anglestoforward(self.angles) * 60)) + v_up;
	switch(n_position)
	{
		case 1:
		{
			v_origin = (v_powerup + (anglestoright(self.angles) * -60)) + v_up;
			break;
		}
		case 2:
		{
			v_origin = v_powerup;
			break;
		}
		case 3:
		{
			v_origin = (v_powerup + (anglestoright(self.angles) * 60)) + v_up;
			break;
		}
		case 4:
		{
			v_origin = (var_8e2dcc47 + (anglestoright(self.angles) * -60)) + v_up;
			break;
		}
		case 5:
		{
			v_origin = var_8e2dcc47;
			break;
		}
		case 6:
		{
			v_origin = (var_8e2dcc47 + (anglestoright(self.angles) * 60)) + v_up;
			break;
		}
		case 7:
		{
			v_origin = (var_682b51de + (anglestoright(self.angles) * -60)) + v_up;
			break;
		}
		case 8:
		{
			v_origin = var_682b51de;
			break;
		}
		case 9:
		{
			v_origin = (var_682b51de + (anglestoright(self.angles) * 60)) + v_up;
			break;
		}
		default:
		{
			v_origin = v_powerup;
			break;
		}
	}
	return v_origin;
}

