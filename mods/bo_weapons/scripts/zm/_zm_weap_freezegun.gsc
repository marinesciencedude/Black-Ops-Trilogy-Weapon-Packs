#using scripts\codescripts\struct;

// AI
#using scripts\shared\ai\systems\animation_state_machine_notetracks;
#using scripts\shared\ai\systems\animation_state_machine_mocomp;
#using scripts\shared\ai\systems\animation_state_machine_notetracks;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\zombie_utility;

// Shared
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;

// Zombie
#using scripts\zm\_util;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_net;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\shared\spawner_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#insert scripts\zm\_zm_weap_freezegun.gsh;

// TO DO LIST

#precache( "fx", FX_FREEZEGUN_SHATTER );
#precache( "fx", FX_FREEZEGUN_CRUMPLE );
#precache( "fx", FX_FREEZEGUN_SMOKE_CLOUD );
#precache( "fx", FX_FREEZEGUN_FREEZE_TORSO );
#precache( "fx", FX_FREEZEGUN_FREEZE_MD );
#precache( "fx", FX_FREEZEGUN_SHATTER_UPGRADED );
#precache( "fx", FX_FREEZEGUN_CRUMPLE_UPGRADED );
#precache( "fx", FX_FREEZEGUN_SHATTER_GIB );
#precache( "fx", FX_FREEZEGUN_SHATTER_GIBTRAIL );
#precache( "fx", FX_FREEZEGUN_CRUMPLE_GIB );
#precache( "fx", FX_FREEZEGUN_CRUMPLE_GIBTRAIL );
#precache( "fx", "dlc5/zmb_weapon/fx_freezegun_reload_smoke" );

#namespace zm_weap_freezegun;

function autoexec init_system()
{
	system::register( "zm_weap_freezegun", &__init__, &__main__, undefined );
}

function __init__()
{
	level.weaponZMFreezeGun = GetWeapon( "freezegun" );
	level.weaponZMFreezeGunUpgraded = GetWeapon( "freezegun_upgraded" );
}

