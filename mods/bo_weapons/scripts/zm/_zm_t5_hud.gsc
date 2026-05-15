#using scripts\codescripts\struct;

#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;

#using scripts\zm\_zm;
#using scripts\zm\_zm_utility;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#insert scripts\zm\_zm_utility.gsh;
#insert scripts\zm\_zm_t5.gsh;

REGISTER_SYSTEM_EX( "zm_t5_hud", &__init__, &__main__, undefined )

function __init__()
{
	if(GetDvarInt("mutator_hud") == 2)
	{
		// Clientfields
		clientfield::register( "clientuimodel", "t5_mule_kick", VERSION_SHIP, 1, "int" );
		clientfield::register( "clientuimodel", "hudItems.showDpadLeftWeapon", VERSION_SHIP, 3, "int" );
		clientfield::register( "clientuimodel", "hudItems.actionSlot4ammo", VERSION_DLC5, GetMinBitCountForNum( 36 ), "int" );

		// Callbacks
		callback::on_connect( &on_player_connect );
		callback::on_spawned( &on_player_spawned );
		
		register_dpad_weapon( "t5_m16a1_up", DPAD_WEAP_TYPE_40MM );
		register_dpad_weapon( "t5_aug_up", DPAD_WEAP_TYPE_MASTERKEY );
		//register_dpad_weapon( "t5_ak47_up", DPAD_WEAP_TYPE_FLAMETHROWER ); //actually there isn't an image here
		register_dpad_weapon( "microwavegundw", DPAD_WEAP_TYPE_40MM );
		register_dpad_weapon( "microwavegundw_upgraded", DPAD_WEAP_TYPE_40MM );
	}
}

function __main__()
{
	// Remove default game-over text
	level._supress_survived_screen = true;
	
	// Set team colors
	level thread set_team_colors();
}

function on_player_connect()
{
	self thread set_mule_kick_clientfield();
	self thread set_revive_text();
}

function on_player_spawned()
{
	self thread dpad_watcher();
}

function set_player_uimodel_clientfield( name, val )
{
	if( IS_EQUAL( self clientfield::get_player_uimodel( name ), val ) )
	{
		return;
	}

	self clientfield::set_player_uimodel( name, val );
}

function set_world_clientfield( name, val )
{
	if( IS_EQUAL( level clientfield::get( name ), val ) )
	{
		return;
	}

	level clientfield::set( name, val );
}

function set_mule_kick_clientfield()
{
    self endon( "disconnect" );
	self notify( "set_mule_kick_clientfield" );
	self endon( "set_mule_kick_clientfield" );

	while( true )
	{
		self waittill( "weapon_change", weapon );

		mule_kick = false;
		primary_weapons = self getweaponslistprimaries();

		if( primary_weapons.size > 2 )
		{
			last_weapon = primary_weapons[primary_weapons.size - 1];

			if( IS_EQUAL( last_weapon, weapon ) )
			{
				mule_kick = !IS_EQUAL( last_weapon, level.zombie_powerup_weapon["minigun"] );
			}
		}

		self set_player_uimodel_clientfield( "t5_mule_kick", mule_kick );
	}
}

function set_revive_text()
{
    self endon( "disconnect" );
	self notify( "set_revive_text" );
	self endon( "set_revive_text" );

	while( true )
	{
		WAIT_SERVER_FRAME;

		if( isdefined( self.revivetexthud ) )
		{
			self.revivetexthud settext( "" );
		}
	}
}

function set_team_colors()
{
	team_colors = array::randomize( array(
		"1.00 1.00 1.00 1",
		"0.48 0.81 0.93 1",
		"0.96 0.79 0.31 1",
		"0.51 0.92 0.53 1"
	) );

	foreach( index, color in team_colors )
	{
		setdvar( "cg_scorescolor_gamertag_" + index, color );
	}
}

//from original T5_HUD by GCP, Kingslayer, Kyle, Lilrifa, Jarik, Scobalula, DTZxPorter
function register_dpad_weapon( w_weapon, bit_type )
{
	if( !isdefined( level.t5_dpad_weapons ) )
	{
		level.t5_dpad_weapons = [];
	}

	struct = SpawnStruct();
	struct.weapon = GetWeapon( w_weapon );
	struct.weapon_alt = GetWeapon( w_weapon.altWeapon );
	if( isdefined( level._d2p_weapons[ w_weapon ] ) )
	{
		struct.weapon_d2p = GetWeapon( level._d2p_weapons[ GetWeapon( w_weapon ) ] );
		struct.weapon_d2p_alt = GetWeapon( level._d2p_weapons[ GetWeapon( w_weapon.altWeapon ) ] );
	}

	struct.bit_type = bit_type;

	level.t5_dpad_weapons[ level.t5_dpad_weapons.size ] = struct;
}

