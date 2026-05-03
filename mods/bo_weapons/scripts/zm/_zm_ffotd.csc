
#using scripts\zm\_zm_mod;
#using scripts\shared\clientfield_shared;
#using scripts\zm\_zm_powerups;
#using scripts\zm\crossbow_bolt;
//#using scripts\zm\_zm_t5_hud;
//#using scripts\zm\_zm_weap_freezegun;

#insert scripts\shared\version.gsh;

#precache( "client_fx", "custom/magic_box_og/fx_weapon_box_open_glow_og" );
#precache( "client_fx", "wetegg/iwperks/emptyFXIW" );

#define RED_EYE_FX    "frost_iceforge/red_zombie_eyes"
#define ORANGE_EYE_FX    "frost_iceforge/orange_zombie_eyes"
#define GREEN_EYE_FX    "frost_iceforge/green_zombie_eyes"
#define BLUE_EYE_FX    "frost_iceforge/blue_zombie_eyes"
#define PURPLE_EYE_FX    "frost_iceforge/purple_zombie_eyes"
#define PINK_EYE_FX    "frost_iceforge/pink_zombie_eyes"
#define WHITE_EYE_FX    "frost_iceforge/white_zombie_eyes"
#precache( "client_fx", RED_EYE_FX );
#precache( "client_fx", ORANGE_EYE_FX );
#precache( "client_fx", GREEN_EYE_FX );
#precache( "client_fx", BLUE_EYE_FX );
#precache( "client_fx", PURPLE_EYE_FX );
#precache( "client_fx", PINK_EYE_FX );
#precache( "client_fx", WHITE_EYE_FX );

#namespace zm_ffotd;

function main_start() {
    zm_mod::main();
}

function main_end()
{
	if(GetDvarInt("mutator_mystery_box_fx") == 2) //Classic FX on
	{
		level._effect["chest_light"] = "custom/magic_box_og/fx_weapon_box_open_glow_og";
		level._effect["chest_light_closed"] = "wetegg/iwperks/emptyFXIW";
	}
	
	switch(GetDvarInt("mutator_eye_colour"))
	{
		case 2:
			level._override_eye_fx = ORANGE_EYE_FX;
			break;
		case 3:
			level._override_eye_fx = BLUE_EYE_FX;
			break;
		case 4:
			level._override_eye_fx = RED_EYE_FX;
			break;
		case 5:
			level._override_eye_fx = WHITE_EYE_FX;
			break;
		case 6:
			level._override_eye_fx = GREEN_EYE_FX;
			break;
		case 7:
			level._override_eye_fx = PURPLE_EYE_FX;
			break;
		case 8:
			level._override_eye_fx = PINK_EYE_FX;
			break;
		case 9:
			level._override_eye_fx = "wetegg/iwperks/emptyFXIW";
			break;
	}
	
	if(GetDvarInt("mutator_bo_perk_icons") == 1)
	{
		clientfield::register( "clientuimodel", "hudItems.perks.quick_revive_bo", VERSION_SHIP, 2, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT );
		clientfield::register( "clientuimodel", "hudItems.perks.additional_primary_weapon_bo", VERSION_SHIP, 2, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT );
		clientfield::register( "clientuimodel", "hudItems.perks.dead_shot_bo", VERSION_SHIP, 2, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT ); 
		clientfield::register( "clientuimodel", "hudItems.perks.electric_cherry_bo", VERSION_SHIP, 2, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT ); 
		clientfield::register( "clientuimodel", "hudItems.perks.juggernaut_bo", VERSION_SHIP, 2, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT );
		clientfield::register( "clientuimodel", "hudItems.perks.sleight_of_hand_bo", VERSION_SHIP, 2, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT );
		clientfield::register( "clientuimodel", "hudItems.perks.marathon_bo", VERSION_SHIP, 2, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT ); 
		clientfield::register( "clientuimodel", "hudItems.perks.widows_wine_bo", VERSION_SHIP, 2, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT ); 
		if(GetDvarString("mapname") != "zm_factory_classic")
			clientfield::register( "clientuimodel", "hudItems.perks.doubletap2_bo", VERSION_SHIP, 2, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT ); 
		clientfield::register( "clientuimodel", "hudItems.perks.doubletap_bo", 1, 2, "int", undefined, 0, 1); 
	}
	else if(GetDvarInt("mutator_bo_perk_icons") == 2)
	{
		clientfield::register( "clientuimodel", "hudItems.perks.quick_revive_recolour", VERSION_SHIP, 2, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT );
		clientfield::register( "clientuimodel", "hudItems.perks.additional_primary_weapon_recolour", VERSION_SHIP, 2, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT );
		clientfield::register( "clientuimodel", "hudItems.perks.dead_shot_recolour", VERSION_SHIP, 2, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT ); 
		clientfield::register( "clientuimodel", "hudItems.perks.electric_cherry_recolour", VERSION_SHIP, 2, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT ); 
		clientfield::register( "clientuimodel", "hudItems.perks.juggernaut_recolour", VERSION_SHIP, 2, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT );
		clientfield::register( "clientuimodel", "hudItems.perks.sleight_of_hand_recolour", VERSION_SHIP, 2, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT );
		clientfield::register( "clientuimodel", "hudItems.perks.marathon_recolour", VERSION_SHIP, 2, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT ); 
		clientfield::register( "clientuimodel", "hudItems.perks.widows_wine_recolour", VERSION_SHIP, 2, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT ); 
		if(GetDvarString("mapname") != "zm_factory_classic")
			clientfield::register( "clientuimodel", "hudItems.perks.doubletap2_recolour", VERSION_SHIP, 2, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT ); 
		clientfield::register( "clientuimodel", "hudItems.perks.doubletap_recolour", 1, 2, "int", undefined, 0, 1); 
	}
	else if(GetDvarString("mapname") != "zm_factory_classic")
		clientfield::register( "clientuimodel", "hudItems.perks.doubletap", 1, 2, "int", undefined, 0, 1); 

	if(GetDvarInt("mutator_bo_powerup_icons") == 1)
	{
		clientfield::register("toplayer", "powerup_instant_kill_bo", 1, 2, "int", &zm_powerups::powerup_state_callback, 0, 1);
		level.zombie_powerups["insta_kill"].client_field_name = "powerup_instant_kill_bo";
		clientfield::register("toplayer", "powerup_double_points_bo", 1, 2, "int", &zm_powerups::powerup_state_callback, 0, 1);
		level.zombie_powerups["double_points"].client_field_name = "powerup_double_points_bo";
		clientfield::register("toplayer", "powerup_fire_sale_bo", 1, 2, "int", &zm_powerups::powerup_state_callback, 0, 1);
		level.zombie_powerups["fire_sale"].client_field_name = "powerup_fire_sale_bo";
		clientfield::register("toplayer", "powerup_mini_gun_bo", 1, 2, "int", &zm_powerups::powerup_state_callback, 0, 1);
		level.zombie_powerups["minigun"].client_field_name = "powerup_mini_gun_bo";
		clientfield::register("toplayer", "powerup_zombie_blood_bo", 1, 2, "int", &zm_powerups::powerup_state_callback, 0, 1);
		level.zombie_powerups["zombie_blood"].client_field_name = "powerup_zombie_blood_bo";
	}
}