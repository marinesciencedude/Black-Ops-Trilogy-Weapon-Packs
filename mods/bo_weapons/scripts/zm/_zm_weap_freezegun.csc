#using scripts\codescripts\struct;

// Shared
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;

#insert scripts\shared\duplicaterender.gsh;
#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

// ZM
#using scripts\zm\_zm;
#using scripts\zm\_zm_weapons;

#insert scripts\zm\_zm_weap_freezegun.gsh;

#precache( "client_fx", FX_FREEZEGUN_SHATTER );
#precache( "client_fx", FX_FREEZEGUN_CRUMPLE );
#precache( "client_fx", FX_FREEZEGUN_SMOKE_CLOUD );
#precache( "client_fx", FX_FREEZEGUN_FREEZE_TORSO );
#precache( "client_fx", FX_FREEZEGUN_FREEZE_MD );
#precache( "client_fx", FX_FREEZEGUN_SHATTER_UPGRADED );
#precache( "client_fx", FX_FREEZEGUN_CRUMPLE_UPGRADED );
#precache( "client_fx", FX_FREEZEGUN_SHATTER_GIB );
#precache( "client_fx", FX_FREEZEGUN_SHATTER_GIBTRAIL );
#precache( "client_fx", FX_FREEZEGUN_CRUMPLE_GIB );
#precache( "client_fx", FX_FREEZEGUN_CRUMPLE_GIBTRAIL );

#namespace zm_weap_freezegun;

function autoexec init_system()
{
	system::register( "zm_weap_freezegun", &__init__, undefined, undefined );
}

function __init__()
{
	clientfield::register( "actor", "toggle_freezegun_extremity_damage_fx", VERSION_SHIP, 1, "int", &freezegun_extremity_damage_fx, 0, 0 );
	clientfield::register( "actor", "toggle_freezegun_crumple", VERSION_SHIP, 1, "int", &freezegun_do_crumple_fx, 0, 0 );
	clientfield::register( "actor", "toggle_freezegun_torso_damage_fx", VERSION_SHIP, 1, "int", &freezegun_torso_damage_fx, 0, 0 );
	clientfield::register( "actor", "toggle_freezegun_iceover", VERSION_SHIP, 1, "int", &freezegun_iceover, 0, 0 );

	duplicate_render::set_dr_filter_framebuffer( "dissolve", 9, "dissolve_on", undefined, DR_TYPE_FRAMEBUFFER, "mc/c_t8_freezegun_mtl", DR_CULL_ALWAYS );

	level._gib_overload_func = &freezegun_gib_override;

	level._effect[ "freezegun_shatter" ]				= FX_FREEZEGUN_SHATTER;
	level._effect[ "freezegun_crumple" ]				= FX_FREEZEGUN_CRUMPLE;
	level._effect[ "freezegun_smoke_cloud" ]			= FX_FREEZEGUN_SMOKE_CLOUD;
	level._effect[ "freezegun_damage_torso" ]			= FX_FREEZEGUN_FREEZE_TORSO;
	level._effect[ "freezegun_damage_sm" ]				= FX_FREEZEGUN_FREEZE_MD;
	level._effect[ "freezegun_shatter_upgraded" ]		= FX_FREEZEGUN_SHATTER_UPGRADED;
	level._effect[ "freezegun_crumple_upgraded" ]		= FX_FREEZEGUN_CRUMPLE_UPGRADED;


	level._effect[ "freezegun_shatter_gib_fx" ]			= FX_FREEZEGUN_SHATTER_GIB;
	level._effect[ "freezegun_shatter_gibtrail_fx" ]	= FX_FREEZEGUN_SHATTER_GIBTRAIL;
	level._effect[ "freezegun_crumple_gib_fx" ]			= FX_FREEZEGUN_CRUMPLE_GIB;
	level._effect[ "freezegun_crumple_gibtrail_fx" ]	= FX_FREEZEGUN_CRUMPLE_GIBTRAIL;

	level thread player_init();
}

