#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_sidequests;
#using scripts\zm\_zm;

#namespace zm_temple_ffotd;

/*
	Name: main_start
	Namespace: zm_temple_ffotd
	Checksum: 0xFF76F463
	Offset: 0x248
	Size: 0x13E
	Parameters: 0
	Flags: Linked
*/
function main_start()
{
	a_wallbuys = struct::get_array("weapon_upgrade", "targetname");
	foreach(s_wallbuy in a_wallbuys)
	{
		if(s_wallbuy.zombie_weapon_upgrade == "smg_standard")
		{
			s_wallbuy.origin = s_wallbuy.origin + vectorscale((0, 1, 0), 5);
		}
	}
	spawncollision("collision_bullet_wall_128x128x10", "collider", (1555, -1493, -293), vectorscale((0, 1, 0), 347.199));
	level._effect["powerup_on_red"] = "zombie/fx_powerup_on_red_zmb";
}

/*
	Name: main_end
	Namespace: zm_temple_ffotd
	Checksum: 0x4134D4A9
	Offset: 0x390
	Size: 0x46C
	Parameters: 0
	Flags: Linked
*/
function main_end()
{
	spawncollision("collision_clip_ramp_256x24", "collider", (-51.9, -1049.64, -253.5), (90, 10.25, 75.85));
	spawncollision("collision_clip_ramp_256x24", "collider", (-51.9, -1049.64, 2.5), (90, 10.25, 75.85));
	spawncollision("collision_clip_ramp_256x24", "collider", (-51.9, -1049.64, 258.5), (90, 10.25, 75.85));
	spawncollision("collision_clip_wedge_32x256", "collider", (44, -1020, -240), vectorscale((0, 1, 0), 180));
	spawncollision("collision_clip_wedge_32x256", "collider", (44, -1020, 16), vectorscale((0, 1, 0), 180));
	spawncollision("collision_clip_wedge_32x256", "collider", (44, -1020, 272), vectorscale((0, 1, 0), 180));
	spawncollision("collision_player_slick_32x32x128", "collider", (51.9385, -1035.86, -16.28), (316.299, 351.698, -90));
	spawncollision("collision_monster_128x128x128", "collider", (93.3531, -1041.94, 46), vectorscale((0, 1, 0), 351.397));
	spawncollision("collision_player_wall_512x512x10", "collider", (-1000, -1392, 122), vectorscale((1, 0, 0), 270));
	spawncollision("collision_player_wall_512x512x10", "collider", (-1112, -1560, 122), vectorscale((1, 0, 0), 270));
	spawncollision("collision_player_wall_512x512x10", "collider", (-1125.08, -859.956, -328), (270, 0.2, 21.5992));
	spawncollision("collision_player_wall_256x256x10", "collider", (-1048.47, -1100.99, -205.044), (6.5924E-06, 291.799, 90));
	spawncollision("collision_player_slick_wall_256x256x10", "collider", (1009.23, -1052.8, 1.965), (4.49303, 183.106, 0.243273));
	spawncollision("collision_player_slick_wedge_32x128", "collider", (-1655.5, -428, 8), vectorscale((1, 1, 0), 270));
	spawncollision("collision_player_slick_wall_128x128x10", "collider", (546.5, -499.5, -347), vectorscale((0, 1, 0), 3.79971));
	spawncollision("collision_player_slick_wall_128x128x10", "collider", (541, -439.5, -347), vectorscale((0, 1, 0), 6.299));
	
	ents = ArrayCombine(getentarray("sq_sundial", "targetname"), getentarray("sq_sundial_button", "targetname"), true, false);
	for(i = 0; i < ents.size; i++)
	{
		//only one dial entity is referenced by reset_sidequest etc.
		if(i == 0)
		{
			asset = level._zombie_sidequests["sq"].assets[i];
			asset.thread_func = &sundial_monitor;
			ent = ents[i];
			ent.thread_func = &sundial_monitor;
			asset.ent = ent;
			level._zombie_sidequests["sq"].assets[i] = asset;
		}
		else
		{
			asset = level._zombie_sidequests["sq"].assets[i];
			asset.thread_func = &sundial_button;
			ent = ents[i];
			ent.thread_func = &sundial_button;
			asset.ent = ent;
			level._zombie_sidequests["sq"].assets[i] = asset;
			//level._zombie_sidequests["sq"].assets[i].thread_func = &sundial_button;
			//level._zombie_sidequests["sq"].assets[i].ent.thread_func = &sundial_button;
		}
	}
	
	level thread reset_sidequest();
	
	level._zombie_sidequests["sq"].stages["OaFC"].logic_func = &stage_logic;
	
	structs = struct::get_array("sq_dgcwf_sw1", "targetname");
	ents = getentarray("sq_dgcwf_trig", "targetname");
	for(i = structs.size; i < structs.size + ents.size; i++)
	{
		level._zombie_sidequests["sq"].stages["DgCWf"].assets[i].thread_func = &plate_trigger;
	}
	
	structs = struct::get_array("sq_sad_trig", "targetname");
	for(i = 0; i < structs.size; i++)
		level._zombie_sidequests["sq"].stages["StD"].assets[i].thread_func = &spikemore_plug_hole;
	
	if(GetDvarInt("mutator_slide_dive") == 2)
		array::thread_all(level.mazecells, &maze_cell_watch);
}

