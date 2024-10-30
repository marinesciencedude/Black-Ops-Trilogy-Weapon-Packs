// ====================================================================== \\
// PHD Flopper Credits:
//
// MikeyRay: Scripting, various edits on model, FX
// Humphrey: PHD Model Ripping
// JBird632 & Planet: Scripting assistance
// MotoLegacy: Scripting assistance, PHD Sounds, PHD Stats, PHD Bottle and PHD Shader
// Activision & Treyarch: PHD Model (BO4), PHD Flopper Perk Idea (BO1)
// Scobalula: Greyhound
// ====================================================================== \\

#using scripts\codescripts\struct;

#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#using scripts\shared\ai\zombie_utility;

#using scripts\zm\_util;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm;
#using scripts\zm\_zm_pers_upgrades;
#using scripts\zm\_zm_pers_upgrades_functions;
#using scripts\zm\_zm_pers_upgrades_system;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;

#insert scripts\zm\perks\_zm_perk_phdflopper.gsh;
#insert scripts\zm\_zm_perks.gsh;
#insert scripts\zm\_zm_utility.gsh;

#using scripts\zm\_zm_perk_random;
#using scripts\shared\callbacks_shared;
#using scripts\zm\gametypes\_globallogic_score;

#precache( "fx", PHDFLOPPER_LIGHTING_FX );
#precache( "fx", PHDFLOPPER_EXPLOSION_EFFECT);

#namespace zm_perk_phdflopper;

REGISTER_SYSTEM( "zm_perk_phdflopper", &__init__, undefined )

// PHD FLOPPER

//-----------------------------------------------------------------------------------
// setup
//-----------------------------------------------------------------------------------
function __init__()
{
	enable_phd_flopper_for_level();
	callback::on_spawned(&register_player_stats);
}

function private enable_phd_flopper_for_level()
{	
	zm_perks::register_perk_basic_info( PERK_PHDFLOPPER, "phd", PHDFLOPPER_PERK_COST, "Hold ^3[{+activate}]^7 for PHD Flopper [Cost: &&1]", GetWeapon( PHDFLOPPER_PERK_BOTTLE_WEAPON ) );
	zm_perks::register_perk_precache_func( PERK_PHDFLOPPER, &phd_flopper_precache );
	zm_perks::register_perk_clientfields( PERK_PHDFLOPPER, &phd_flopper_register_clientfield, &phd_flopper_set_clientfield );
	zm_perks::register_perk_machine( PERK_PHDFLOPPER, &phd_flopper_perk_machine_setup );
	zm_perks::register_perk_host_migration_params( PERK_PHDFLOPPER, PHDFLOPPER_RADIANT_MACHINE_NAME, PHDFLOPPER_MACHINE_LIGHT_FX );
	zm_perks::register_perk_threads( PERK_PHDFLOPPER, &phdflopper_activate, &phdflopper_lost );

	phd_flopper_func_init();
}

function private phd_flopper_precache()
{
	if( IsDefined(level.phd_flopper_precache_override_func) )
	{
		[[ level.phd_flopper_precache_override_func ]]();
		return;
	}
	
	level._effect[PHDFLOPPER_MACHINE_LIGHT_FX]			= PHDFLOPPER_LIGHTING_FX;
	
	level.machine_assets[PERK_PHDFLOPPER] = SpawnStruct();
	level.machine_assets[PERK_PHDFLOPPER].weapon = GetWeapon( PHDFLOPPER_PERK_BOTTLE_WEAPON );
	level.machine_assets[PERK_PHDFLOPPER].off_model = PHDFLOPPER_MACHINE_DISABLED_MODEL;
	level.machine_assets[PERK_PHDFLOPPER].on_model = PHDFLOPPER_MACHINE_ACTIVE_MODEL;	
}

function private phd_flopper_register_clientfield()
{
	clientfield::register( "clientuimodel", "hudItems.perks.phdflopper", VERSION_SHIP, 2, "int" );
	clientfield::register( "clientuimodel", "hudItems.perks.phdflopper_bo", VERSION_SHIP, 2, "int" );
	clientfield::register( "clientuimodel", "hudItems.perks.phd_flopper", VERSION_SHIP, 2, "int" );
}

function private phd_flopper_set_clientfield( state )
{
	if(GetDvarString("mapname") == "zm_der_riese") //different one for Der Riese: Declassified
	{
		self clientfield::set_player_uimodel( "hudItems.perks.phd_flopper", state );
	}
	else
	{
		if(GetDvarInt("mutator_bo_perk_icons") == 1) 
		{
			self clientfield::set_player_uimodel( "hudItems.perks.phdflopper_bo", state );
		}
		else
		{
			self clientfield::set_player_uimodel( "hudItems.perks.phdflopper", state );
		}
	}
}

function private phd_flopper_perk_machine_setup( use_trigger, perk_machine, bump_trigger, collision )
{
	use_trigger.script_sound = PHDFLOPPER_MUS_JINGLE;
	use_trigger.script_string = PHDFLOPPER_PERK_STRING;
	use_trigger.script_label = PHDFLOPPER_MUS_STING;
	use_trigger.target = PHDFLOPPER_RADIANT_MACHINE_NAME;
	perk_machine.script_string = PHDFLOPPER_PERK_STRING;
	perk_machine.targetname = PHDFLOPPER_RADIANT_MACHINE_NAME;

	if(IsDefined(bump_trigger))
		bump_trigger.script_string = PHDFLOPPER_PERK_STRING;

}

