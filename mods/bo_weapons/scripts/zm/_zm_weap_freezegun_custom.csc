#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_weapons;
#insert scripts\shared\duplicaterender.gsh;
#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;
#insert scripts\zm\_zm_weap_freezegun_custom.gsh;

#precache( "client_fx", FX_FREEZEGUN_SHATTER );
#precache( "client_fx", FX_FREEZEGUN_CRUMPLE );

#namespace zm_weap_freezegun_custom;

function autoexec init_system()
{
	if(GetDvarString("mapname") != "zm_pentagon")
		system::register( "zm_weap_freezegun_custom", &__init__, undefined, undefined );
}

function __init__()
{
	clientfield::register( "actor", "toggle_freezegun_crumple", VERSION_DLC5, 1, "int", &freezegun_do_crumple_fx, 0, 0 );
	clientfield::register( "actor", "toggle_freezegun_shatter", VERSION_DLC5, 1, "int", &freezegun_do_shatter_fx, 0, 0 );
	clientfield::register( "actor", "toggle_freezegun_iceover", VERSION_DLC5, 1, "int", &freezegun_iceover, 0, 0 );
	duplicate_render::set_dr_filter_framebuffer( "dissolve", 9, "dissolve_on", undefined, DR_TYPE_FRAMEBUFFER, "mc/c_t8_freezegun_mtl", DR_CULL_ALWAYS );
	level._effect[ "freezegun_shatter" ] = FX_FREEZEGUN_SHATTER;
	level._effect[ "freezegun_crumple" ] = FX_FREEZEGUN_CRUMPLE;
}

function freezegun_iceover( localClientNum, oldVal, newVal, bNewEnt, bInitialSnap, fieldName )
{
	self endon( "entity_shutdown" );
	const N_STEP = 0.0166;
	self duplicate_render::set_dr_flag( "dissolve_on", 1 );
	self duplicate_render::update_dr_filters( localClientNum );
	self duplicate_render::update_dr_flag( localClientNum, "dissolve_on", newVal );
}

function freezegun_do_crumple_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
	self endon( "death" );
	self delete_fx( localclientnum, self.freezegun_crumple_fx );
	if( newval ) {
		self.freezegun_crumple_fx = PlayFXOnTag( localclientnum, level._effect["freezegun_crumple"], self, "J_SpineLower" );
	}
}

function freezegun_do_shatter_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
	self delete_fx( localclientnum, self.freezegun_shatter_fx );
	if( newval ) {
		self.freezegun_shatter_fx = PlayFXOnTag( localclientnum, level._effect["freezegun_shatter"], self, "J_SpineLower" );
	}
}

function delete_fx( localclientnum, fx )
{
	if( isdefined( fx ) ) {
		DeleteFX( localclientnum, fx );
		fx = undefined;
	}
}