function maze_cell_watch()
{
	level endon("fake_death");
	while(true)
	{
		self.trigger waittill("trigger", who);
		if(self.trigger.pathcount > 0)
		{
			if(isplayer(who))
			{
				if(who is_player_maze_slow())
				{
					continue;
				}
				if(who.sessionstate == "spectator")
				{
					continue;
				}
			}
		}
		else
		{
			if(isplayer(who))
			{
				if(who is_player_on_path())
				{
					continue;
				}
				if(who.sessionstate == "spectator")
				{
					continue;
				}
				self.trigger thread watch_slow_trigger_exit(who);
			}
		}
	}
}

function is_player_on_path()
{
	return isdefined(self.mazepathcells) && self.mazepathcells.size > 0;
}

function watch_slow_trigger_exit(player)
{
	player endon("death");
	player endon("fake_death");
	player endon("disconnect");
	while(self.pathcount == 0 && player istouching(self))
	{
		wait(0.1);
	}
	if(!player is_player_maze_slow())
		player allowslide(0);
}

function is_player_maze_slow()
{
	return isdefined(self.mazeslowtrigger) && self.mazeslowtrigger.size > 0;
}

function sundial_button()
{
	level endon("stage_starting");
	level endon("kill_buttons");
	if(!isdefined(self.dont_rethread))
	{
		self.dont_rethread = 1;
		self.on_pos = self.origin - anglestoup(self.angles);
		self.off_pos = self.on_pos - (anglestoup(self.angles) * 5.5);
		self moveto(self.off_pos, 0.01);
	}
	if(isdefined(self.trigger))
	{
		self.trigger delete();
		self.trigger = undefined;
	}
	self.triggering_player = undefined;
	level flag::wait_till("power_on");
	self moveto(self.on_pos, 0.25);
	wait(0.25);
	buttons = getentarray("sq_sundial_button", "targetname");
	offset = (anglestoforward(self.angles) * 5) - vectorscale((0, 0, 1), 16);
	self.trigger = spawn("trigger_radius_use", self.on_pos + offset, 0, 48, 32);
	self.trigger triggerignoreteam();
	self.trigger.radius = 48;
	self.trigger setcursorhint("HINT_NOICON");
	while(true)
	{
		self.trigger waittill("trigger", who);
		if(sundial_button_already_pressed_by(who, buttons))
		{
			continue;
		}
		if(!level._stage_active && level._buttons_can_reset)
		{
			self.triggering_player = who;
			level._sundial_buttons_pressed++;
			self playsound("evt_sq_gen_button");
			self moveto(self.off_pos, 0.25);
			delay = 1;
			if(getplayers().size < 4)
			{
				delay = 10;
			}
			wait(delay);
			while(level._sundial_active)
			{
				wait(0.1);
			}
			self.triggering_player = undefined;
			self moveto(self.on_pos, 0.25);
			if(level._sundial_buttons_pressed > 0)
			{
				level._sundial_buttons_pressed--;
			}
		}
	}
}

function sundial_button_already_pressed_by(who, buttons)
{
	if(getplayers().size < 4)
	{
		return false;
	}
	for(i = 0; i < buttons.size; i++)
	{
		if(isdefined(buttons[i].triggering_player) && buttons[i].triggering_player == who)
		{
			return true;
		}
	}
	return false;
}

function reset_sidequest()
{
	sidequest = level._zombie_sidequests["sq"];
	level flag::wait_till("radio_9_played");
	while(level flag::get("doing_bounce_around"))
	{
		wait(0.1);
	}
	stage_names = getarraykeys(sidequest.stages);
	for(i = 0; i < stage_names.size; i++)
	{
		sidequest.stages[stage_names[i]].completed = 0;
	}
	sidequest.last_completed_stage = -1;
	sidequest.active_stage = -1;
	level flag::clear("radio_7_played");
	level flag::clear("radio_9_played");
	level flag::clear("trap_destroyed");
	randomize_gongs();
	crystals = getentarray("sq_crystals", "targetname");
	for(i = 0; i < crystals.size; i++)
	{
		if(isdefined(crystals[i].trigger))
		{
			crystals[i].trigger delete();
			crystals[i] delete();
		}
	}
	dynamite = getent("dynamite", "targetname");
	dynamite delete();
	buttons = getentarray("sq_sundial_button", "targetname");
	for(i = 0; i < buttons.size; i++)
	{
		if(isdefined(buttons[i].trigger))
		{
			buttons[i].trigger delete();
			buttons[i].trigger = undefined;
		}
	}
	start_temple_sidequest();
	dial = getent("sq_sundial", "targetname");
	dial thread sundial_monitor();
}

