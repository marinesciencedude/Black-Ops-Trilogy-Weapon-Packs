#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_utility;

#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_powerup_weapon_minigun;
#using scripts\shared\trigger_shared;

#namespace zm_cosmodrome_ffotd;

/*
	Name: main_start
	Namespace: zm_cosmodrome_ffotd
	Checksum: 0x99EC1590
	Offset: 0x2B0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function main_start()
{
}

/*
	Name: main_end
	Namespace: zm_cosmodrome_ffotd
	Checksum: 0x16DF7916
	Offset: 0x2C0
	Size: 0x5E4
	Parameters: 0
	Flags: Linked
*/
function main_end()
{
	spawncollision("collision_player_64x64x256", "collider", (189.68, 666.753, -208), vectorscale((0, 1, 0), 45.4));
	spawncollision("collision_player_wall_64x64x10", "collider", (-48, 1135, -454), vectorscale((0, 1, 0), 270));
	spawncollision("collision_player_wall_64x64x10", "collider", (-48, 1135, -390), vectorscale((0, 1, 0), 270));
	spawncollision("collision_player_wall_64x64x10", "collider", (-48, 1135, -334), vectorscale((0, 1, 0), 270));
	spawncollision("collision_player_wall_64x64x10", "collider", (-104, 1135, -454), vectorscale((0, 1, 0), 270));
	spawncollision("collision_player_wall_64x64x10", "collider", (-104, 1135, -390), vectorscale((0, 1, 0), 270));
	spawncollision("collision_player_wall_64x64x10", "collider", (-104, 1135, -334), vectorscale((0, 1, 0), 270));
	spawncollision("collision_player_wall_512x512x10", "collider", (-1803.5, 1895, 333), (0, 0, 0));
	spawncollision("collision_player_wall_512x512x10", "collider", (-1815.5, 1743, 333), (0, 0, 0));
	spawncollision("collision_player_wall_512x512x10", "collider", (-1822.5, 1881, 333), (0, 0, 0));
	spawncollision("collision_player_wall_512x512x10", "collider", (-1822.5, 1755, 333), (0, 0, 0));
	spawncollision("collision_player_wedge_32x256", "collider", (-1541, 1648, 156), vectorscale((0, 1, 0), 180));
	spawncollision("collision_player_wall_512x512x10", "collider", (-1303.83, 1560.5, 353), vectorscale((0, 1, 0), 111.398));
	spawncollision("collision_player_wall_512x512x10", "collider", (-1254, 1717.5, 353), (0, 0, 0));
	spawncollision("collision_player_wall_512x512x10", "collider", (-883, 2232, 5), (0, 0, 0));
	spawncollision("collision_player_wall_256x256x10", "collider", (-883, 1728, -44), (0, 0, 0));
	spawncollision("collision_player_wall_512x512x10", "collider", (158, 2172, 5), (0, 0, 0));
	spawncollision("collision_player_ramp_256x24", "collider", (151, 1768, -40), (270, 82.546, 97.454));
	spawncollision("collision_player_ramp_256x24", "collider", (151, 1738, -40), (270, 82.546, 97.454));
	spawncollision("collision_player_64x64x256", "collider", (-742.002, 866.631, 348), vectorscale((0, 1, 0), 334.8));
	spawncollision("collision_player_64x64x256", "collider", (-760.949, 1008.22, 460.75), vectorscale((0, 1, 0), 334.2));
	spawncollision("collision_player_wall_256x256x10", "collider", (84, -173.5, -44), vectorscale((0, 1, 0), 270));
	e_temp = spawncollision("collision_clip_wall_128x128x10", "collider", (-72, 1136, -421.5), vectorscale((0, 1, 0), 270));
	e_temp disconnectpaths();
	spawncollision("collision_clip_wall_128x128x10", "collider", (-72, 1136, -373.5), vectorscale((0, 1, 0), 270));
	
	level.var_b505a146 = array("h", "i", "t", "s", "a", "m");
	level.var_66e412e8 = 0;
	level.var_8f0326dd = array("h", "y", "e", "n", "a");
	level.var_fd63aa69 = 0;
	
	level thread switch_override();
	level thread lander_monitor();
	level thread weapon_combo_override();
	level thread replace_redphones();
}