function freezegun_iceover( localClientNum, oldVal, newVal, bNewEnt, bInitialSnap, fieldName )
{
	self endon( "entity_shutdown" );
	
	//self.n_ice = 1;

	const N_STEP = 0.0166;	// 1.0 / 60 ticks (1.45 sec)  , slightly less than the anim length
	
	// Ghostly material
	self duplicate_render::set_dr_flag( "dissolve_on", 1 );
	self duplicate_render::update_dr_filters( localClientNum );

	if( newVal == 1 )
	{
		self thread set_ice_emissive( localclientnum );
	}
	
	if( newVal == 0 )
	{
		self thread unset_ice_emissive( localclientnum );
	}
}

function set_ice_emissive( localClientNum )
{
	self endon("entityshutdown");
	self endon("unfreeze");
	n_ice = 0.9;
	rate = RandomFloatRange(0.005, 0.01);
	for(f = 0.6; f <= n_ice; f = 0.6)
	{
		self SetShaderConstant(localClientNum, 0, f, 1, 0, 0);
		util::server_wait(localClientNum, 0.05);
	}
}

function unset_ice_emissive( localClientNum )
{
	self endon("entityshutdown");
	self notify("unfreeze");
	for(f = 1; f >= 0.6; f = 1)
	{
		self SetShaderConstant(localClientNum, 0, f, 1, 0, 0);
		util::server_wait(localClientNum, 0.05);
	}
	self SetShaderConstant(localClientNum, 0, 0, 0, 0, 0);
}


function player_init()
{
	util::waitforclient(0);
	players = GetLocalPlayers();
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
	}
}


function freezegun_get_gibfx( shatter )
{
	if ( shatter )
	{
		return level._effect[ "freezegun_shatter_gib_fx" ];
	}
	else
	{
		return level._effect[ "freezegun_crumple_gib_fx" ];
	}
}


function freezegun_get_gibtrailfx( shatter )
{
	if ( shatter )
	{
		return level._effect[ "freezegun_shatter_gibtrail_fx" ];
	}
	else
	{
		return level._effect[ "freezegun_crumple_gibtrail_fx" ];
	}
}


function freezegun_get_gibsound( shatter )
{
	if ( shatter )
	{
		return "zmb_death_gibs";
	}
	else
	{
		return "zmb_death_gibs";
	}
}


function freezegun_get_gibforce( tag, force_from_torso, shatter )
{
	if ( shatter )
	{
		start_pos = self.origin;
		if ( force_from_torso )
		{
			start_pos = self GetTagOrigin( "J_SpineLower" );
		}

		forward = VectorNormalize( self gettagorigin( tag ) - start_pos );
		forward *= RandomIntRange( 600, 1000 );
		forward += (0, 0, RandomIntRange( 400, 700 ));
		return forward;
	}
	else
	{
		return (0, 0, 0);
	}
}


function freezegun_get_shatter_effect( upgraded )
{
	if ( upgraded )
	{
		return level._effect[ "freezegun_shatter_upgraded" ];
	}
	else
	{
		return level._effect[ "freezegun_shatter" ];
	}
}


function freezegun_get_crumple_effect( upgraded )
{
	if ( upgraded )
	{
		return level._effect[ "freezegun_crumple_upgraded" ];
	}
	else
	{
		return level._effect[ "freezegun_crumple" ];
	}
}


function freezegun_end_extremity_damage_fx( localclientnum, key )
{
	DeleteFX( localclientnum, self.freezegun_extremity_damage_fx_handles[localclientnum][key], false );
}


function freezegun_end_all_extremity_damage_fx( localclientnum )
{
	keys = getArrayKeys( self.freezegun_extremity_damage_fx_handles[localclientnum] );
	for ( i = 0; i < keys.size; i++ )
	{
		freezegun_end_extremity_damage_fx( localclientnum, keys[i] );
	}
}


function freezegun_end_extremity_damage_fx_for_all_localclients( key )
{
	players = GetLocalPlayers();
	for( i = 0; i < players.size; i++ )
	{
		freezegun_end_extremity_damage_fx( i, key );
	}
}


function freezegun_play_extremity_damage_fx( localclientnum, fx, key, tag )
{
	self.freezegun_extremity_damage_fx_handles[localclientnum][key] = PlayFxOnTag( localclientnum, fx, self, tag );
}