function randomize_gongs()
{
	gongs = getentarray("sq_gong", "targetname");
	gongs = array::randomize(gongs);
	for(i = 0; i < gongs.size; i++)
	{
		if(i < 4)
		{
			gongs[i].right_gong = 1;
			continue;
		}
		gongs[i].right_gong = 0;
	}
}

function start_temple_sidequest()
{
	//hide_meteor();
	level flag::wait_till("initial_players_connected");
	zm_sidequests::sidequest_start("sq");
}

/*function hide_meteor()
{
	ent = getent("sq_meteorite", "targetname");
	if(isdefined(ent))
	{
		ent ghost();
		exploder::stop_exploder("fxexp_518");
	}
}*/

function sundial_monitor()
{
	level endon("reset_sundial");
	level endon("end_game");
	self.dont_rethread = 1;
	self thread restart_sundial_monitor();
	if(!isdefined(self.original_pos))
	{
		self.original_pos = self.origin - anglestoup(self.angles);
		self.off_pos = self.original_pos - (anglestoup(self.angles) * 34);
	}
	self.origin = self.off_pos;
	level._sundial_buttons_pressed = 0;
	level._stage_active = 0;
	level._sundial_active = 0;
	level flag::wait_till("power_on");
	level notify("kill_buttons");
	wait(0.05);
	buttons = getentarray("sq_sundial_button", "targetname");
	array::thread_all(buttons, &sundial_button);
	while(true)
	{
		while(level._sundial_buttons_pressed < 4)
		{
			wait(0.1);
		}
		level._sundial_active = 1;
		self playsound("evt_sq_gen_transition_start");
		self playsound("evt_sq_gen_sundial_emerge");
		self moveto(self.original_pos, 0.25);
		self waittill("movedone");
		self thread spin_dial();
		wait(0.5);
		stage = zm_sidequests::sidequest_start_next_stage("sq");
		level notify("stage_starting");
		amount = 8.5;
		level waittill("timed_stage_75_percent");
		self playsound("evt_sq_gen_sundial_timer");
		self moveto(self.origin - (anglestoup(self.angles) * amount), 1);
		self thread short_dial_spin();
		level waittill("timed_stage_50_percent");
		self playsound("evt_sq_gen_sundial_timer");
		self moveto(self.origin - (anglestoup(self.angles) * amount), 1);
		self thread short_dial_spin();
		level waittill("timed_stage_25_percent");
		self playsound("evt_sq_gen_sundial_timer");
		self moveto(self.origin - (anglestoup(self.angles) * amount), 1);
		self thread short_dial_spin();
		level waittill("timed_stage_10_seconds_to_go");
		self thread play_one_second_increments();
		self moveto(self.origin - (anglestoup(self.angles) * amount), 10);
		self thread spin_dial();
		self waittill("movedone");
		level._sundial_active = 0;
		wait(0.1);
	}
}

function restart_sundial_monitor()
{
	level endon("kill_sundial_monitor");
	level waittill("reset_sundial");
	wait(0.1);
	self thread sundial_monitor();
}

function spin_dial(duration = 2, multiplier = 1.3)
{
	spin_time = 0.1;
	while(spin_time < duration)
	{
		self playloopsound("evt_sq_gen_sundial_spin", 0.5);
		self rotatepitch(180, spin_time);
		wait(spin_time * 0.95);
		spin_time = spin_time * multiplier;
	}
	self stoploopsound(2);
}

function short_dial_spin()
{
	spin_dial(1, 1.6);
}

function play_one_second_increments()
{
	level endon("sidequest_sq_complete");
	level endon("reset_sundial");
	while(level._sundial_active == 1)
	{
		self playsound("evt_sq_gen_sundial_timer");
		wait(1);
	}
}

function stage_logic()
{
	level flag::wait_till("oafc_switch_pressed");
	if(getplayers().size == 1)
	{
		wait(20);
		level notify("suspend_timer");
		level notify("raise_crystal_1", 1);
		//level waittill("hash_64e9e78e");
		//level flag::wait_till("oafc_plot_vo_done");
		//wait(5);
		zm_sidequests::stage_completed("sq", "OaFC");
		return;
	}
}

function plate_counter()
{
	self endon("death");
	var_b4264aa6 = getplayers().size;
	while(true)
	{
		if(level._on_plate >= (var_b4264aa6 - 1) && !level flag::get("dgcwf_on_plate"))
		{
			level flag::set("dgcwf_on_plate");
		}
		else if(level flag::get("dgcwf_on_plate") && level._on_plate < (var_b4264aa6 - 1))
		{
			level flag::clear("dgcwf_on_plate");
		}
		wait(0.05);
	}
}