function __main__()
{
	/*if ( zm_weapons::is_weapon_included( "freezegun" ) )
	{
		return;
	}*/    

	//level._ZOMBIE_ACTOR_FLAG_FREEZEGUN_EXTREMITY_DAMAGE_FX = 15;
	//level._ZOMBIE_ACTOR_FLAG_FREEZEGUN_TORSO_DAMAGE_FX = 14; // Unused system

	clientfield::register( "actor", "toggle_freezegun_extremity_damage_fx", VERSION_SHIP, 1, "int" );
	clientfield::register( "actor", "toggle_freezegun_crumple", VERSION_SHIP, 1, "int" );
	clientfield::register( "actor", "toggle_freezegun_torso_damage_fx", VERSION_SHIP, 1, "int" );
	clientfield::register( "actor", "toggle_freezegun_iceover", VERSION_SHIP, 1, "int" );

	level._effect[ "freezegun_shatter" ]				= FX_FREEZEGUN_SHATTER;
	level._effect[ "freezegun_crumple" ]				= FX_FREEZEGUN_CRUMPLE;
	level._effect[ "freezegun_smoke_cloud" ]			= FX_FREEZEGUN_SMOKE_CLOUD;
	level._effect[ "freezegun_damage_torso" ]			= FX_FREEZEGUN_FREEZE_TORSO;
	level._effect[ "freezegun_damage_sm" ]				= FX_FREEZEGUN_FREEZE_MD;
	level._effect[ "freezegun_shatter_upgraded" ]		= FX_FREEZEGUN_SHATTER_UPGRADED;
	level._effect[ "freezegun_crumple_upgraded" ]		= FX_FREEZEGUN_CRUMPLE_UPGRADED;
	level._effect[ "freezegun_reload" ] 				= "dlc5/zmb_weapon/fx_freezegun_reload_smoke";

	if( IS_TRUE( level.use_t8_damage_set ) )
	{
		zombie_utility::set_zombie_var( "freezegun_inner_damage",					1500 );
		zombie_utility::set_zombie_var( "freezegun_outer_damage",					750 );
		zombie_utility::set_zombie_var( "freezegun_shatter_inner_damage",			750 );
		zombie_utility::set_zombie_var( "freezegun_shatter_outer_damage",			500 );

		zombie_utility::set_zombie_var( "freezegun_inner_damage_upgraded",			3000 );
		zombie_utility::set_zombie_var( "freezegun_outer_damage_upgraded",			1500 );
		zombie_utility::set_zombie_var( "freezegun_shatter_inner_damage_upgraded",	1500 );
		zombie_utility::set_zombie_var( "freezegun_shatter_outer_damage_upgraded",	750 );
	}
	else
	{
		zombie_utility::set_zombie_var( "freezegun_inner_damage",					1000 );
		zombie_utility::set_zombie_var( "freezegun_outer_damage",					500 );
		zombie_utility::set_zombie_var( "freezegun_shatter_inner_damage",			500 );
		zombie_utility::set_zombie_var( "freezegun_shatter_outer_damage",			250 );

		zombie_utility::set_zombie_var( "freezegun_inner_damage_upgraded",			1500 );
		zombie_utility::set_zombie_var( "freezegun_outer_damage_upgraded",			750 );
		zombie_utility::set_zombie_var( "freezegun_shatter_inner_damage_upgraded",	750 );
		zombie_utility::set_zombie_var( "freezegun_shatter_outer_damage_upgraded",	500 );
	}

	zombie_utility::set_zombie_var( "freezegun_inner_range",					60 ); // 5 feet
	zombie_utility::set_zombie_var( "freezegun_outer_range",					600 ); // 50 feet
	zombie_utility::set_zombie_var( "freezegun_shatter_range",					180 ); // 150 feet
	zombie_utility::set_zombie_var( "freezegun_cylinder_radius",				120 ); // 10 feet

	zombie_utility::set_zombie_var( "freezegun_inner_range_upgraded",			120 ); // 10 feet
	zombie_utility::set_zombie_var( "freezegun_outer_range_upgraded",			900 ); // 75 feet
	zombie_utility::set_zombie_var( "freezegun_shatter_range_upgraded",			300 ); // 25 feet
	zombie_utility::set_zombie_var( "freezegun_cylinder_radius_upgraded",		180 ); // 15 feet

	zm_spawner::register_zombie_damage_callback( &freezegun_damage_callback );
	zm_spawner::register_zombie_death_event_callback( &freezegun_death_callback );

	//zombie_utility::add_zombie_gib_weapon_callback
	
	// For testing FX 
	// system_elements/fx_null

	//AnimationStateNetwork::RegisterNotetrackHandlerFunction()	not sure why this was here
	InitZmBehaviorsAndASM();
	
	callback::on_connect( &freezegun_on_player_connect ); 
}

function freezegun_on_player_connect()
{
	self thread wait_for_freezegun_fired(); // changed from thundergun to freezegun
}


function wait_for_freezegun_fired()
{
	self endon( "disconnect" );
	self waittill( "spawned_player" ); 

	for( ;; )
	{
		self waittill( "weapon_fired" ); 
		currentweapon = self GetCurrentWeapon(); 
		if( ( currentweapon == level.weaponZMFreezeGun ) || ( currentweapon == level.weaponZMFreezeGunUpgraded ) )
		{
			self thread freezegun_fired( currentweapon == level.weaponZMFreezeGunUpgraded );

			view_pos = self GetTagOrigin( "tag_flash" ) - self GetPlayerViewHeight();
			view_angles = self GetTagAngles( "tag_flash" );
			playfx( level._effect[ "freezegun_smoke_cloud" ], view_pos, AnglesToForward( view_angles ), AnglesToUp( view_angles ) );
		}
	}
}


function freezegun_fired( upgraded )
{
	// ww: physics hit when firing
	PhysicsExplosionCylinder( self.origin, 600, 240, 1 );
	
	self thread freezegun_affect_ais( upgraded );
}

