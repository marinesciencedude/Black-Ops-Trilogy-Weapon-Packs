#using scripts\codescripts\struct;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_sidequests;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;

#using scripts\zm\_sticky_grenade;

#namespace zm_t5;

REGISTER_SYSTEM( "zm_t5", &__init__, undefined )

function __init__()
{
	if(GetDvarInt("mutator_hud") == 2)
	{
		LuiLoad( "ui.uieditor.menus.hud.T5.T5Hud_zm_factory" );
		LuiLoad( "ui.uieditor.widgets.hud.T5.HudPowerUpsZombie" );
		
		clientfield::register( "clientuimodel", "hudItems.showDpadLeftWeapon", VERSION_SHIP, 3, "int", undefined, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
		clientfield::register( "clientuimodel", "hudItems.actionSlot4ammo", VERSION_DLC5, GetMinBitCountForNum( 36 ), "int", undefined, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );

		for(i=0;i<4;i++) 
		{
			clientfield::register( "world", "player_reviving" + i, VERSION_SHIP, 1, "int", &updatePlayerRevivingFlag, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
		}
	}
}

function updatePlayerRevivingFlag(localClientNum, oldVal, newVal, bNewEnt, bInitialSnap, fieldName, bWasTimeJump) 
{
    substr = GetSubStr(fieldName, 15);
    playerNum = Int(substr);
    
    if(newVal != oldVal) 
    {
        model = GetUIModel(GetUIModelForController(localClientNum), "WorldSpaceIndicators.bleedOutModel" + playerNum + ".reviving");
        if(IsDefined(model)) 
        {
            SetUIModelValue(model, newVal);
        }
    }
}