function replace_redphones()
{
	redphones = struct::get_array("egg_phone", "targetname");
	if(GetDvarInt("mutator_redphone") == 2)
		level.phonesounds = array(0, 1, 2);
	else
		level.phonesounds = array(0, 1, 2, 3, 4, 5, 6, 7, 8);
	array::thread_all(redphones, &replacephone);
}

function replacephone()
{
	while(!isdefined(self.broken) /*&& self.broken*/)
	{
		self waittill("phone_activated");
		soundtoplay = array::random(level.phonesounds);
		arrayremovevalue(level.phonesounds, soundtoplay);
		if(level.phonesounds.size <= 0 && GetDvarInt("mutator_redphone") == 2)
		{
			level.phonesounds = array(0, 1, 2);
		}
		else if(level.phonesounds.size <= 0)
		{
			level.phonesounds = array(0, 1, 2, 3, 4, 5, 6, 7, 8);
		}
		if(GetDvarInt("mutator_redphone") == 2)
			playsoundatposition("vox_egg_redphone_original_" + soundtoplay, self.origin);
		else
			playsoundatposition("vox_egg_redphone_chronicles_" + soundtoplay, self.origin);
	}
}

function switch_override()
{
	level flag::wait_till("rerouted_power");
	while(!level flag::get("switches_synced"))
	{
		level flag::wait_till("monkey_round");
		if(getplayers().size < 4)
		{
			self thread switch_watcher();
		}
		level util::waittill_either("between_round_over", "switches_synced");
	}
}

function switch_watcher()
{
	level endon("between_round_over");
	pressed = 0;
	switches = struct::get_array("sync_switch_start", "targetname");
	while(true)
	{
		level waittill("sync_button_pressed");
		pressed = 0;
		timeout = gettime() + 500;
		//unnecessary check but whatever
		if(getplayers().size < 4)
		{
			timeout = timeout + 100000;
		}
		already_pressed = [];
		already_pressed[0] = false;
		already_pressed[1] = false;
		already_pressed[2] = false;
		already_pressed[3] = false;
		while(gettime() < timeout)
		{
			for(i = 0; i < switches.size; i++)
			{
				if(isdefined(switches[i].pressed) && switches[i].pressed && !already_pressed[i])
				{
					already_pressed[i] = true;
					pressed++;
				}
			}
			if(pressed == 4)
			{
				level flag::set("switches_synced");
				level notify("switches_synced");
				for(i = 0; i < switches.size; i++)
				{
					playsoundatposition("zmb_ee_syncbutton_success", switches[i].origin);
				}
				return;
			}
			wait(0.05);
		}
		switch(pressed)
		{
			case 1:
			case 2:
			case 3:
			{
				for(i = 0; i < switches.size; i++)
				{
					playsoundatposition("zmb_ee_syncbutton_deny", switches[i].origin);
				}
				break;
			}
		}
		for(i = 0; i < switches.size; i++)
		{
			switches[i].pressed = 0;
		}
	}
}

function lander_monitor()
{
	level flag::wait_till("pressure_sustained");
	lander = getent("lander", "targetname");
	while(!level flag::get("passkey_confirmed"))
	{
		level waittill("lander_launched");
		if(lander.called)
		{
			start = lander.depart_station;
			dest = lander.station;
			letter = level.lander_key[start][dest];
			model = level.lander_letters[letter];
			trig = spawn("trigger_radius", model.origin, 0, 200, 150);
			trig thread letter_grab(letter, model, lander);
			/*for(i = 0; i < trig.size; i ++)
			{
				if(trig[i].origin == model.origin)
				{
					trig[i] thread letter_grab(letter, model, lander);
					return;
				}
			}*/
		}
	}
}
	
