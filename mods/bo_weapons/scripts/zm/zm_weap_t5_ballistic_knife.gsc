#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_melee_weapon;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_stats;
#using scripts\shared\system_shared;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;

#insert scripts\shared\version.gsh;
#insert scripts\shared\shared.gsh;
#insert scripts\zm\_zm_utility.gsh;
#insert scripts\zm\zm_weap_t5_ballistic_knife.gsh;

#namespace zm_weap_t5_ballistic_knife;

REGISTER_SYSTEM_EX( "zm_weap_t5_ballistic_knife", &__init__, &__main__, undefined )

#precache( "model", 	"PROJECTILE_MODEL" );
#precache( "model", 	"PROJECTILE_MODEL_UPGRADED" );
#precache( "model", 	"PROJECTILE_MODEL_GLOW" );
#precache( "string", 	"PICKUP_HINT_STRING");

function __init__()
{
	level.weapBallisticKnife 					= GetWeapon( "t5_bk_base_normal_bo1" );
	level.weapBallisticKnifeUpgraded 			= GetWeapon( "t5_bk_base_upgraded_bo1" );
	level.weapBallisticKnifeWithBowie			= GetWeapon( "t5_bk_bowie_normal_bo1" );
	level.weapBallisticKnifeWithBowieUpgraded 	= GetWeapon( "t5_bk_bowie_upgraded_bo1" );
	level.weapBallisticKnifeWithSickle			= GetWeapon( "t5_bk_sickle_normal_bo1" );
	level.weapBallisticKnifeWithSickleUpgraded	= GetWeapon( "t5_bk_sickle_upgraded_bo1" );
	
	callback::on_spawned( &bkWatcher );	
}

function __main__()
{	
	thread melee_logic();
}

