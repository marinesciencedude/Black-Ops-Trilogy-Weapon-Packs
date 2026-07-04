#using scripts\codescripts\struct;

#using scripts\shared\ai\systems\animation_state_machine_notetracks;
#using scripts\shared\ai\systems\animation_state_machine_mocomp;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\zombie_utility;

#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;

#using scripts\zm\_util;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_net;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\shared\spawner_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;
#insert scripts\zm\_zm_weap_freezegun_custom.gsh;

#namespace zm_weap_freezegun_custom;

function autoexec init_system()
{
	if(GetDvarString("mapname") != "zm_pentagon")
		system::register( "zm_weap_freezegun_custom", &__init__, &__main__, undefined );
}

function __init__()
{
	level.weaponZMFreezeGun = GetWeapon( "freezegun_custom" );
	level.weaponZMFreezeGunUpgraded = GetWeapon( "freezegun_custom_upgraded" );

	clientfield::register( "actor", "toggle_freezegun_crumple", VERSION_DLC5, 1, "int" );
	clientfield::register( "actor", "toggle_freezegun_shatter", VERSION_DLC5, 1, "int" );
	clientfield::register( "actor", "toggle_freezegun_iceover", VERSION_DLC5, 1, "int" );
}

function __main__()
{
	callback::on_connect( &wait_for_freezegun_fired );
	zm_spawner::register_zombie_death_event_callback( &freezegun_death );
}

function wait_for_freezegun_fired()
{
	self endon( "disconnect" );
	for(;;) {
		self waittill( "weapon_fired", weapon );
		if( weapon == level.weaponZMFreezeGun || weapon == level.weaponZMFreezeGunUpgraded ) {
			upgraded = ( weapon == level.weaponZMFreezeGunUpgraded ? 1 : 0 );
			self thread freezegun_fired( upgraded );
		}
	}
}

function freezegun_fired( upgraded )
{
	PhysicsExplosionCylinder( self.origin, 600, 240, 1 );
	self thread affect_ais_freezegun_style( upgraded );
}

function affect_ais_freezegun_style( upgraded )
{
	view_pos = self GetWeaponMuzzlePoint();
	inner_range = ( upgraded ? FREEZEGUN_INNER_RANGE_UP : FREEZEGUN_INNER_RANGE );
	inner_range_squared = SQR( inner_range );
	outer_range = ( upgraded ? FREEZEGUN_OUTER_RANGE_UP : FREEZEGUN_OUTER_RANGE );
	outer_range_squared = SQR( outer_range );
	cylinder_radius = ( upgraded ? FREEZEGUN_CYLINDER_RADIUS_UP : FREEZEGUN_CYLINDER_RADIUS );
	cylinder_radius_squared = SQR( cylinder_radius );
	zombies = array::get_all_closest( view_pos, GetAITeamArray( level.zombie_team ), undefined, undefined, outer_range * 1.1 );
	if( !isdefined( zombies ) ) return;
	forward_dir = self GetWeaponForwardDir();
	end_pos = view_pos + VectorScale( forward_dir, outer_range );
	for( i=0; i<zombies.size; i++ ) {
		z = zombies[i];
		if( !isdefined( z ) || !IsAlive( z ) ) continue;
		centroid = z GetCentroid();
		if( DistanceSquared( view_pos, centroid ) > outer_range_squared ) continue;
		normal = VectorNormalize( centroid - view_pos );
		dot = VectorDot( forward_dir, normal );
		if( dot < 0 ) continue;
		radial_origin = PointOnSegmentNearestToPoint( view_pos, end_pos, centroid );
		if ( DistanceSquared( centroid, radial_origin ) > cylinder_radius_squared ) continue;
		if( 0 == z DamageConeTrace( view_pos, self ) ) continue;
		dist_ratio = ( ( outer_range_squared - DistanceSquared( view_pos, centroid ) ) / ( outer_range_squared - inner_range_squared ) );
		dist_ratio = math::clamp( dist_ratio, 0, 1 );
		z thread do_freezegun_damage( upgraded, self, dist_ratio );
	}
}

function do_freezegun_damage( upgraded, player, dist_ratio )
{
	self endon( "death" );
	if( !isdefined( self ) || !IsAlive( self ) ) return;
	DEFAULT( self.freezegun_damage, 0 );
	DEFAULT( self.marked_for_death, false );
	is_dog = ( self.archetype === "zombie_dog" );
	inner_dmg = ( upgraded ? FREEZEGUN_INNER_DAMAGE_UP : FREEZEGUN_INNER_DAMAGE );
	outer_dmg = ( upgraded ? FREEZEGUN_OUTER_DAMAGE_UP : FREEZEGUN_OUTER_DAMAGE );
	final_dmg = Int( LerpFloat( outer_dmg, inner_dmg, dist_ratio ) );
	self.freezegun_damage += final_dmg;
	if( self.freezegun_damage >= self.health || self.health <= 0 ) {
		self.marked_for_death = true;
	}
	self thread freeze_zombie();
	instakill = player zm_powerups::is_insta_kill_active();
	time = ( self.health < 0 || instakill || is_dog ? RandomFloatRange( 0.5, 0.7 ) : RandomFloatRange( FREEZEGUN_MIN_TIME, FREEZEGUN_MAX_TIME ) );
	self unfreeze_zombie_in( time );
	self clientfield::set( "toggle_freezegun_iceover", 0 );
	self clientfield::set( "toggle_freezegun_crumple", 0 );
	self.last_freezegun_dist_ratio = dist_ratio;
	weapon = ( upgraded ? level.weaponZMFreezeGunUpgraded : level.weaponZMFreezeGun );
	damage = ( instakill || is_dog || self.marked_for_death ? self.health + 666 : self.freezegun_damage );
	self DoDamage( damage, player.origin, player, undefined, "none", "MOD_RIFLE_BULLET", 0, weapon );
}

function freeze_zombie()
{
	self endon( "death" );
	if( !isdefined( self ) ) return;
	if( !isdefined( self.is_on_ice ) || !self.is_on_ice ) {
		self clientfield::set( "toggle_freezegun_iceover", 1 );
		self clientfield::set( "toggle_freezegun_crumple", 1 );
		PlaySoundAtPosition( "wpn_freezegun_collapse_zombie", self.origin );
		self.is_on_ice = 1;
	}
	while( self.is_on_ice ) {
		self ASMSetAnimationRate( 0.5 );
		wait .05;
	}
}

function unfreeze_zombie_in( time )
{
	self endon( "death" );
	wait time;
	self.is_on_ice = 0;
	util::wait_network_frame();
	self ASMSetAnimationRate(1);
}

function freezegun_death( e_attacker )
{
	if( self.archetype !== "zombie" ) return;
	if( ( self.damageweapon === level.weaponZMFreezeGun
			|| self.damageweapon === level.weaponZMFreezeGunUpgraded )
		&& self.damagemod === "MOD_RIFLE_BULLET" ) {
		self clientfield::set( "toggle_freezegun_shatter", 1 );
		PlaySoundAtPosition( "wpn_freezegun_shatter_zombie", self.origin );
		self Ghost();
	}
	if( !isdefined( e_attacker ) || !IsPlayer( e_attacker ) ) return;
	if( isdefined( level.hero_power_update ) ) {
		level thread [[level.hero_power_update]]( e_attacker, self );
	}
	dist_ratio = self.last_freezegun_dist_ratio;
	points = ( isdefined( dist_ratio ) && dist_ratio >= 0.9 ? 30 : 10 );
	e_attacker zm_score::player_add_points( "thundergun_fling", points );
}