function letter_grab(letter, model, lander)
{
	level endon("lander_grounded");
	if(getplayers().size == 1)
	{
		while(distancesquared(lander.origin, self.origin) > 40000)
			wait(0.1); //probably irresponsible, ran out of ideas
		level flag::set("letter_acquired");
		playsoundatposition("zmb_powerup_grabbed", model.origin);
		model ghost();
		if(letter == level.passkey[level.passkey_progress])
		{
			level.passkey_progress++;
			if(level.passkey_progress == level.passkey.size)
			{
				level flag::set("passkey_confirmed");
			}
		}
		else
		{
			level.passkey_progress = 0;
		}
	}
}

function weapon_combo_override()
{
	level flag::wait_till("passkey_confirmed");
	while(!level flag::get("weapons_combined"))
	{
		level.black_hole_bomb_loc_check_func = &bhb_combo_loc_check;
		self waittill("grenade_fire", grenade, weapon);
		if(weapon == level.w_black_hole_bomb)
		{
			grenade function_510c4845();
		}
	}
}

function bhb_combo_loc_check(grenade, model, info)
{
	if(isdefined(level.black_hold_bomb_target_trig) && grenade istouching(level.black_hold_bomb_target_trig))
	{
		grenade function_510c4845();
	}
	return false;
}

function function_510c4845()
{
	trig = spawn("trigger_damage", self.origin, 0, 15, 72);
	self thread wait_for_combo(trig);
}

function wait_for_combo(trig)
{
	self endon("death");
	self thread kill_trig_on_death(trig);
	weapon_combo_spot = struct::get("weapon_combo_spot", "targetname");
	ray_gun_hit = 0;
	doll_hit = 0;
	if(getplayers().size == 1)
	{
		doll_hit = 1;
	}
	players = getplayers();
	array::thread_all(players, &thundergun_check, self, trig, weapon_combo_spot);
	while(true)
	{
		trig waittill("damage", amount, inflictor, direction, point, type, tagname, modelname, partname, weapon);
		if(isdefined(inflictor))
		{
			if(type == "MOD_PROJECTILE" && (weapon.name == "ray_gun_upgraded" || weapon.name == "raygun_mark2_upgraded"))
			{
				ray_gun_hit = 1;
			}
			else if(weapon.name == "nesting_dolls" || weapon.name == "nesting_dolls_single")
			{
				doll_hit = 1;
			}
			if(ray_gun_hit && doll_hit && level flag::get("thundergun_hit"))
			{
				level flag::set("weapons_combined");
				level thread soul_release(self, trig.origin);
				return;
			}
		}
	}
}

function thundergun_check(model, trig, weapon_combo_spot)
{
	model endon("death");
	while(true)
	{
		self waittill("weapon_fired");
		var_ca8d49bb = self getcurrentweapon();
		if(var_ca8d49bb.name == "thundergun_upgraded")
		{
			if(distancesquared(self.origin, weapon_combo_spot.origin) < 90000)
			{
				vector_to_spot = vectornormalize(weapon_combo_spot.origin - self getweaponmuzzlepoint());
				vector_player_facing = self getweaponforwarddir();
				angle_diff = acos(vectordot(vector_to_spot, vector_player_facing));
				if(angle_diff <= 20)
				{
					self function_30d8de55(trig);
				}
			}
		}
	}
}

function function_30d8de55(trig)
{
	level flag::set("thundergun_hit");
	radiusdamage(trig.origin, 5, 1, 1, self);
}

function kill_trig_on_death(trig)
{
	self waittill("death");
	trig delete();
	if(level flag::get("thundergun_hit") && !level flag::get("weapons_combined"))
	{
		level thread play_egg_vox("vox_ann_egg6p1_success", "vox_gersh_egg6_fail2", 7);
	}
	else if(!level flag::get("weapons_combined"))
	{
		level thread play_egg_vox(undefined, "vox_gersh_egg6_fail1", 6);
	}
	level flag::clear("thundergun_hit");
}

