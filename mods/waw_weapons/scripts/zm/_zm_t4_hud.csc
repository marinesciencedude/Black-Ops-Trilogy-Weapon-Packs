#using scripts\codescripts\struct;

#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

REGISTER_SYSTEM_EX( "zm_t4_hud", &__init__, &__main__, undefined )

function __init__()
{
	if(GetDvarInt("mutator_hud") == 2)
	{
		// Clientfields
		clientfield::register( "clientuimodel", "t4_mule_kick", VERSION_SHIP, 1, "int", undefined, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );

		// Load the menu
		luiload( "ui.uieditor.menus.hud.T4Hud_zm_factory" );

		// Callbacks
		callback::on_localplayer_spawned( &on_localplayer_spawned );
	}
}

function __main__()
{
}

function set_ui_model_value( local_client_num, old_val, new_val, new_ent, initial_snap, field_name, was_time_jump )
{
	setuimodelvalue( createuimodel( getuimodelforcontroller( local_client_num ), field_name ), new_val );
}

function on_localplayer_spawned( local_client_num )
{
    self thread set_stock_max( local_client_num );
    self thread set_dw_clip_max( local_client_num );
    self thread set_weapon_class( local_client_num );
}

function set_stock_max( local_client_num )
{
    self endon( "disconnect" );
    self endon( "entityshutdown" );
    self notify( "set_stock_max" );
    self endon( "set_stock_max" );

    controller_model = getuimodelforcontroller( local_client_num );
    ammo_stock_max_model = createuimodel( controller_model, "currentWeapon.ammoStockMax" );

    while( true )
    {
        WAIT_CLIENT_FRAME;

        current_weapon = getcurrentweapon( local_client_num );
        ammo_stock_max = current_weapon.maxammo;

        if( IS_EQUAL( getuimodelvalue( ammo_stock_max_model ), ammo_stock_max ) )
        {
            continue;
        }

        setuimodelvalue( ammo_stock_max_model, ammo_stock_max );
    }
}

function set_dw_clip_max( local_client_num )
{
    self endon( "disconnect" );
    self endon( "entityshutdown" );
    self notify( "set_dw_clip_max" );
    self endon( "set_dw_clip_max" );

    controller_model = getuimodelforcontroller( local_client_num );
    clip_max_ammo_dw_model = createuimodel( controller_model, "currentWeapon.clipMaxAmmoDW" );

    while( true )
    {
        WAIT_CLIENT_FRAME;

        current_weapon = getcurrentweapon( local_client_num );
        clip_max_ammo_dw = current_weapon.dualwieldweapon.clipsize;

        if( IS_EQUAL( getuimodelvalue( clip_max_ammo_dw_model ), clip_max_ammo_dw ) )
        {
            continue;
        }

        setuimodelvalue( clip_max_ammo_dw_model, clip_max_ammo_dw );
    }
}

function set_weapon_class( local_client_num )
{
    self endon( "disconnect" );
    self endon( "entityshutdown" );
    self notify( "set_weapon_class" );
    self endon( "set_weapon_class" );

    controller_model = getuimodelforcontroller( local_client_num );
    weapon_class_model = createuimodel( controller_model, "currentWeapon.weaponClass" );

    while( true )
    {
        self waittill( "weapon_change", weapon );

        weapon_class = undefined;
        table = "gamedata/weapons/zm/zm_levelcommon_weapons.csv";
		switch(GetDvarString("mapname"))
		{
		case "zm_prototype":
			table = "gamedata/weapons/zm/zm_prototype_weapons.csv";
			break;
		case "zm_asylum":
			table = "gamedata/weapons/zm/zm_asylum_weapons.csv";
			break;
		case "zm_sumpf":
			table = "gamedata/weapons/zm/zm_sumpf_weapons.csv";
			break;
		case "zm_factory":
			table = "gamedata/weapons/zm/zm_factory_weapons.csv";
			break;
		case "zm_der_riese":
			table = "gamedata/weapons/zm/zm_der_riese_weapons.csv";
			break;
		case "zm_factory_classic":
			table = "gamedata/weapons/zm/zm_factory_classic_weapons.csv";
			break;
		case "zm_theater":
			table = "gamedata/weapons/zm/zm_theater_weapons.csv";
			break;
		case "zm_tomb":
			table = "gamedata/weapons/zm/zm_tomb_weapons.csv";
			break;
		case "zm_castle":
			table = "gamedata/weapons/zm/zm_castle_weapons.csv";
			break;
		case "zm_island":
			table = "gamedata/weapons/zm/zm_island_weapons.csv";
			break;
		}
        index = 1;
        row = tablelookuprow( table, index );

        while( isdefined( row ) )
        {
            weapon_name                     = weapon.rootweapon.name;
            table_weapon_name               = tolower( row[0] );
            table_weapon_upgraded_name      = tolower( row[1] );
            is_wonder_weapon                = IS_EQUAL( tolower( row[18] ), "true" );

            if( IS_EQUAL( weapon_name, table_weapon_name ) || IS_EQUAL( weapon_name, table_weapon_upgraded_name ) )
            {
				//you know I don't think so for Ray Gun
                /*if( IS_TRUE( is_wonder_weapon ) )
                {
                    weapon_class = "wonderweapon";
                }
                else*/
                {
                    weapon_class = tolower( row[16] );
                }

                break;
            }

            index++;
            row = tablelookuprow( table, index );
        }

        if( isdefined( weapon_class ) && IS_EQUAL( weapon_class, "special" ) )
        {
            weapon_class = weapon.weapclass;
        }

        if( !isdefined( weapon_class ) )
        {
            continue;
        }

        if( IS_EQUAL( getuimodelvalue( weapon_class_model ), weapon_class ) )
        {
            continue;
        }

        setuimodelvalue( weapon_class_model, weapon_class );
    }
}