function freezegun_affect_ais( upgraded )
{
	if ( !IsDefined( level.freezegun_enemies ) )
	{
		level.freezegun_enemies = [];
		level.freezegun_enemies_dist_ratio = [];
	}

	self freezegun_get_enemies_in_range( upgraded );

	for ( i = 0; i < level.freezegun_enemies.size; i++ )
	{
		level.freezegun_enemies[i] thread freezegun_do_damage( upgraded, self, level.freezegun_enemies_dist_ratio[i] );
	}

	level.freezegun_enemies = [];
	level.freezegun_enemies_dist_ratio = [];
}


function freezegun_get_cylinder_radius( upgraded )
{
	if ( upgraded )
	{
		return level.zombie_vars["freezegun_cylinder_radius_upgraded"];
	}
	else
	{
		return level.zombie_vars["freezegun_cylinder_radius"];
	}
}


function freezegun_get_inner_range( upgraded )
{
	if ( upgraded )
	{
		return level.zombie_vars["freezegun_inner_range_upgraded"];
	}
	else
	{
		return level.zombie_vars["freezegun_inner_range"];
	}
}


function freezegun_get_outer_range( upgraded )
{
	if ( upgraded )
	{
		return level.zombie_vars["freezegun_outer_range_upgraded"];
	}
	else
	{
		return level.zombie_vars["freezegun_outer_range"];
	}
}


function freezegun_get_inner_damage( upgraded )
{
	if ( upgraded )
	{
		return level.zombie_vars["freezegun_inner_damage_upgraded"];
	}
	else
	{
		return level.zombie_vars["freezegun_inner_damage"];
	}
}


function freezegun_get_outer_damage( upgraded )
{
	if ( upgraded )
	{
		return level.zombie_vars["freezegun_outer_damage_upgraded"];
	}
	else
	{
		return level.zombie_vars["freezegun_outer_damage"];
	}
}


function freezegun_get_shatter_range( upgraded )
{
	if ( upgraded )
	{
		return level.zombie_vars["freezegun_shatter_range_upgraded"];
	}
	else
	{
		return level.zombie_vars["freezegun_shatter_range"];
	}
}


function freezegun_get_shatter_inner_damage( upgraded )
{
	if ( upgraded )
	{
		return level.zombie_vars["freezegun_shatter_inner_damage_upgraded"];
	}
	else
	{
		return level.zombie_vars["freezegun_shatter_inner_damage"];
	}
}


function freezegun_get_shatter_outer_damage( upgraded )
{
	if ( upgraded )
	{
		return level.zombie_vars["freezegun_shatter_outer_damage_upgraded"];
	}
	else
	{
		return level.zombie_vars["freezegun_shatter_outer_damage"];
	}
}