function soul_release(model, origin)
{
	soul = spawn("script_model", origin);
	soul setmodel("tag_origin");
	soul playloopsound("zmb_egg_soul");
	fx = playfxontag(level._effect["gersh_spark"], soul, "tag_origin");
	time = 20;
	model waittill("death");
	level thread play_egg_vox("vox_ann_egg6_success", "vox_gersh_egg6_success", 9);
	level thread wait_for_gersh_vox();
	soul movez(2500, time, time - 1);
	wait(time);
	soul delete();
	wait(2);
	level thread samantha_is_angry();
}

function wait_for_gersh_vox()
{
	wait(12.5);
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		players[i] thread reward_wait();
	}
}

function reward_wait()
{
	while(!zombie_utility::is_player_valid(self) || (self usebuttonpressed() && self zm_utility::in_revive_trigger()))
	{
		wait(1);
	}
	if(!self bgb::is_enabled("zm_bgb_disorderly_combat"))
	{
		level thread zm_powerup_weapon_minigun::minigun_weapon_powerup(self, 90);
	}
	self zm_utility::give_player_all_perks();
}

function play_egg_vox(ann_alias, gersh_alias, plr_num)
{
	if(isdefined(ann_alias))
	{
		level play_cosmo_announcer_vox(ann_alias);
	}
	if(isdefined(plr_num))
	{
		players = getplayers();
		rand = randomintrange(0, players.size);
		players[rand] playsoundwithnotify((("vox_plr_" + players[rand].characterindex) + "_level_start_") + randomintrange(0, 4), "level_start_vox_done");
		players[rand] waittill("level_start_vox_done");
	}
	if(isdefined(gersh_alias))
	{
		level play_gersh_vox(gersh_alias);
	}
	if(isdefined(plr_num))
	{
		players = getplayers();
		rand = randomintrange(0, players.size);
		players[rand] zm_audio::create_and_play_dialog("eggs", "gersh_response", plr_num);
	}
}

function samantha_is_angry()
{
	playsoundatposition("zmb_samantha_earthquake", (0, 0, 0));
	playsoundatposition("zmb_samantha_whispers", (0, 0, 0));
	wait(6);
	level clientfield::set("COSMO_EGG_SAM_ANGRY", 1);
	playsoundatposition("zmb_samantha_scream", (0, 0, 0));
	wait(6);
	level clientfield::set("COSMO_EGG_SAM_ANGRY", 0);
}

function play_cosmo_announcer_vox(alias, alarm_override, wait_override)
{
	if(!isdefined(alias))
	{
		return;
	}
	if(!isdefined(level.cosmann_is_speaking))
	{
		level.cosmann_is_speaking = 0;
	}
	if(!isdefined(alarm_override))
	{
		alarm_override = 0;
	}
	if(!isdefined(wait_override))
	{
		wait_override = 0;
	}
	if(level.cosmann_is_speaking == 0 && wait_override == 0)
	{
		level.cosmann_is_speaking = 1;
		if(!alarm_override)
		{
			level play_initial_alarm();
		}
		level zm_utility::really_play_2d_sound(alias);
		level.cosmann_is_speaking = 0;
	}
	else if(wait_override == 1)
	{
		level zm_utility::really_play_2d_sound(alias);
	}
}

function play_initial_alarm()
{
	structs = struct::get_array("amb_warning_siren", "targetname");
	wait(1);
	for(i = 0; i < structs.size; i++)
	{
		playsoundatposition("evt_cosmo_alarm_single", structs[i].origin);
	}
	wait(0.5);
}

function play_gersh_vox(alias)
{
	if(!isdefined(alias))
	{
		return;
	}
	if(!isdefined(level.gersh_is_speaking))
	{
		level.gersh_is_speaking = 0;
	}
	if(level.gersh_is_speaking == 0)
	{
		level.gersh_is_speaking = 1;
		level zm_utility::really_play_2d_sound(alias);
		level.gersh_is_speaking = 0;
	}
}