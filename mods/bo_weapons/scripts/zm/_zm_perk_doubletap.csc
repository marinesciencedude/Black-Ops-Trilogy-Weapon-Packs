#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_zm_perks;

#namespace zm_perk_doubletap;

function autoexec __init__sytem__()
{
	system::register("zm_perk_doubletap", &__init__, undefined, undefined);
}

function __init__()
{
	enable_doubletap_perk_for_level();
}

function enable_doubletap_perk_for_level()
{
	zm_perks::register_perk_clientfields("specialty_rof", &doubletap_client_field_func, &doubletap_code_callback_func);
	zm_perks::register_perk_effects("specialty_rof", "doubletap_light");
	zm_perks::register_perk_init_thread("specialty_rof", &init_doubletap);
}

function init_doubletap()
{
	if(isdefined(level.enable_magic) && level.enable_magic)
	{
		level._effect["doubletap_light"] = "zombie/fx_perk_doubletap2_zmb";
	}
}

function doubletap_client_field_func()
{
	clientfield::register( "clientuimodel", "hudItems.perks.doubletap", 1, 2, "int", undefined, 0, 1); 
	clientfield::register( "clientuimodel", "hudItems.perks.doubletap_bo", 1, 2, "int", undefined, 0, 1); 
	clientfield::register( "clientuimodel", "hudItems.perks.doubletap_recolour", 1, 2, "int", undefined, 0, 1); 
}

function doubletap_code_callback_func()
{
}