//Wallbuy setup
function melee_logic(){
	level flag::wait_till("initial_blackscreen_passed");
	
	melee_weapon_structs = struct::get_array("bowie_upgrade", "targetname");
	if(melee_weapon_structs.size)
	{
		zm_melee_weapon::init("t5_bk_bowie_wallbuy", "t5_bk_bowie_flourish", "t5_bk_bowie_normal_bo1", "t5_bk_bowie_upgraded_bo1", 3000, "bowie_upgrade", &"ZOMBIE_WEAPONCOSTONLY_CFILL", "bowie", undefined);
		zm_melee_weapon::set_fallback_weapon("bowie_knife", "t5_bk_bowie_fists_zm");

		// patch the stub trigger_func
		for(i = 0; i < melee_weapon_structs.size; i++)
		{
			melee_weapon_structs[i].zombie_weapon_upgrade = "t5_bk_bowie_wallbuy";
			if(isdefined(melee_weapon_structs[i].trigger_stub))
			{
				melee_weapon_structs[i].trigger_stub.trigger_func = &my_melee_weapon_think;
			}
		}
	}
	melee_weapon_structs = struct::get_array("sickle_upgrade", "targetname");
	if(melee_weapon_structs.size)
	{
		zm_melee_weapon::init("t5_bk_sickle_wallbuy", "t5_bk_sickle_flourish", "t5_bk_sickle_normal_bo1", "t5_bk_sickle_upgraded_bo1", 3000, "sickle_upgrade", &"ZOMBIE_WEAPONCOSTONLY_CFILL", "sickle", undefined);
		zm_melee_weapon::set_fallback_weapon("sickle_knife", "t5_bk_sickle_fists_zm");
		
		// patch the stub trigger_func
		for(i = 0; i < melee_weapon_structs.size; i++)
		{
			melee_weapon_structs[i].zombie_weapon_upgrade = "t5_bk_sickle_wallbuy";
			if(isdefined(melee_weapon_structs[i].trigger_stub))
			{
				melee_weapon_structs[i].trigger_stub.trigger_func = &my_melee_weapon_think;
			}
		}
	}
}
function my_melee_weapon_think( weapon, cost, flourish_fn, vo_dialog_id, flourish_weapon, ballistic_weapon, ballistic_upgraded_weapon ){
	self.first_time_triggered = false;
	if ( isdefined( self.stub ) )
	{
		self endon( "kill_trigger" );
		if ( isdefined( self.stub.first_time_triggered ) )
		{
			self.first_time_triggered = self.stub.first_time_triggered;
		}

		weapon = self.stub.weapon;
		cost = self.stub.cost;
		flourish_fn = self.stub.flourish_fn;
		vo_dialog_id = self.stub.vo_dialog_id;
		flourish_weapon = self.stub.flourish_weapon;
		ballistic_weapon = self.stub.ballistic_weapon;
		ballistic_upgraded_weapon = self.stub.ballistic_upgraded_weapon;

		players = GetPlayers();

		if ( !IS_TRUE( level._allow_melee_weapon_switching ) )
		{
			for ( i = 0; i < players.size; i++ )
			{
				if ( !players[i] zm_melee_weapon::player_can_see_weapon_prompt() )
				{
					self SetInvisibleToPlayer( players[i] );
				}
			}
		}
	}

	for ( ;; )
	{
		self waittill( "trigger", player );

		if ( !zm_utility::is_player_valid( player ) )
		{
			player thread zm_utility::ignore_triggers( 0.5 );
			continue;
		}

		if ( player zm_utility::in_revive_trigger() )
		{
			wait( 0.1 );
			continue;
		}

		if ( player isThrowingGrenade() )
		{
			wait( 0.1 );
			continue;
		}

		if ( IS_DRINKING( player.is_drinking ) )
		{
			wait( 0.1 );
			continue;
		}

		player_has_weapon = player HasWeapon( weapon );
		if ( player_has_weapon || player zm_utility::has_powerup_weapon() )
		{
			wait( 0.1 );
			continue;
		}

		if ( player isSwitchingWeapons() )
		{
			wait( 0.1 );
			continue;
		}

		current_weapon = player GetCurrentWeapon();
		if ( zm_utility::is_placeable_mine( current_weapon ) || zm_equipment::is_equipment( current_weapon ) )
		{
			wait( 0.1 );
			continue;
		}

		if ( player laststand::player_is_in_laststand() || IS_TRUE( player.intermission ) )
		{
			wait( 0.1 );
			continue;
		}

		if ( IsDefined( player.check_override_melee_wallbuy_purchase ) )
		{
			if ( player [[player.check_override_melee_wallbuy_purchase]]( vo_dialog_id, flourish_weapon, weapon, ballistic_weapon, ballistic_upgraded_weapon, flourish_fn, self ) )
			{
				continue;
			}
		}

		if ( !player_has_weapon )
		{
			cost = self.stub.cost;

			if ( player zm_score::can_player_purchase( cost ) )
			{
				if ( self.first_time_triggered == false )
				{
					model = getent( self.target, "targetname" );

					if ( isdefined( model ) )
					{
						model thread zm_melee_weapon::melee_weapon_show( player );
					}
					else if ( isdefined( self.clientFieldName ) )
					{
						level clientfield::set( self.clientFieldName, 1 );
					}

					self.first_time_triggered = true;
					if ( isdefined( self.stub ) )
					{
						self.stub.first_time_triggered = true;
					}
				}

				player zm_score::minus_to_player_score( cost );
				player thread my_give_melee_weapon( vo_dialog_id, flourish_weapon, weapon, ballistic_weapon, ballistic_upgraded_weapon, flourish_fn, self );
			}
			else
			{
				zm_utility::play_sound_on_ent( "no_purchase" );
				player zm_audio::create_and_play_dialog( "general", "outofmoney", 1 );
			}
		}
		else
		{
			if ( !IS_TRUE( level._allow_melee_weapon_switching ) )
			{
				self SetInvisibleToPlayer( player );
			}
		}
	}
}
function my_give_melee_weapon( vo_dialog_id, flourish_weapon, weapon, ballistic_weapon, ballistic_upgraded_weapon, flourish_fn, trigger ){
	if ( isdefined( flourish_fn ) )
	{
		self thread [[flourish_fn]]();
	}

	original_weapon = self zm_melee_weapon::do_melee_weapon_flourish_begin( flourish_weapon );
	self zm_audio::create_and_play_dialog( "weapon_pickup", vo_dialog_id );

	self util::waittill_any( "fake_death", "death", "player_downed", "weapon_change_complete" );

	self my_do_melee_weapon_flourish_end( original_weapon, flourish_weapon, weapon, ballistic_weapon, ballistic_upgraded_weapon );

	if ( self laststand::player_is_in_laststand() || IS_TRUE( self.intermission ) )
	{
		return;
	}

	if ( !IS_TRUE( level._allow_melee_weapon_switching ) )
	{
		if ( IsDefined( trigger ) )
		{
			trigger SetInvisibleToPlayer( self );
		}
		self zm_melee_weapon::trigger_hide_all();
	}
}
function my_do_melee_weapon_flourish_end( original_weapon, flourish_weapon, weapon, ballistic_weapon, ballistic_upgraded_weapon ){
	Assert( !original_weapon.isPerkBottle );
	Assert( original_weapon != level.weaponReviveTool );

	self zm_utility::enable_player_move_states();

	if ( self laststand::player_is_in_laststand() || IS_TRUE( self.intermission ) )
	{
		self TakeWeapon( weapon );
		self.lastActiveWeapon = level.weaponNone;
		return;
	}

	self TakeWeapon( flourish_weapon );

	self zm_weapons::give_build_kit_weapon( weapon );
	original_weapon = my_change_melee_weapon( weapon, original_weapon );

	if ( self HasWeapon( level.weaponBaseMelee ) )
	{
		self TakeWeapon( level.weaponBaseMelee );
	}

	if ( self zm_utility::is_multiple_drinking() )
	{
		self zm_utility::decrement_is_drinking();
		return;
	}
	else if ( original_weapon == level.weaponBaseMelee )
	{
		self SwitchToWeapon( weapon );
		self zm_utility::decrement_is_drinking();
		return;
	}
	else if ( original_weapon != level.weaponBaseMelee && !zm_utility::is_placeable_mine( original_weapon ) && !zm_equipment::is_equipment( original_weapon ) )
	{
		self zm_weapons::switch_back_primary_weapon( original_weapon );
	}
	else
	{
		self zm_weapons::switch_back_primary_weapon();
	}

	self waittill( "weapon_change_complete" );

	if ( !self laststand::player_is_in_laststand() && !IS_TRUE( self.intermission ) )
	{
		self zm_utility::decrement_is_drinking();
	}
}
function my_change_melee_weapon( weapon, current_weapon ){
	had_fallback_weapon = self zm_melee_weapon::take_fallback_weapon();
	current_melee_weapon = self zm_utility::get_player_melee_weapon();
	if ( current_melee_weapon != level.weaponNone && current_melee_weapon != weapon )
	{
		self TakeWeapon( current_melee_weapon );
	}
	self zm_utility::set_player_melee_weapon( weapon );

	had_ballistic = 0;
	had_ballistic_upgraded = 0;
	ballistic_was_primary = 0;

	primaryWeapons = self GetWeaponsListPrimaries();

	for ( i = 0; i < primaryweapons.size; i++ )
	{
		primary_weapon = primaryweapons[i];
		if ( primary_weapon.isBallisticKnife )
		{
			had_ballistic = 1;
			if ( primary_weapon == current_weapon )
			{
				ballistic_was_primary = 1;
			}

			self notify( "zmb_lost_knife" );
			self TakeWeapon( primary_weapon );
			if ( zm_weapons::is_weapon_upgraded( primary_weapon ) )
			{
				had_ballistic_upgraded = 1;
			}
		}
	}

	if ( had_ballistic )
	{
		if ( had_ballistic_upgraded )
		{
			new_ballistic = level.ballistic_upgraded_weapon[weapon];
			if ( ballistic_was_primary )
			{
				current_weapon = new_ballistic;
			}
			self zm_weapons::give_build_kit_weapon( new_ballistic );
		}
		else
		{
			new_ballistic = level.ballistic_weapon[weapon];
			if ( ballistic_was_primary )
			{
				current_weapon = new_ballistic;
			}
			self GiveWeapon( new_ballistic ); // fixed line for combination setting
		}
	}

	if ( had_fallback_weapon )
	{
		self zm_melee_weapon::give_fallback_weapon();
	}

	return current_weapon;
}

