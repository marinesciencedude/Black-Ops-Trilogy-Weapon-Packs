#using scripts\codescripts\struct;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_audio;

#namespace spikemore_ee_fix;

function init()
{
	level waittill("initial_blackscreen_passed");
	structs = struct::get_array("sq_sad_trig", "targetname");
	for(i = 0; i < structs.size; i++)
		level._zombie_sidequests["sq"].stages["StD"].assets[i].thread_func = &spikemore_plug_hole;
}

function spikemore_plug_hole()
{
	if(!isdefined(level.var_b19e3661))
	{
		level.var_b19e3661 = 0;
	}
	level.var_68e59898 = 1;
	self thread target_debug();
	self thread begin_std_story_vox();
	self thread player_hint_line();
	self thread player_first_success();
	self playsound("evt_sq_std_spray_start");
	self playloopsound("evt_sq_std_spray_loop", 1);
	trigger = spawn("trigger_damage", self.origin, 0, 32, 32);
	trigger.angles = self.angles + (0, 90, 90);
	var_a4ff74b9 = getweapon("bouncingbetty");
	claymore = GetWeapon("claymore");
	attacker = undefined;
	while(true)
	{
		trigger waittill("damage", amount, attacker, dir, point, mod, tagname, modelname, partname, weaponname, dflags, inflictor, chargelevel);
		if((weaponname == var_a4ff74b9 || weaponname == claymore) && !level.var_b19e3661)
		{
			level.var_b19e3661 = 1;
			break;
		}
	}
	if(!isdefined(attacker))
	{
		attacker = getplayers()[0];
	}
	self notify("spiked", attacker);
	self stoploopsound(1);
	self playsound("evt_sq_std_spray_stop");
	level flag::set("std_target_" + self.script_int);
	util::clientnotify("S" + self.script_int);
	util::delay(0.1, undefined, &function_4fdfc508);
	trigger delete();
}

function function_4fdfc508()
{
	level.var_b19e3661 = 0;
}

function target_debug()
{
	/#
		self endon("death");
		self endon("spiked");
		while(!(isdefined(level.disable_print3d_ent) && level.disable_print3d_ent))
		{
			print3d(self.origin, "", vectorscale((0, 1, 0), 255), 1);
			wait(0.1);
		}
	#/
}

function begin_std_story_vox()
{
	self endon("death");
	level endon("sq_std_story_vox_begun");
	while(true)
	{
		players = getplayers();
		for(i = 0; i < players.size; i++)
		{
			if(distancesquared(self.origin, players[i].origin) <= 10000)
			{
				level thread std_story_vox(players[i]);
				level notify("sq_std_story_vox_begun");
				return;
			}
		}
		wait(0.1);
	}
}

function std_story_vox(player)
{
	level endon("sq_std_over");
	struct = struct::get("sq_location_std", "targetname");
	if(!isdefined(struct))
	{
		return;
	}
	level._std_sound_ent = spawn("script_origin", struct.origin);
	level thread std_story_vox_wait_for_finish();
	level._std_sound_ent playsoundwithnotify("vox_egg_story_4_0", "sounddone");
	level._std_sound_ent waittill("sounddone");
	if(isdefined(player))
	{
		level.skit_vox_override = 1;
		player playsoundwithnotify("vox_egg_story_4_1" + function_26186755(player.characterindex), "vox_egg_sounddone");
		player waittill("vox_egg_sounddone");
		level.skit_vox_override = 0;
	}
	level notify("sq_std_hint_line");
}

function function_26186755(var_8e0fe378 = 0)
{
	var_bc7547cb = "a";
	switch(var_8e0fe378)
	{
		case 0:
		{
			var_bc7547cb = "a";
			break;
		}
		case 1:
		{
			var_bc7547cb = "b";
			break;
		}
		case 2:
		{
			var_bc7547cb = "d";
			break;
		}
		case 3:
		{
			var_bc7547cb = "c";
			break;
		}
	}
	return var_bc7547cb;
}

function std_story_vox_wait_for_finish()
{
	level endon("sq_std_over");
	count = 0;
	while(true)
	{
		level waittill("waterfall");
		if(!level flag::get("std_target_1") || !level flag::get("std_target_2") || !level flag::get("std_target_3") || !level flag::get("std_target_4"))
		{
			if(count < 1)
			{
				level._std_sound_ent playsoundwithnotify("vox_egg_story_4_2", "sounddone");
				level._std_sound_ent waittill("sounddone");
				count++;
			}
		}
		else
		{
			level._std_sound_ent playsoundwithnotify("vox_egg_story_4_3", "sounddone");
			level._std_sound_ent waittill("sounddone");
			break;
		}
	}
	level flag::set("std_plot_vo_done");
	level._std_sound_ent delete();
	level._std_sound_ent = undefined;
}

function player_hint_line()
{
	self endon("death");
	level endon("sq_std_hint_given");
	level waittill("sq_std_hint_line");
	while(true)
	{
		players = getplayers();
		for(i = 0; i < players.size; i++)
		{
			if(isdefined(self.origin) && distancesquared(self.origin, players[i].origin) <= 10000)
			{
				players[i] thread zm_audio::create_and_play_dialog("eggs", "quest5", 0);
				level notify("sq_std_hint_given");
				return;
			}
		}
		wait(0.1);
	}
}

function player_first_success()
{
	self endon("death");
	level endon("sq_std_first");
	self waittill("spiked", who);
	who thread zm_audio::create_and_play_dialog("eggs", "quest5", 1);
	level notify("sq_std_first");
}