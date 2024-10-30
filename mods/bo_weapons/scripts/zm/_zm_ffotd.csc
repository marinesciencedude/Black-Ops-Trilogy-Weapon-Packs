
#using scripts\zm\_zm_mod;

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
	LuiLoad("ui.HUDInject.HUDInject");	
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
}