function freezegun_play_all_extremity_damage_fx( localclientnum )
{
	if ( !IsDefined( self.freezegun_extremity_damage_fx_handles ) )
	{
		self.freezegun_extremity_damage_fx_handles = [];
	}

	if ( IsDefined( self.freezegun_extremity_damage_fx_handles[localclientnum] ) )
	{
		return;
	}

	self.freezegun_extremity_damage_fx_handles[localclientnum] = [];

	if ( !self zm::has_gibbed_piece( level._ZOMBIE_GIB_PIECE_INDEX_RIGHT_ARM ) )
	{
		freezegun_play_extremity_damage_fx( localclientnum, level._effect[ "freezegun_damage_sm" ], "right_arm", "J_Elbow_RI" );
	}
	if ( !self zm::has_gibbed_piece( level._ZOMBIE_GIB_PIECE_INDEX_LEFT_ARM ) )
	{
		freezegun_play_extremity_damage_fx( localclientnum, level._effect[ "freezegun_damage_sm" ], "left_arm", "J_Elbow_LE" );
	}
	if ( !self zm::has_gibbed_piece( level._ZOMBIE_GIB_PIECE_INDEX_RIGHT_LEG ) )
	{
		freezegun_play_extremity_damage_fx( localclientnum, level._effect[ "freezegun_damage_sm" ], "right_leg", "J_Knee_RI" );
	}
	if ( !self zm::has_gibbed_piece( level._ZOMBIE_GIB_PIECE_INDEX_LEFT_LEG ) )
	{
		freezegun_play_extremity_damage_fx( localclientnum, level._effect[ "freezegun_damage_sm" ], "left_leg", "J_Knee_LE" );
	}
}


function freezegun_extremity_damage_fx( localClientNum, oldVal, newVal, bNewEnt, bInitialSnap, fieldName, bWasDemoJump )
{
	players = GetLocalPlayers();
	for ( i = 0; i < players.size; i++ )
	{
		if ( newVal )
		{
			self thread freezegun_play_all_extremity_damage_fx( i );
		}
		else
		{
			self thread freezegun_end_all_extremity_damage_fx( i );
		}
	}
}


function freezegun_end_all_torso_damage_fx( localclientnum )
{
	DeleteFX( localclientnum, self.freezegun_damage_torso_fx[localclientnum], true );
}


function freezegun_play_all_torso_damage_fx( localclientnum )
{
	if ( !IsDefined( self.freezegun_damage_torso_fx ) )
	{
		self.freezegun_damage_torso_fx = [];
	}

	if ( IsDefined( self.freezegun_damage_torso_fx[localclientnum] ) )
	{
		return;
	}

	self.freezegun_damage_torso_fx[localclientnum] = PlayFXOnTag( localclientnum, level._effect[ "freezegun_damage_torso" ], self, "J_SpineLower" );
}


function freezegun_torso_damage_fx( localClientNum, oldVal, newVal, bNewEnt, bInitialSnap, fieldName )
{
	players = GetLocalPlayers();
	for ( i = 0; i < players.size; i++ )
	{
		if ( newVal )
		{
			self thread freezegun_play_all_torso_damage_fx( i );
		}
		else
		{
			self thread freezegun_end_all_torso_damage_fx( i );
		}
	}
}


function freezegun_do_gib_fx( tag, shatter )
{
	players = GetLocalPlayers();
	for ( i = 0; i < players.size; i++ )
	{
		PlayFXOnTag( i, freezegun_get_gibtrailfx( shatter ), self, tag ); 
	}
	//PlaySound( 0, freezegun_get_gibsound( shatter ), self gettagorigin( tag ) );
}


function freezegun_do_gib( model, tag, force_from_torso, shatter )
{
	//PrintLn( "*** Generating gib " + model + " from tag " + tag );

	if ( shatter && !force_from_torso )
	{
		tag_pos = self.origin;
		tag_angles = (0, 0, 1);
	}
	else
	{
		tag_pos = self GetTagOrigin( tag );
		tag_angles = self GetTagAngles( tag );
	}

	CreateDynEntAndLaunch( 0, model, tag_pos, tag_angles, tag_pos, self freezegun_get_gibforce( tag, force_from_torso, shatter ), freezegun_get_gibtrailfx( shatter ), 1 );

	self freezegun_do_gib_fx( tag, shatter );
}

