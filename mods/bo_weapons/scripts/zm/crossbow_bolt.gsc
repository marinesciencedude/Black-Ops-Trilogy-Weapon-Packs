/*#========================================###
###                                                                   							  ###
###                                                                   							  ###
###           			Harry Bo21s Black Ops 3 Magmagat					  ###
###                                                                   							  ###
###                                                                   							  ###
###========================================#*/
/*============================================

								CREDITS

=============================================
Raptroes
Hubashuba
WillJones1989
alexbgt
NoobForLunch
Symbo
TheIronicTruth
JAMAKINBACONMAN
Sethnorris
Yen466
Lilrifa
Easyskanka
Erthrock
Will Luffey
ProRevenge
DTZxPorter
Zeroy
JBird632
StevieWonder87
BluntStuffy
RedSpace200
Frost Iceforge
thezombieproject
Smasher248
JiffyNoodles
MadGaz
MZSlayer
AndyWhelen
Collie
ProGamerzFTW
Scobalula
Azsry
GerardS0406
PCModder
IperBreach
TomBMX
Treyarch and Activision
AllModz
TheSkyeLord
===========================================*/
#using scripts\codescripts\struct;
#using scripts\shared\_burnplayer;
#using scripts\shared\array_shared;
#using scripts\shared\system_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\animation_shared;
#using scripts\shared\util_shared;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai\systems\gib;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_utility;
#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#namespace crossbow_bolt; 

REGISTER_SYSTEM_EX( "crossbow_bolt", &__init__, &__main__, undefined )

// ============================== INITIALIZE ==============================

/* 
INITIALIZE 
Description : This function starts the script and will setup everything required
Notes : None  
*/
function __init__()
{		
	// # CLIENTFIELD REGISTRATION
	clientfield::register( "missile", "blundersplat_missile", VERSION_SHIP, 1, "int" );
	// # CLIENTFIELD REGISTRATION

	// # VARIABLES AND SETTINGS
	level.w_magmagat_upgraded = getWeapon( "t9_crossbow_up" );
	level.w_magmagat_upgraded.ptr_weapon_grenade_fired_cb = &magmagat_fired;
	// # VARIABLES AND SETTINGS
	
	// # REGISTER CALLBACKS
	callback::on_spawned( &magmagat_on_player_spawned );
	// # REGISTER CALLBACKS
}

/* 
MAIN 
Description : This function starts the script and will setup everything required - POST-load
Notes : None  
*/
function __main__()
{
}

// ============================== INITIALIZE ==============================

// ============================== CALLBACKS ==============================

function magmagat_on_player_spawned()
{
	self thread monitor_weapon_grenade_fired();
}

function monitor_weapon_grenade_fired()
{
	self endon( "death_or_disconnect" );
	self notify( "monitor_weapon_grenade_fired" );
	self endon( "monitor_weapon_grenade_fired" );
	
	while ( isDefined( self ) )
	{
		self waittill( "grenade_fire", e_projectile, w_weapon );
		
		if ( isDefined( e_projectile ) && IS_TRUE( e_projectile.b_additional_shot ) )
			continue;
		
		if ( isDefined( w_weapon.ptr_weapon_grenade_fired_cb ) )
			self thread [ [ w_weapon.ptr_weapon_grenade_fired_cb ] ]( e_projectile, w_weapon, self.chargeshotlevel );
			
	}
}

// ============================== CALLBACKS ==============================

// ============================== FUNCTIONALITY ==============================

function magmagat_fired( e_projectile, w_weapon )
{	
	e_projectile util::waittill_any( "death", "grenade_bounce", "stationary", "grenade_stuck" );
	
	if ( !isDefined( e_projectile ) )
		return;
	
	max_attract_dist = level.monkey_attract_dist;
	if(!isdefined(max_attract_dist))
	{
		max_attract_dist = 1536;
	}
	num_attractors = level.num_monkey_attractors;
	if(!isdefined(num_attractors))
	{
		num_attractors = 96;
	}
	
	valid_poi = zm_utility::check_point_in_enabled_zone(e_projectile.origin, undefined, undefined);
	
	if(!valid_poi)
	{
		valid_poi = zm_utility::check_point_in_playable_area(e_projectile.origin);
	}
	
	if(valid_poi)
	{
		a_targets = getAITeamArray( level.zombie_team );
		for ( i = 0; i < a_targets.size; i++ )
		{
			if ( e_projectile isLinkedTo( a_targets[ i ] ) )
			{
				e_projectile zm_utility::create_zombie_point_of_interest( max_attract_dist, num_attractors, 10000 );
				return;
			}
		}
		
		e_projectile zm_utility::create_zombie_point_of_interest( max_attract_dist, num_attractors, 10000 );
	}
}