function freezegun_get_enemies_in_range( upgraded )
{
	inner_range = freezegun_get_inner_range( upgraded );
	outer_range = freezegun_get_outer_range( upgraded );
	cylinder_radius = freezegun_get_cylinder_radius( upgraded );

	view_pos = self GetWeaponMuzzlePoint();

	// Add a 10% epsilon to the range on this call to get guys right on the edge
	zombies = array::get_all_closest( view_pos, GetAiSpeciesArray( "axis", "all" ), undefined, undefined, (outer_range * 1.1) );
	if ( !isDefined( zombies ) )
	{
		return;
	}

	freezegun_inner_range_squared = inner_range * inner_range;
	freezegun_outer_range_squared = outer_range * outer_range;
	cylinder_radius_squared = cylinder_radius * cylinder_radius;

	forward_view_angles = self GetWeaponForwardDir();
	end_pos = view_pos + VectorScale( forward_view_angles, outer_range );

/#
	if ( 2 == GetDvarInt( "scr_freezegun_debug" ) )
	{
		// push the near circle out a couple units to avoid an assert in Circle() due to it attempting to
		// derive the view direction from the circle's center point minus the viewpos 										// Debug broke some shit so no
		// (which is what we're using as our center point, which results in a zeroed direction vector)
		near_circle_pos = view_pos + VectorScale( forward_view_angles, 2 );

		Circle( near_circle_pos, cylinder_radius, (1, 0, 0), false, false, 100 );
		Line( near_circle_pos, end_pos, (0, 0, 1), 1, false, 100 );
		Circle( end_pos, cylinder_radius, (1, 0, 0), false, false, 100 );
	}
#/

	for ( i = 0; i < zombies.size; i++ )
	{
		if ( !IsDefined( zombies[i] ) || !IsAlive( zombies[i] ) )
		{
			// guy died on us
			continue;
		}

		test_origin = zombies[i] getcentroid();
		test_range_squared = DistanceSquared( view_pos, test_origin );
		if ( test_range_squared > freezegun_outer_range_squared )
		{
			zombies[i] freezegun_debug_print( "range", (1, 0, 0) );
			return; // everything else in the list will be out of range
		}

		normal = VectorNormalize( test_origin - view_pos );
		dot = VectorDot( forward_view_angles, normal );
		if ( 0 > dot )
		{
			// guy's behind us
			zombies[i] freezegun_debug_print( "dot", (1, 0, 0) );
			continue;
		}
		
		radial_origin = PointOnSegmentNearestToPoint( view_pos, end_pos, test_origin );
		if ( DistanceSquared( test_origin, radial_origin ) > cylinder_radius_squared )
		{
			// guy's outside the range of the cylinder of effect
			zombies[i] freezegun_debug_print( "cylinder", (1, 0, 0) );
			continue;
		}

		if ( 0 == zombies[i] DamageConeTrace( view_pos, self ) )
		{
			// guy can't actually be hit from where we are
			zombies[i] freezegun_debug_print( "cone", (1, 0, 0) );
			continue;
		}

		level.freezegun_enemies[level.freezegun_enemies.size] = zombies[i];
		level.freezegun_enemies_dist_ratio[level.freezegun_enemies_dist_ratio.size] = (freezegun_outer_range_squared - test_range_squared) / (freezegun_outer_range_squared - freezegun_inner_range_squared);
	}
}


function freezegun_debug_print( msg, color )
{
}

// based off of thundergun code, marks ai as death for animscript
function freezegun_do_damage( upgraded, player, dist_ratio )
{
	if( !IsDefined( self ) || !IsAlive( self ) )
	{
		// guy died on us 
		return;
	}

	damage = Int( LerpFloat( freezegun_get_outer_damage( upgraded ), freezegun_get_inner_damage( upgraded ), dist_ratio ) );
	self DoDamage( damage, player.origin, player, undefined, "projectile" );
	
	self freezegun_debug_print( damage, (0, 1, 0) );

	if ( self.health <= 0 )
	{
		if( isdefined(player) && isdefined(level.hero_power_update))
		{
			level thread [[level.hero_power_update]](player, self);
		}
		
		points = 10;
		if ( !dist_ratio )
		{
			points = zm_score::get_zombie_death_player_points();
		}
		else if ( 1 == dist_ratio )
		{
			points = 30;
		}
		player zm_score::player_add_points( "thundergun_fling", points );

		self.freezegun_death = true;
	}
}


function freezegun_set_extremity_damage_fx()
{
	self clientfield::set( "toggle_freezegun_extremity_damage_fx", 1);
}


function freezegun_clear_extremity_damage_fx()
{
	self clientfield::set( "toggle_freezegun_extremity_damage_fx", 0 );
}


function freezegun_set_torso_damage_fx()
{
	self clientfield::set( "toggle_freezegun_torso_damage_fx", 1 );
}


function freezegun_clear_torso_damage_fx()
{
	self clientfield::set( "toggle_freezegun_torso_damage_fx", 0 );
}


function freezegun_damage_response( player, amount )
{
	if ( IsDefined( self.freezegun_damage_response_func ) )
	{
		if ( self [[ self.freezegun_damage_response_func ]]( player, amount ) )
		{
			return;
		}
	}

	self.freezegun_damage += amount;

	new_move_speed = self.zombie_move_speed;

	percent_dmg = self enemy_percent_damaged_by_freezegun();
	
	if ( 0.66 <= percent_dmg )
	{
		new_move_speed = "walk";
	}
	else if ( 0.33 <= percent_dmg )
	{
		if ( "sprint" == self.zombie_move_speed )
		{
			new_move_speed = "run";
		}
		else
		{
			new_move_speed = "walk";
		}
	}

	if ( !self.isdog && self.zombie_move_speed != new_move_speed )
	{
		zombie_utility::set_zombie_run_cycle( new_move_speed );
	}

	self thread freezegun_set_extremity_damage_fx();
}



