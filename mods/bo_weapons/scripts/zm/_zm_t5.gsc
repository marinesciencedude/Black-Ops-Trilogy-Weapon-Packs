#using scripts\codescripts\struct;

#using scripts\shared\ai\zombie;
#using scripts\shared\ai\zombie_utility;

#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\compass;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_sidequests;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;

#insert scripts\zm\_zm_utility.gsh;

#insert scripts\zm\_zm_t5.gsh;

#precache( "string", "GAME_PLAYER_NEEDS_TO_BE_REVIVED" );

#precache( "objective", "t5waypoint_revive0" );
#precache( "objective", "t5waypoint_revive1" );
#precache( "objective", "t5waypoint_revive2" );
#precache( "objective", "t5waypoint_revive3" );

#namespace zm_t5;

REGISTER_SYSTEM( "zm_t5", &__init__, undefined )

function __init__()
{
	if(GetDvarInt("mutator_hud") == 2)
	{
		clientfield::register( "clientuimodel", "hudItems.showDpadLeftWeapon", VERSION_SHIP, 3, "int" );
		clientfield::register( "clientuimodel", "hudItems.actionSlot4ammo", VERSION_DLC5, GetMinBitCountForNum( 36 ), "int" );

		// Add bots for testing
		//level thread add_zbots();

		callback::on_connect( &on_player_connect );
		callback::on_spawned( &on_player_spawned );

		for(i=0;i<4;i++) 
		{
			clientfield::register("world", "player_reviving" + i, VERSION_SHIP, 1, "int");
		}

		register_dpad_weapon( "t5_m16a1_up", DPAD_WEAP_TYPE_40MM );
		register_dpad_weapon( "t5_aug_up", DPAD_WEAP_TYPE_MASTERKEY );
		//register_dpad_weapon( "t5_ak47_up", DPAD_WEAP_TYPE_FLAMETHROWER ); //actually there isn't an image here
		register_dpad_weapon( "microwavegundw", DPAD_WEAP_TYPE_40MM );
		register_dpad_weapon( "microwavegundw_upgraded", DPAD_WEAP_TYPE_40MM );

		level thread revive_hud_think();
	}
}

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

function on_player_connect()
{
    self thread HandleReviveHUD();

    self revive_hud_create();
}

function on_player_spawned()
{
	self thread dpad_watcher();
}

function add_zbots()
{
	SetDvar("bot_AllowMovement", "1");
	SetDvar("bot_PressAttackBtn", "1");
	SetDvar("bot_PressMeleeBtn", "1");

	bot = undefined;
	wait 30;
	for( i = 0; i < 4; i++ )
	{
		bot = AddTestClient();

        bot.team = "allies";
        bot.pers["team"] = "allies";
        bot SetTeam( "allies" );

		wait( 2 );
	}
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


/******************************************************************************************************************************/
/******************************************************************************************************************************/
function CleanUpReviveHUD() 
{
    self util::waittill_any("bled_out", "player_revived", "fake_death", "player_suicide"); 
    Objective_Delete(4+self.playernum);
    self thread HandleReviveHUD();
}

function HandleReviveHUD() 
{
    self endon("disconnect");
    self endon("bled_out");
    self endon("player_revived");

    self.revive_waypoint_created = false;

    self waittill("player_downed");
    for(;;) 
    {
        self thread CleanUpReviveHUD();
        for(;;) 
        {
            if(!self.revive_waypoint_created) 
            {
                // IPrintLnBold(self.playernum);
                Objective_Add(4+self.playernum, "active", self.origin, istring("t5waypoint_revive" + self.playernum));
                self.revive_waypoint_created = true;
                Objective_OnEntity(4+self.playernum, self);
            }

            if(self.revivetrigger.beingRevived == 1) 
            {
                level clientfield::set("player_reviving" + self.playernum, 1);
            }
            else 
            {
                level clientfield::set("player_reviving" + self.playernum, 0);
            }
            
            Objective_SetVisibleToAll(4+self.playernum);
            Objective_SetInvisibleToPlayer(4+self.playernum, self);
            wait(0.05);
        }
    }
}

function revive_hud_think()
{
    self endon ( "disconnect" );
    
    while ( true )
    {
        wait( 0.1 );
        if ( !laststand::player_any_player_in_laststand() )
        {
            continue;
        }
        
        players = GetPlayers();
        playerToRevive = undefined;
            
        for( i = 0; i < players.size; i++ )
        {
            if( !players[i] laststand::player_is_in_laststand() || !isDefined( players[i].revivetrigger.createtime ) )
            {
                continue;
            }
            
            if( !isDefined(playerToRevive) || playerToRevive.revivetrigger.createtime > players[i].revivetrigger.createtime )
            {
                playerToRevive = players[i];
            }
        }
            
        if( isDefined( playerToRevive ) )
        {
            for( i = 0; i < players.size; i++ )
            {
                if( players[i] laststand::player_is_in_laststand() )
                {
                    continue;
                }
                        
                players[i] thread fadeReviveMessageOver( playerToRevive, 3.0 );
            }
            
            playerToRevive.revivetrigger.createtime = undefined;
            wait( 3.5 );
        }       
    }
}

function fadeReviveMessageOver( playerToRevive, time )
{
    revive_hud_show();
    self.revive_hud setText( &"GAME_PLAYER_NEEDS_TO_BE_REVIVED", playerToRevive );
    self.revive_hud fadeOverTime( time );
    self.revive_hud.alpha = 0;
}

function revive_hud_show()
{
    assert( IsDefined( self ) );
    assert( IsDefined( self.revive_hud ) );
    self.revive_hud.alpha = 1;
}

function revive_hud_show_n_fade(time)
{
    revive_hud_show();
    self.revive_hud fadeOverTime( time );
    self.revive_hud.alpha = 0;
}

function revive_hud_create()
{   
    self.revive_hud = newclientHudElem( self );
    self.revive_hud.alignX = "center";
    self.revive_hud.alignY = "middle";
    self.revive_hud.horzAlign = "center";
    self.revive_hud.vertAlign = "bottom";
    self.revive_hud.y = -80;
    self.revive_hud.foreground = true;
    self.revive_hud.font = "default";
    self.revive_hud.fontScale = 1.5;
    self.revive_hud.alpha = 0;
    self.revive_hud.color = ( 1.0, 1.0, 1.0 );
    self.revive_hud setText( "" );
}