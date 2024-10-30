#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_pers_upgrades;
#using scripts\zm\_zm_pers_upgrades_functions;
#using scripts\zm\_zm_pers_upgrades_system;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;

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
	zm_perks::register_perk_basic_info("specialty_rof", "doubletap", 2000, &"ZOMBIE_PERK_DOUBLETAP", getweapon("zombie_perk_bottle_doubletap"));
	zm_perks::register_perk_precache_func("specialty_rof", &doubletap_precache);
	zm_perks::register_perk_clientfields("specialty_rof", &doubletap_register_clientfield, &doubletap_set_clientfield);
	zm_perks::register_perk_machine("specialty_rof", &doubletap_perk_machine_setup);
	zm_perks::register_perk_host_migration_params("specialty_rof", "vending_doubletap", "doubletap_light");
}

function doubletap_precache()
{
	if(isdefined(level.doubletap_precache_override_func))
	{
		[[level.doubletap_precache_override_func]]();
		return;
	}
	level._effect["doubletap_light"] = "zombie/fx_perk_doubletap2_zmb";
	level.machine_assets["specialty_rof"] = spawnstruct();
	level.machine_assets["specialty_rof"].weapon = getweapon("zombie_perk_bottle_doubletap");
	level.machine_assets["specialty_rof"].off_model = "p7_zm_vending_doubletap2";
	level.machine_assets["specialty_rof"].on_model = "p7_zm_vending_doubletap2";
}

function doubletap_register_clientfield()
{
	clientfield::register( "clientuimodel", "hudItems.perks.doubletap", 1, 2, "int");
	clientfield::register( "clientuimodel", "hudItems.perks.doubletap_bo", 1, 2, "int");
	clientfield::register( "clientuimodel", "hudItems.perks.doubletap_recolour", 1, 2, "int");
}

function doubletap_set_clientfield(state)
{
	if(GetDvarInt("mutator_bo_perk_icons") == 1 && GetDvarString("mapname") != "zm_der_riese") //doesn't need to be done on Der Riese: Declassified
	{
		self clientfield::set_player_uimodel( "hudItems.perks.doubletap_bo", state );
	}
	else if(GetDvarInt("mutator_bo_perk_icons") == 2)
	{
		self clientfield::set_player_uimodel( "hudItems.perks.doubletap_recolour", state );
	}
	else
	{
		self clientfield::set_player_uimodel("hudItems.perks.doubletap", state);
	}
}

function doubletap_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound = "mus_perks_doubletap_jingle";
	use_trigger.script_string = "tap_perk";
	use_trigger.script_label = "mus_perks_doubletap_sting";
	use_trigger.target = "vending_doubletap";
	perk_machine.script_string = "tap_perk";
	perk_machine.targetname = "vending_doubletap";
	if(isdefined(bump_trigger))
	{
		bump_trigger.script_string = "tap_perk";
	}
}