// this is messy, but fuck it I guess
function dpad_watcher()
{
	self notify( "dpad_watcher" ); 
	self endon( "dpad_watcher" ); 
	self endon( "disconnect" );

	while( true )
	{
		self waittill( "weapon_change" );

		w_curr_weapon = self GetCurrentWeapon();
		primaries = self GetWeaponsListPrimaries();

		b_has_alt = 0;
		n_alt_weapon_count = 0;

		foreach( weapon in primaries )
		{
			if( self has_valid_alt_weapon( weapon ) )
			{
				b_has_alt = 1;
				n_alt_weapon_count++;
			}
		}

		self clientfield::set_player_uimodel( "hudItems.showDpadLeft", b_has_alt );


		bit_type = DPAD_WEAP_TYPE_NONE;

		if( n_alt_weapon_count > 1 )
		{
            b_use_current_weapon = false;

            for( i = 0; i < primaries.size; i++ )
            {
                if( self has_valid_alt_weapon( primaries[ i ] ) )
                {
                    if( ( primaries[ i ].rootWeapon == w_curr_weapon.rootWeapon ) || ( primaries[ i ].rootWeapon == w_curr_weapon.altWeapon.rootWeapon ) )
                    {
                        b_use_current_weapon = true;
                    }
                }
            }

            if( b_use_current_weapon )
            {
                w_weapon = undefined;
                for( i = 0; i < primaries.size; i++ )
                {
                    if( self has_valid_alt_weapon( primaries[ i ] ) )
                    {
                        if( ( primaries[ i ].rootWeapon == w_curr_weapon.rootWeapon ) || ( primaries[ i ].rootWeapon == w_curr_weapon.altWeapon.rootWeapon ) )
                        {
                            w_weapon = primaries[ i ];
                        }
                    }
                }

                bit_type = self get_valid_alt_weapon_bit_type( w_weapon );

                self thread weapon_alt_ammo_counter( w_weapon.altWeapon );

                if( isdefined( bit_type ) )
                {
                    self clientfield::set_player_uimodel( "hudItems.showDpadLeftWeapon", bit_type );
                }
            }
            else
            {
                // gets the closest weapon to 0
                index = self get_closest_weapon_index_to_zero();
                weapon = primaries[ index ];

                bit_type = self get_valid_alt_weapon_bit_type( weapon );

                self thread weapon_alt_ammo_counter( weapon.altWeapon );

                if( isdefined( bit_type ) )
                {
                    self clientfield::set_player_uimodel( "hudItems.showDpadLeftWeapon", bit_type );
                }
            }
		}

		else if( n_alt_weapon_count == 1 )
		{
			for( i = 0; i < primaries.size; i++ )
			{
				if( self has_valid_alt_weapon( primaries[ i ] ) )
				{
					bit_type = self get_valid_alt_weapon_bit_type( primaries[ i ] );

					self thread weapon_alt_ammo_counter( primaries[ i ].altWeapon );

					if( isdefined( bit_type ) )
                    {
                        self clientfield::set_player_uimodel( "hudItems.showDpadLeftWeapon", bit_type );
                    }
				}
			}
		}

        else
        {
            self clientfield::set_player_uimodel( "hudItems.showDpadLeftWeapon", bit_type );
            self clientfield::set_player_uimodel( "hudItems.actionSlot4ammo", 0 );
        }

		continue;
	}
}

function get_closest_weapon_index_to_zero()
{
    primaries = self GetWeaponsListPrimaries();
    index = primaries.size;

    for( i = primaries.size - 1; i >= 0; i-- )
    {
        if( self has_valid_alt_weapon( primaries[ i ] ) )
        {
            index = i;
        }
    }

    return index;
}

function weapon_alt_ammo_counter( w_weapon )
{
	self notify( "weapon_alt_ammo_counter" ); 
	self endon( "weapon_alt_ammo_counter" );
    self endon( "disconnect" ); 
	self endon( "weapon_change" );

	while( true )
	{
		ammo = self GetAmmoCount( w_weapon );
		self clientfield::set_player_uimodel( "hudItems.actionSlot4ammo", ammo );
		WAIT_SERVER_FRAME;
	}
}

// don't need to check the alt weapon since this is all defined in the array
function has_valid_alt_weapon( w_weapon )
{
    if( isdefined( level.t5_dpad_weapons ) )
    {
        for( i = 0; i < level.t5_dpad_weapons.size; i++ )
        {
            if( ( w_weapon.rootWeapon == level.t5_dpad_weapons[ i ].weapon.rootWeapon ) || ( w_weapon.rootWeapon == level._d2p_weapons[ level.t5_dpad_weapons[ i ].weapon ] ) )
            {
                return true;
            }
        }
    }

	return false;
}

// don't need to check the alt weapon since this is all defined in the array
function get_valid_alt_weapon_bit_type( w_weapon )
{
	for( i = 0; i < level.t5_dpad_weapons.size; i++ )
	{
		if( ( w_weapon.rootWeapon == level.t5_dpad_weapons[ i ].weapon.rootWeapon ) || ( w_weapon.rootWeapon == level._d2p_weapons[ level.t5_dpad_weapons[ i ].weapon ] ) )
		{
			return level.t5_dpad_weapons[ i ].bit_type;
		}
	}

	return undefined;
}