//Shooting functionality
function bkWatcher(){	
	self endon("disconnect");
	self endon("bled_out");
	self notify("ballsitic_knife_watcher");
	self endon("ballsitic_knife_watcher");
	
	for(;;) 
	{
		self waittill( "missile_fire", projectile, weapon );
		if ( !isBallisticKnife( weapon ) )
		{
			continue;
		}

		self thread ballistic_knife_fired( projectile, weapon );
	}
}
function isBallisticKnife( weapon ){
    return weapon == level.weapBallisticKnife || weapon == level.weapBallisticKnifeUpgraded 
	|| weapon == level.weapBallisticKnifeWithBowie || weapon == level.weapBallisticKnifeWithBowieUpgraded 
	|| weapon == level.weapBallisticKnifeWithSickle || weapon == level.weapBallisticKnifeWithSickleUpgraded;
}
function isUpgradedBallisticKnife( weapon ){
	return weapon == level.weapBallisticKnifeUpgraded
	|| weapon == level.weapBallisticKnifeWithBowieUpgraded
	|| weapon == level.weapBallisticKnifeWithSickleUpgraded;
}
function ballistic_knife_fired(projectile, weapon){
    self endon("bled_out");
    self endon("disconnect");
    self endon("zmb_lost_knife");
    level endon("game_ended");
    projectile waittill("stationary", endpos, normal, angles, attacker, prey, bone);
    if(isdefined(endpos))
    {
        is_upgraded = isUpgradedBallisticKnife(weapon);

        retrievable_model = spawn("script_model", endpos);
        if(is_upgraded)
            retrievable_model setmodel(PROJECTILE_MODEL_UPGRADED);
        else
            retrievable_model setmodel(PROJECTILE_MODEL);

        retrievable_model setowner(self);
        retrievable_model.owner = self;
        retrievable_model.angles = angles;
        retrievable_model.weapon = weapon;
		
        if(is_upgraded)
        {
            if(!isdefined(self.ground_knives_upgraded))
                self.ground_knives_upgraded = [];
            ground_array = self.ground_knives_upgraded;
            max_knives = MAX_UP_KNIVES_ON_GROUND;
        }
        else
        {
            if(!isdefined(self.ground_knives))
                self.ground_knives = [];
            ground_array = self.ground_knives;
            max_knives = MAX_KNIVES_ON_GROUND;
        }

        ground_array[ground_array.size] = retrievable_model;
        if(ground_array.size > max_knives)
        {
            oldest = ground_array[0];
            if(isdefined(oldest))
            {
                if(isdefined(oldest.retrievabletrigger))
                    oldest.retrievabletrigger destroy_ent();
                oldest destroy_ent();
            }
            new_array = [];
            for(i = 1; i < ground_array.size; i++)
                new_array[i - 1] = ground_array[i];
            ground_array = new_array;
        }

        if(is_upgraded)
            self.ground_knives_upgraded = ground_array;
        else
            self.ground_knives = ground_array;

        if(isdefined(prey) && !isplayer(prey))
        {
            retrievable_model linkto(prey, bone);
            retrievable_model thread force_drop_knives_to_ground_on_death(self, prey);
        }

        self thread on_spawn_retrieve_trigger(projectile, weapon);
        self notify("ballistic_knife_stationary", retrievable_model, normal, prey);
        retrievable_model thread wait_to_show_glowing_model();
    }
}
function wait_to_show_glowing_model(){
	level endon("game_ended");
	self endon("death");
	wait(2);
	self setmodel(PROJECTILE_MODEL_GLOW);
}
function on_spawn_retrieve_trigger(projectile, weapon){
	self endon("bled_out");
	self endon("disconnect");
	self endon("zmb_lost_knife");
	level endon("game_ended");
	
    self waittill("ballistic_knife_stationary", retrievable_model, normal, prey);
	
	if(!isdefined(retrievable_model))
	{
		return;
	}
	trigger_pos = [];
	if(isdefined(prey) && (isplayer(prey) || isai(prey)))
	{
		trigger_pos[0] = prey.origin[0];
		trigger_pos[1] = prey.origin[1];
		trigger_pos[2] = prey.origin[2] + 10;
	}
	else
	{
		trigger_pos[0] = retrievable_model.origin[0] + (10 * normal[0]);
		trigger_pos[1] = retrievable_model.origin[1] + (10 * normal[1]);
		trigger_pos[2] = retrievable_model.origin[2] + (10 * normal[2]);
	}
	if(AUTO_RETRIEVE || isdefined(level.ballistic_knife_autorecover) && level.ballistic_knife_autorecover)
	{
		trigger_pos[2] = trigger_pos[2] - 50;
		pickup_trigger = spawn("trigger_radius", (trigger_pos[0], trigger_pos[1], trigger_pos[2]), 0, 50, 100);
	}
	else
	{
		pickup_trigger = spawn("trigger_radius_use", (trigger_pos[0], trigger_pos[1], trigger_pos[2]));
		pickup_trigger setcursorhint("HINT_NOICON");
	}
	pickup_trigger.owner = self;
	retrievable_model.retrievabletrigger = pickup_trigger;
	hint_string = PICKUP_HINT_STRING;
	if(isdefined(hint_string))
	{
		pickup_trigger SetHintString( hint_string );
	}
	else
	{
		pickup_trigger sethintstring(&"GENERIC_PICKUP");
	}
	pickup_trigger setteamfortrigger(self.team);
	self clientclaimtrigger(pickup_trigger);
	pickup_trigger enablelinkto();
	if(isdefined(prey))
	{
		pickup_trigger linkto(prey);
	}
	else
	{
		pickup_trigger linkto(retrievable_model);
	}
	if(isdefined(level.knife_planted))
	{
		[[level.knife_planted]](retrievable_model, pickup_trigger, prey);
	}
	retrievable_model thread watch_use_trigger(pickup_trigger, retrievable_model, &pick_up, weapon, PICKUPSOUNDSELF, PICKUPSOUNDNPC);
	self thread watch_shutdown(pickup_trigger, retrievable_model);
}
function watch_use_trigger(trigger, model, callback, weapon, playersoundonuse, npcsoundonuse){
	self endon("death");
	self endon("delete");
	level endon("game_ended");
	max_ammo = weapon.maxammo + 1;
	autorecover = AUTO_RETRIEVE || (isdefined(level.ballistic_knife_autorecover) && level.ballistic_knife_autorecover);
	while(true)
	{
		trigger waittill("trigger", player);
		if(!isalive(player))
		{
			continue;
		}
		if(!player isonground() && (!(isdefined(trigger.force_pickup) && trigger.force_pickup)))
		{
			continue;
		}
		if(isdefined(trigger.triggerteam) && player.team != trigger.triggerteam)
		{
			continue;
		}
		if(isdefined(trigger.claimedby) && player != trigger.claimedby)
		{
			continue;
		}
		ammo_stock = player getweaponammostock(weapon);
		ammo_clip = player getweaponammoclip(weapon);
		current_weapon = player getcurrentweapon();
		total_ammo = ammo_stock + ammo_clip;
		hasreloaded = 1;
		if(total_ammo > 0 && ammo_stock == total_ammo && current_weapon == weapon)
		{
			hasreloaded = 0;
		}
		if(total_ammo >= max_ammo || !hasreloaded)
		{
			continue;
		}
		if(autorecover || (player usebuttonpressed() && !player.throwinggrenade && !player meleebuttonpressed()) || (isdefined(trigger.force_pickup) && trigger.force_pickup))
		{
			if(isdefined(playersoundonuse))
			{
				player playlocalsound(playersoundonuse);
			}
			if(isdefined(npcsoundonuse))
			{
				player playsound(npcsoundonuse);
			}
			player thread [[callback]](weapon, model, trigger);
			break;
		}
	}
}
function watch_shutdown(trigger, model){
	self util::waittill_any("bled_out", "disconnect", "zmb_lost_knife");
	trigger destroy_ent();
	model destroy_ent();
}
function pick_up(weapon, model, trigger){
	if(self hasweapon(weapon))
	{
		current_weapon = self getcurrentweapon();
		if(current_weapon != weapon)
		{
			clip_ammo = self getweaponammoclip(weapon);
			if(!clip_ammo)
			{
				self setweaponammoclip(weapon, 1);
			}
			else
			{
				new_ammo_stock = self getweaponammostock(weapon) + 1;
				self setweaponammostock(weapon, new_ammo_stock);
			}
		}
		else
		{
			new_ammo_stock = self getweaponammostock(weapon) + 1;
			self setweaponammostock(weapon, new_ammo_stock);
		}
	}
	self zm_stats::increment_client_stat("ballistic_knives_pickedup");
	self zm_stats::increment_player_stat("ballistic_knives_pickedup");
	
    if(isdefined(self.ground_knives))
    {
        new_array = [];
        for(i = 0; i < self.ground_knives.size; i++)
        {
            if(self.ground_knives[i] != model)
                new_array[new_array.size] = self.ground_knives[i];
        }
        self.ground_knives = new_array;
    }
	
	model destroy_ent();
	trigger destroy_ent();
}
function destroy_ent(){
	if(isdefined(self))
	{
		if(isdefined(self.glowing_model))
		{
			self.glowing_model delete();
		}
		self delete();
	}
}
function force_drop_knives_to_ground_on_death(player, prey){
    self endon("death");
    player endon("zmb_lost_knife");
    prey waittill("death");
    self unlink();
    self physicslaunch((0, 0, -1), (0, 0, 0));
    self thread update_retrieve_trigger(player);
}
function update_retrieve_trigger(player){
    self endon("death");
    player endon("zmb_lost_knife");
    self waittill("stationary");
    trigger = self.retrievabletrigger;
    trigger.origin = (self.origin[0], self.origin[1], self.origin[2] + 10);
    trigger linkto(self);
}


