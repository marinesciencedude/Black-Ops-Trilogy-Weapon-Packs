#using scripts\codescripts\struct;

#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\callbacks_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;

#using scripts\zm\_zm_clone;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;

#insert scripts\zm\_zm_utility.gsh;
#insert scripts\shared\version.gsh;
#insert scripts\shared\shared.gsh;

//#precache( "fx", "carrabella/wpn_crossbow/exp/crossbow_impact_fx" );
#precache( "fx", "explosions/fx_exp_rocket_default_sm" );
#precache( "fx", "carrabella/wpn_crossbow/impact_blink/crossbow_blink_2ms_green" ); 
#precache( "fx", "carrabella/wpn_crossbow/impact_blink/crossbow_blink_2ms_red" );

#define DETONATION_TIME					2.1
#define DETONATION_TIME_UPGRADED		4.3
#define DAMAGE_FIRSTRANGE 				400
#define DAMAGE_FIRSTRANGE_UPGRADED		2500
#define DAMAGE_SECONDRANGE				75
#define DAMAGE_SECONDRANGE_UPGRADED		225
#define CLOSE_RANGE						69
#define CLOSE_RANGE_UPGRADED			95
#define CLOSE_RANGE_PLAYER_DAMAGE		70
#define FAR_RANGE						130
#define FAR_RANGE_UPGRADED				165
#define FAR_RANGE_PLAYER_DAMAGE			20

#namespace zm_weap_crossbow;

REGISTER_SYSTEM_EX( "zm_weap_crossbow", &__init__, &__main__, undefined )

function __init__(){}

function __main__()
{
	level.weapCrossbow = GetWeapon( "t5_crossbow" );
	level.weapCrossbowUpgraded = GetWeapon( "t5_crossbow_up" );
	level._effect["xbow_alert"] = "carrabella/wpn_crossbow/impact_blink/crossbow_blink_2ms_green";
	level._effect["xbow_alert_up"] = "carrabella/wpn_crossbow/impact_blink/crossbow_blink_2ms_red";
	//level._effect["xbow_explode"] = "carrabella/wpn_crossbow/exp/crossbow_impact_fx";
	level._effect["xbow_explode"] = "explosions/fx_exp_rocket_default_sm";
	callback::on_connect( &xbow_watcher );
}

function xbow_watcher()
{
	level.additional_check_to_crossbow = 0;
	for(;;) {
		self waittill( "missile_fire", projectile, weapon );
		if( weapon != level.weapCrossbow && weapon != level.weapCrossbowUpgraded ) {
			continue;
		}
		upgraded = ( weapon == level.weapCrossbowUpgraded ? 1 : 0 );
		self thread crossbow_fired( projectile, weapon, upgraded );
		projectile thread watch_for_inaccuracy( 5, 1 );		
	}
}