function freezegun_gib_override( type, locations )
{
	if ( "freeze" != type && "up" != type )
	{
		if ( IsDefined( self.freezegun_damage_fx_handles ) )
		{
			for ( i = 0; i < locations.size; i++ )
			{
				switch( locations[i] )
				{
					case 0: // level._ZOMBIE_GIB_PIECE_INDEX_ALL
						players = getlocalplayers();
						for ( i = 0; i < players.size; i++ )
						{
							self freezegun_end_all_extremity_damage_fx( i );
						}
						break;

					case 1: // level._ZOMBIE_GIB_PIECE_INDEX_RIGHT_ARM
						freezegun_end_extremity_damage_fx_for_all_localclients( "right_arm" );
						break;

					case 2: // level._ZOMBIE_GIB_PIECE_INDEX_LEFT_ARM
						freezegun_end_extremity_damage_fx_for_all_localclients( "left_arm" );
						break;

					case 3: // level._ZOMBIE_GIB_PIECE_INDEX_RIGHT_LEG
						freezegun_end_extremity_damage_fx_for_all_localclients( "right_leg" );
						break;

					case 4: // level._ZOMBIE_GIB_PIECE_INDEX_LEFT_LEG
						freezegun_end_extremity_damage_fx_for_all_localclients( "left_leg" );
						break;

					// our guts torso is missing left arm, so we need to cancel fx on it for the guts case as well
					case 6: // level._ZOMBIE_GIB_PIECE_INDEX_GUTS
						freezegun_end_extremity_damage_fx_for_all_localclients( "left_arm" );
						break;
				} 
			}
		}

		return false;
	}

	upgraded = false;
	for ( i = 0; i < locations.size; i++ )
	{
		switch( locations[i] )
		{
			case 7:
				upgraded = true;
				break;
		}
	}

	shatter = false;
	explosion_effect = freezegun_get_crumple_effect( upgraded );
	alias = "wpn_freezegun_collapse_zombie";
	if ( "up" == type )
	{
		shatter = true;
		explosion_effect = freezegun_get_shatter_effect( upgraded );
		alias = "wpn_freezegun_shatter_zombie";
	}

	// kill the eye glow and damage fx and play the right explosion effect for each player
	players = getlocalplayers();
	for ( i = 0; i < players.size; i++ )
	{
		self zm::deleteZombieEyes( i );
		self freezegun_end_all_extremity_damage_fx( i );
		self freezegun_end_all_torso_damage_fx( i );
		PlayFX( i, explosion_effect, self.origin );
		PlaySound( 0, alias, self.origin );
	}

	for ( i = 0; i < locations.size; i++ )
	{
		switch( locations[i] )
		{
			case 0: // level._ZOMBIE_GIB_PIECE_INDEX_ALL
				if ( !self zm::has_gibbed_piece( level._ZOMBIE_GIB_PIECE_INDEX_RIGHT_ARM ) &&
						IsDefined( level._gibbing_actor_models[self._gib_def].gibSpawn1 ) && IsDefined( level._gibbing_actor_models[self._gib_def].gibSpawnTag1 ) )
				{
					self thread freezegun_do_gib( level._gibbing_actor_models[self._gib_def].gibSpawn1, level._gibbing_actor_models[self._gib_def].gibSpawnTag1, true, shatter );
				}
				if ( !self zm::has_gibbed_piece( level._ZOMBIE_GIB_PIECE_INDEX_LEFT_ARM ) &&
						IsDefined( level._gibbing_actor_models[self._gib_def].gibSpawn2 ) && IsDefined( level._gibbing_actor_models[self._gib_def].gibSpawnTag2 ) )
				{
					self thread freezegun_do_gib( level._gibbing_actor_models[self._gib_def].gibSpawn2, level._gibbing_actor_models[self._gib_def].gibSpawnTag2, true, shatter );
				}
				if ( !self zm::has_gibbed_piece( level._ZOMBIE_GIB_PIECE_INDEX_RIGHT_LEG ) &&
						IsDefined( level._gibbing_actor_models[self._gib_def].gibSpawn3 ) && IsDefined( level._gibbing_actor_models[self._gib_def].gibSpawnTag3 ) )
				{
					self thread freezegun_do_gib( level._gibbing_actor_models[self._gib_def].gibSpawn3, level._gibbing_actor_models[self._gib_def].gibSpawnTag3, false, shatter );
				}
				if ( !self zm::has_gibbed_piece( level._ZOMBIE_GIB_PIECE_INDEX_LEFT_LEG ) &&
						IsDefined( level._gibbing_actor_models[self._gib_def].gibSpawn4 ) && IsDefined( level._gibbing_actor_models[self._gib_def].gibSpawnTag4 ) )
				{
					self thread freezegun_do_gib( level._gibbing_actor_models[self._gib_def].gibSpawn4, level._gibbing_actor_models[self._gib_def].gibSpawnTag4, false, shatter );
				}

				self thread freezegun_do_gib_fx( "J_SpineLower", shatter ); //guts

				self zm::mark_piece_gibbed( level._ZOMBIE_GIB_PIECE_INDEX_RIGHT_ARM );
				self zm::mark_piece_gibbed( level._ZOMBIE_GIB_PIECE_INDEX_LEFT_ARM );
				self zm::mark_piece_gibbed( level._ZOMBIE_GIB_PIECE_INDEX_RIGHT_LEG );
				self zm::mark_piece_gibbed( level._ZOMBIE_GIB_PIECE_INDEX_LEFT_LEG );
				self zm::mark_piece_gibbed( level._ZOMBIE_GIB_PIECE_INDEX_HEAD );
				break;
		} 
	}

	self.gibbed = true;
	return true;
}