function phd_flopper_func_init() 
{

	level._effect["phdflopper_explode"] = PHDFLOPPER_EXPLOSION_EFFECT;

	if(IS_TRUE(PHDFLOPPER_EXPLOSIVE_IMMUNITY))
		zm::register_player_damage_callback(&phd_flopper_explosive_immunity);

	if(IS_TRUE(PHDFLOPPER_EXPLOSIVE_INCREASE)) 
	{
		zm::register_actor_damage_callback(&phd_flopper_zombie_explosive_increase);
		zm::register_vehicle_damage_callback(&phd_flopper_vehicle_explosive_increase);
	}

	WAIT_SERVER_FRAME;
	zm_perk_random::include_perk_in_random_rotation(PERK_PHDFLOPPER);

}

function private phd_flopper_explosive_immunity(inflictor, attacker, damage, flags, mod, weapon, vpoint, vdir, sHitLoc, psOffsetTime, boneIndex, surfaceType) 
{

    if(IsPlayer(self) && self HasPerk(PERK_PHDFLOPPER) && (zm_utility::is_explosive_damage( mod ) || mod == "MOD_FALLING")) 
        return 0;

    return -1;
}


function private phd_flopper_zombie_explosive_increase(inflictor, attacker, damage, flags, mod, weapon, vpoint, vdir, sHitLoc, psOffsetTime, boneIndex, surfaceType) 
{

    if(IsPlayer(attacker) && attacker HasPerk(PERK_PHDFLOPPER) && zm_utility::is_explosive_damage( mod )) 
        return damage * PHDFLOPPER_EXPLOSIVE_DAMAGE_INCREASE;

    return -1;
}

function private phd_flopper_vehicle_explosive_increase( eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, weapon, vPoint, vDir, sHitLoc, vDamageOrigin, psOffsetTime, damageFromUnderneath, modelIndex, partName, vSurfaceNormal ) 
{
    
    if(IsPlayer(eAttacker) && eAttacker HasPerk(PERK_PHDFLOPPER) && zm_utility::is_explosive_damage( sMeansOfDeath )) 
        return iDamage * PHDFLOPPER_EXPLOSIVE_DAMAGE_INCREASE;

    return 0;
}

// PHD Flopper Explosion
// self == player
function phdflopper_activate() 
{
    self endon("death");
    self endon("disconnect");
    self endon(PERK_PHDFLOPPER + "_stop");

    if(IS_TRUE(PHDFLOPPER_EXPLOSIVE_FALL))
        self thread phd_flopper_explosive_fall();

    if(IS_TRUE(PHDFLOPPER_EXPLOSIVE_SLIDE))
    	self thread phd_flopper_explosive_slide();

}

function phd_flopper_explosive_fall()
{
    self endon("death");
    self endon("disconnect");
    self endon(PERK_PHDFLOPPER + "_stop");

    for(;;)
    {
		self util::waittill_any_return("jump_begin", "slide_begin");
        
        startPos = self.origin[2];

        while(self IsSliding())
        	wait 0.1;

        while(!self IsOnGround())
            wait 0.1;
        
        endPos = self.origin[2];
        heightDiff = startPos - endPos;

        if(heightDiff > PHDFLOPPER_EXPLOSIVE_FALL_RANGE) 
        {
            self phd_flopper_explode();
            wait PHDFLOPPER_EXPLOSIVE_FALL_WAIT;
        }
        
    }

}

function phd_flopper_explosive_slide()
{
	self endon("death");
    self endon("disconnect");
    self endon(PERK_PHDFLOPPER + "_stop");

    for(;;)
    {

    	while(self IsSliding())
    	{
            self thread phd_flopper_explode();
            self.hasPHDSlide = true;
            wait PHDFLOPPER_SLIDE_WAIT;
    	}

    	if(IS_TRUE(self.hasPHDSlide))
    	{
    		wait PHDFLOPPER_SLIDE_COOLDOWN;
    		self.hasPHDSlide = false;
    	}

        // Add a WAIT_SERVER_FRAME incase people make the cooldown 0 seconds
        WAIT_SERVER_FRAME;

    }

}

function phd_flopper_explode() 
{

	// Spawn FX Model
	fxModel = util::spawn_model("tag_origin", self.origin);

	fx = PlayFXOnTag(level._effect["phdflopper_explode"], fxModel, "tag_origin");
	fxModel PlaySound("zmb_phdflop_explo_more");

	if(IS_TRUE(PHDFLOPPER_EXPLOSIVE_SCREEN_SHAKE))
		Earthquake(0.42, 1, self.origin, PHDFLOPPER_EXPLOSIVE_RADIUS);

	// Deal the damage
	RadiusDamage(self.origin, PHDFLOPPER_EXPLOSIVE_RADIUS, PHDFLOPPER_MAX_DAMAGE, PHDFLOPPER_MIN_DAMAGE, self, "MOD_EXPLOSIVE");

	// Wait with deleting, don't want to delete it too soon because the FX wouldn't show up
	wait 2;
	fxModel Delete();

	// Sometimes PlayFXOnTag doesn't delete the FX properly, we add this to make sure it's gone if it isn't deleted
	if(IsDefined(fx))
		fx Delete();

}

function phdflopper_lost( b_pause, str_perk, str_result )
{
	self notify(PERK_PHDFLOPPER + "_stop");
}

function register_player_stats()
{
	self globallogic_score::initPersStat(PERK_PHDFLOPPER + "_drank", false );
}