function crossbow_fired( projectile, weapon, upgraded )
{
	projectile endon( "lost_in_thedark" );
	time = ( upgraded ? DETONATION_TIME_UPGRADED : DETONATION_TIME );
	damage_firstrange = ( upgraded ? DAMAGE_FIRSTRANGE_UPGRADED : DAMAGE_FIRSTRANGE );
	damage_secondrange = ( upgraded ? DAMAGE_SECONDRANGE_UPGRADED : DAMAGE_SECONDRANGE );
	close_range = ( upgraded ? CLOSE_RANGE_UPGRADED : CLOSE_RANGE );
	far_range = ( upgraded ? FAR_RANGE_UPGRADED : FAR_RANGE );
	projectile waittill( "stationary" );
	if( upgraded ) {
		attract_dist_diff = 45;
		num_attractors = 96;
		max_attract_dist = 1536;
		if( !level.additional_check_to_crossbow ) {
			level.additional_check_to_crossbow = 1;
			attractors = [];
			offsets = array( -75, 5, -45 );
			for( i = 0; i < offsets.size; i++ ) {
				attractors[i] = util::spawn_model( "tag_origin", projectile.origin+(0,0,offsets[i]), projectile.angles );
				attractors[i] thread watch_for_inaccuracy( 7, 0 );
			}
			wait .2;
			level.additional_check_to_crossbow = 0;
		}
		for( i = 0; i < attractors.size; i++ ) {
			attractors[i] zm_utility::create_zombie_point_of_interest( max_attract_dist, num_attractors, 10000 );
			attractors[i].attract_to_origin = 1;
			attractors[i] thread zm_utility::create_zombie_point_of_interest_attractor_positions( 4, attract_dist_diff );
		}
	}
	PlaySoundAtPosition( "wpn_crossbow_impact", projectile.origin );
	projectile thread detonate_with_countdown( time, upgraded );
	wait time;
	explosion_pos = projectile.origin;
	projectile notify( "detonated" );
	PlaySoundAtPosition( "blackops_explode", explosion_pos );
	PlayFX( level._effect["xbow_explode"], projectile.origin );
	zombs = GetAISpeciesArray( "axis", "all" );
	foreach( potential_target in zombs ) {
		potential_target.gibbed_by_crossbow = 0;
		down_theline = Distance( potential_target.origin, projectile.origin ); //500
		if( down_theline <= close_range ) {
			potential_target DoDamage( damage_firstrange, projectile.origin, self );
			//potential_target thread gib_and_maim( self );
		}
		if( down_theline <= far_range ) {
			potential_target DoDamage( damage_secondrange, projectile.origin, self );
			//potential_target thread gib_and_maim( self );
		}
	}
	distSq = DistanceSquared( self.origin, projectile.origin );
	if( distSq <= SQR(far_range) ) {
		damage = ( distSq <= SQR(close_range) ? CLOSE_RANGE_PLAYER_DAMAGE : FAR_RANGE_PLAYER_DAMAGE );
		self DoDamage( damage, projectile.origin, self, projectile, "none", "MOD_EXPLOSIVE" );
	}
	projectile Delete();
	if( isdefined( attractors ) ) {
		for( i=0; i<attractors.size; i++ ) {
			attractors[i] notify( "arrow_detonated" );
			attractors[i] Delete();
		}
	}
}

function watch_for_inaccuracy( time, informplayer )
{
	self endon( "stationary" );
	self endon( "arrow_detonated" );
	wait time;
	self notify( "lost_in_thedark" );
	if( isdefined( self ) ) {
		self Delete();
	}
	players = GetPlayers();
	for( i = 0; i < players.size; i++ ) {
		if( IsAlive( players[i] ) && informplayer ) {
			players[i] PlayLocalSound( level.zmb_laugh_alias );
		}
	}
}

function detonate_with_countdown( total_time, upgraded )
{
    self endon( "detonated" );
    str_fx = ( upgraded ? level._effect["xbow_alert_up"] : level._effect["xbow_alert"] );
    time_remaining = total_time;
    while( isdefined( self ) && time_remaining > 0 ) {
        if( time_remaining > 3.0 ) interval = 0.3;
        else if( time_remaining > 2.0 ) interval = 0.25;
        else if( time_remaining > 1.0 ) interval = 0.2;
        else if( time_remaining > 0.5 ) interval = 0.1;
        else interval = 0.05;
        PlayFXOnTag( str_fx, self, "tag_fx" );
        self PlaySound( "wpn_crossbow_alert" );
        wait interval;
        time_remaining -= interval;
    }
}

/*function gib_and_maim( attacker )
{
	if( IsAlive( self ) && !self.gibbed_by_crossbow ) {
		chance = RandomIntRange( 1, 101 );
		if( chance < 18 ) {
			self.gibbed_by_crossbow = 1;
			self zombie_utility::makezombiecrawler();
		}
		if( chance > 18 && chance < 28 ) {
			self.gibbed_by_crossbow = 1;
			gibserverutils::gibhead( self );
			wait RandomFloatRange( 1.2, 3.1 );
			self DoDamage( self.health + 666, attacker.origin, attacker );
		}
		if( chance > 95 && chance < 101 ) {
			self DoDamage( 650, attacker.origin, attacker );
		}
	}
}*/