function freezegun_do_shatter_fx( localClientNum, oldVal, newVal, bNewEnt, bInitialSnap, fieldName )
{
	players = GetLocalPlayers();
	for ( i = 0; i < players.size; i++ )
	{
		if ( newVal == 1 )
		{
			self thread freezegun_play_all_shatter_damage_fx( i );
		}
		else
		{
			self thread freezegun_end_all_shatter_damage_fx( i );
		}
	}
}

function freezegun_play_all_shatter_damage_fx( localclientnum )
{
	if ( !IsDefined( self.freezegun_shatter_fx ) )
	{
		self.freezegun_shatter_fx = [];
	}

	if ( IsDefined( self.freezegun_shatter_fx[localclientnum] ) )
	{
		return;
	}

	self.freezegun_shatter_fx[localclientnum] = PlayFXOnTag( localclientnum, level._effect[ "freezegun_shatter" ], self, "J_SpineLower" );
	PlaySound( 0, "wpn_freezegun_shatter_zombie", self.origin );	

}

function freezegun_end_all_shatter_damage_fx( localclientnum )
{
	DeleteFX( localclientnum, self.freezegun_shatter_fx[localclientnum], true );
}

function freezegun_do_crumple_fx( localClientNum, oldVal, newVal, bNewEnt, bInitialSnap, fieldName )
{
	players = GetLocalPlayers();
	for ( i = 0; i < players.size; i++ )
	{
		if ( newVal == 1 )
		{
			self thread freezegun_play_all_crumple_damage_fx( i );
			self thread freezegun_end_all_extremity_damage_fx( i );
			self thread freezegun_end_all_torso_damage_fx( i );
		}
		else
		{
			self thread freezegun_end_all_crumple_damage_fx( i );
		}
	}
}

function freezegun_play_all_crumple_damage_fx( localclientnum )
{
	if ( !IsDefined( self.freezegun_crumple_fx ) )
	{
		self.freezegun_crumple_fx = [];
	}

	if ( IsDefined( self.freezegun_crumple_fx[localclientnum] ) )
	{
		return;
	}

	self.freezegun_crumple_fx[localclientnum] = PlayFXOnTag( localclientnum, level._effect[ "freezegun_crumple" ], self, "J_SpineLower" );
	PlaySound( 0, "wpn_freezegun_collapse_zombie", self.origin );
	wait(3);
	self.freezegun_crumple_fx[localclientnum] = PlayFXOnTag( localclientnum, level._effect[ "freezegun_shatter" ], self, "J_SpineLower" );
	PlaySound( 0, "wpn_freezegun_shatter_zombie", self.origin );

}

function freezegun_end_all_crumple_damage_fx( localclientnum )
{
	DeleteFX( localclientnum, self.freezegun_crumple_fx[localclientnum], true );
}