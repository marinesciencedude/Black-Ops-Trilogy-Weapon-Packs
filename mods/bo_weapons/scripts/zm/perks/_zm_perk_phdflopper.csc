// ====================================================================== \\
// PHD Flopper Credits:
//
// MikeyRay: Scripting, various edits on model, FX
// Humphrey: PHD Model Ripping
// JBird632: Scripting assistance
// MotoLegacy: Scripting assistance, PHD Sounds, PHD Stats, PHD Bottle and PHD Shader
// Activision & Treyarch: PHD Model (BO4), PHD Flopper Perk Idea (BO1)
// Scobalula: Greyhound
// ====================================================================== \\

#using scripts\codescripts\struct;

#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\visionset_mgr_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#using scripts\zm\_zm_perks;

#insert scripts\zm\perks\_zm_perk_phdflopper.gsh;
#insert scripts\zm\_zm_perks.gsh;
#insert scripts\zm\_zm_utility.gsh;

#using scripts\zm\_zm_perk_random;

#precache( "client_fx", PHDFLOPPER_LIGHTING_FX);

#namespace zm_perk_phdflopper;

REGISTER_SYSTEM( "zm_perk_phdflopper", &__init__, undefined )

// PHD FLOPPER

function __init__()
{
	// register custom functions for hud/lua
	zm_perks::register_perk_clientfields( PERK_PHDFLOPPER, &phd_flopper_client_field_func, &phd_flopper_code_callback_func );
	zm_perks::register_perk_effects( PERK_PHDFLOPPER, PHDFLOPPER_MACHINE_LIGHT_FX );
	zm_perks::register_perk_init_thread( PERK_PHDFLOPPER, &init_phd_flopper );
}

function private init_phd_flopper()
{
	if( IS_TRUE(level.enable_magic) )
		level._effect[PHDFLOPPER_MACHINE_LIGHT_FX]	= PHDFLOPPER_LIGHTING_FX;		

}

function private phd_flopper_client_field_func()
{
	clientfield::register( "clientuimodel", "hudItems.perks.phdflopper", VERSION_SHIP, 2, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT );
	clientfield::register( "clientuimodel", "hudItems.perks.phdflopper_bo", VERSION_SHIP, 2, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT );
	clientfield::register( "clientuimodel", "hudItems.perks.phd_flopper", VERSION_SHIP, 2, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT );
}

function private phd_flopper_code_callback_func()
{
}