// call this when we skip out of freezegun_death() to run the things we skipped in zombie_death_event()
function freezegun_run_skipped_death_events()
{
	//self thread zm_audio::do_zombies_playvocals( "death", self.animname );
	self thread zombie_utility::zombie_eye_glow_stop();
}

function freezegun_damage_callback( mod, HIT_LOCATION, hit_origin, player, amount, weapon, direction_vec, tagName, modelName, partName, dFlags, inflictor, chargeLevel )
{
	if ( self is_freezegun_damage_name( self.damageweapon ) && self.damageMod != "MOD_MELEE" )
	{
		self thread freezegun_damage_response( player, amount );
	}
	return false;
}

function freezegun_death_callback( attacker )
{
	if ( IS_TRUE( self.freezegun_death ) )
	{
		self freezegun_run_skipped_death_events();

	// the line above already tests for this.
		//self.freezegun_death = true;
		self.skip_death_notetracks = true;
		self.skipAutoRagdoll = true;
	
		self PlaySound( "wpn_freezegun_impact_zombie" );
	
		if( RandomIntRange(0,101) >= 88 )
		{
	    	zm_audio::create_and_play_dialog( "kill", "freeze" );
		}

		//self thread setup_radius_damage();

		weap = self.damageweapon;
		self thread setup_iceblock( attacker, weap );


		//self clientfield::set( "toggle_freezegun_explosion", 1 );
	}
}

function setup_iceblock( player, weap )
{
	wait( 3 );
	SetPlayerIgnoreRadiusDamage( true );
	self Hide();

	upgraded = (weap == "freezegun_upgraded");
	self radiusDamage( self.origin, freezegun_get_shatter_range( upgraded ), freezegun_get_shatter_inner_damage( upgraded ), freezegun_get_shatter_outer_damage( upgraded ), player, "MOD_EXPLOSIVE", weap );

	SetPlayerIgnoreRadiusDamage( false );
	wait( 1 );
	self Delete();
}


function is_freezegun_damage()
{
	return isdefined( self.damageweapon ) && (self.damageweapon == level.weaponZMFreezeGun || self.damageweapon == level.weaponZMFreezeGunUpgraded) && ( self.damagemod == "MOD_EXPLOSIVE" || self.damagemod == "MOD_PROJECTILE" );
}

function is_freezegun_damage_name( weapon )
{
	return isdefined(weapon) && (weapon.name == "freezegun" || weapon.name == "freezegun_upgraded");
}


function is_freezegun_shatter_damage()
{
	return isdefined( self.damagemod == "MOD_EXPLOSIVE" && IsDefined( self.damageweapon ) && (self.damageweapon == level.weaponZMFreezeGun || self.damageweapon == level.weaponZMFreezeGunUpgraded ) );
}


function should_do_freezegun_death()
{
	return is_freezegun_damage();
}


function enemy_damaged_by_freezegun()
{
	return 0 < self.freezegun_damage;
}


function enemy_percent_damaged_by_freezegun()
{
	return self.freezegun_damage / self.maxhealth;
}


function enemy_killed_by_freezegun()
{
	return isdefined(self.freezegun_death) && self.freezegun_death;
}

function private InitZmBehaviorsAndASM()
{
	BehaviorTreeNetworkUtility::RegisterBehaviorTreeScriptAPI( "zombiewasKilledByFreezeGun", &wasKilledByFreezeGun );
}

function wasKilledByFreezeGun( behaviorTreeEntity )
{
	if( IS_TRUE( behaviorTreeEntity.freezegun_death ) && behaviorTreeEntity.freezegun_death )
	{
		behaviorTreeEntity clientfield::set( "toggle_freezegun_iceover", 1 );
		behaviorTreeEntity clientfield::set( "toggle_freezegun_crumple", 1 );
		behaviorTreeEntity thread freezegun_set_extremity_damage_fx();
		behaviorTreeEntity thread freezegun_set_torso_damage_fx();
		return true;
	}
	return false;
}