function restart_plate_mon(trig)
{
	trig endon("death");
	level endon("sq_dgcwf_over");
	self waittill("spawned_player");
	self thread plate_monitor(trig);
}

function plate_monitor(trig)
{
	self endon("disconnect");
	trig endon("death");
	level endon("sq_dgcwf_over");
	while(true)
	{
		while(!self istouching(trig))
		{
			wait(0.1);
		}
		if(level._on_plate < 4)
		{
			level._on_plate++;
		}
		trig playsound("evt_sq_dgcwf_plate_" + level._on_plate);
		if(level._on_plate <= 2 && !level flag::get("dgcwf_sw1_pressed"))
		{
			self thread zm_audio::create_and_play_dialog("eggs", "quest2", 0);
		}
		else
		{
			self thread zm_audio::create_and_play_dialog("eggs", "quest2", 1);
		}
		while(self istouching(trig) && self.sessionstate != "spectator")
		{
			wait(0.05);
		}
		if(level._on_plate >= 0)
		{
			level._on_plate--;
		}
		if(self.sessionstate == "spectator")
		{
			self thread restart_plate_mon(trig);
			return;
		}
		if(level._on_plate < 3 && !level flag::get("dgcwf_sw1_pressed"))
		{
			self thread zm_audio::create_and_play_dialog("eggs", "quest2", 2);
		}
	}
}

function plate_trigger()
{
	self endon("death");
	self thread play_success_audio();
	self thread begin_dgcwf_vox();
	level.var_9fb9bcda = spawn("script_origin", self.origin);
	level.var_9fb9bcda playloopsound("evt_sq_dgcwf_waterthrash_loop", 2);
	if(getplayers().size == 1)
	{
		level flag::set("dgcwf_on_plate");
		return;
	}
	self thread plate_counter();
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		players[i] thread plate_monitor(self);
	}
}

function begin_dgcwf_vox()
{
	self endon("death");
	while(true)
	{
		self waittill("trigger", who);
		if(isplayer(who))
		{
			self stoploopsound(1);
			level.var_9fb9bcda stoploopsound(1);
			level.var_9fb9bcda delete();
			who thread dgcwf_story_vox();
			return;
		}
		wait(0.05);
	}
}

function play_success_audio()
{
	level endon("sq_dgcwf_over");
	level flag::wait_till("dgcwf_on_plate");
	level flag::wait_till("dgcwf_sw1_pressed");
	playsoundatposition("evt_sq_dgcwf_gears", self.origin);
}

function dgcwf_story_vox()
{
	level endon("sq_dgcwf_over");
	struct = struct::get("sq_location_dgcwf", "targetname");
	if(!isdefined(struct))
	{
		return;
	}
	level._dgcwf_sound_ent = spawn("script_origin", struct.origin);
	if(isdefined(self))
	{
		level.skit_vox_override = 1;
		self playsoundwithnotify("vox_egg_story_2_0" + function_26186755(self.characterindex), "vox_egg_sounddone");
		self waittill("vox_egg_sounddone");
		level.skit_vox_override = 0;
	}
	level._dgcwf_sound_ent playsoundwithnotify("vox_egg_story_2_1", "sounddone");
	level._dgcwf_sound_ent waittill("sounddone");
	if(isdefined(self))
	{
		level.skit_vox_override = 1;
		self playsoundwithnotify("vox_egg_story_2_2" + function_26186755(self.characterindex), "vox_egg_sounddone");
		self waittill("vox_egg_sounddone");
		level.skit_vox_override = 0;
	}
	level flag::wait_till("dgcwf_sw1_pressed");
	level._dgcwf_sound_ent playsoundwithnotify("vox_egg_story_2_3", "sounddone");
	level._dgcwf_sound_ent waittill("sounddone");
	level flag::set("dgcwf_plot_vo_done");
	level._dgcwf_sound_ent delete();
	level._dgcwf_sound_ent = undefined;
}

function spikemore_plug_hole()
{
	if(!isdefined(level.var_b19e3661))
	{
		level.var_b19e3661 = 0;
	}
	level.var_68e59898 = 1;
	self thread begin_std_story_vox();
	self thread player_hint_line();
	self thread player_first_success();
	self playsound("evt_sq_std_spray_start");
	self playloopsound("evt_sq_std_spray_loop", 1);
	trigger = spawn("trigger_damage", self.origin, 0, 32, 32);
	trigger.angles = self.angles + (0, 90, 90);
	if(isdefined(world.claymore) && world.claymore)
		self waittill("spiked", who);
	else
	{
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
	}
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