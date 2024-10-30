#using scripts\codescripts\struct;

#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#using scripts\shared\ai\zombie_death;

#using scripts\zm\_zm_blockers;
#using scripts\zm\_zm_pers_upgrades;
#using scripts\zm\_zm_pers_upgrades_functions;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;

#using scripts\shared\array_shared;

#insert scripts\zm\_zm_powerups.gsh;
#insert scripts\zm\_zm_utility.gsh;


REGISTER_SYSTEM( "zm_powerup_weapon", &__init__, undefined )

//-----------------------------------------------------------------------------------
// setup
//-----------------------------------------------------------------------------------
function __init__()
{
	//weapon_lookup_table(); 
	
	zm_powerups::register_powerup( "random_weapon", &grab_weapon, &setup_weapon );
	if( ToLower( GetDvarString( "g_gametype" ) ) != "zcleansed" )
	{
		zm_powerups::add_zombie_powerup( "random_weapon", "tag_origin", "", &zm_powerups::func_should_never_drop, POWERUP_ONLY_AFFECTS_GRABBER, !POWERUP_ANY_TEAM, !POWERUP_ZOMBIE_GRABBABLE );
		zm_powerups::powerup_set_statless_powerup("random_weapon");
		zm_powerups::powerup_set_player_specific("random_weapon", 1);
	}

}

/*function weapon_lookup_table()
{
	level.weapon_lookup_table = []; 
	level.weapon_lookup_table[level.weapon_lookup_table.size] = "smg_standard"; // Kuda
	level.weapon_lookup_table[level.weapon_lookup_table.size] = "ar_standard"; // KN44
	level.weapon_lookup_table[level.weapon_lookup_table.size] = "shotgun_semiauto"; // Brecci
}*/

function setup_weapon( player )
{
	//level.weapon_lookup_table = array::randomize( level.weapon_lookup_table ); 
	keys = array::randomize( GetArrayKeys( level.zombie_weapons ) );
	if (IsDefined(level.CustomRandomWeaponWeights))
	{
		keys = player [[level.CustomRandomWeaponWeights]](keys); 
	}
	weapon_to_give = keys[0];
	//pap_triggers = zm_pap_util::get_triggers();
	for ( i = 0; i < keys.size; i++ )
	{
		if ( zm_weapons::get_is_in_box( keys[i] ) )
		//if ( zm_magicbox::treasure_chest_CanPlayerReceiveWeapon( player, keys[i], pap_triggers ) )
		{
			weapon_to_give = keys[i];
			break;
		}
	}

	//w_weapon = zm_magicbox::treasure_chest_ChooseWeightedRandomWeapon();
	if(zm_weapons::can_upgrade_weapon(weapon_to_give) && !RandomInt(4))
		weapon_to_give = zm_weapons::get_upgrade_weapon(weapon_to_give);
	
	//weapon_to_give = level.weapon_lookup_table[0]; 
	world_gun = GetWeaponWorldModel(weapon_to_give);
	//self SetModel( world_gun ); 
	self useweaponmodel( weapon_to_give, world_gun );
	self.weapon_to_give = weapon_to_give; 
}

/*function func_should_drop_weapon()
{
	return true;
}*/

function grab_weapon( player )
{
	weaps = player getweaponslistprimaries();
	gun = self.weapon_to_give;
	
	if( player does_player_have(gun) )
		return; 
	
	/*else if( weaps.size == 2 && !player HasPerk("specialty_additionalprimaryweapon") )
	{
		player TakeWeapon( player GetCurrentWeapon() );  
		player GiveWeapon( gun ); 
		player SwitchToWeapon( gun ); 
	}
	else if( weaps.size >= 3 && player HasPerk("specialty_additionalprimaryweapon") )
	{
		player TakeWeapon( player GetCurrentWeapon() );  
		player GiveWeapon( gun ); 
		player SwitchToWeapon( gun ); 
	}
	else
	{*/
		player zm_weapons::weapon_give( gun, zm_weapons::is_weapon_upgraded(gun) );
		/*player SwitchToWeapon( gun );		
	}*/
}

function does_player_have( weapon )
{
	weaps = self getweaponslistprimaries();
	foreach( weap in weaps )
	{
		if( weap == weapon )
		{
			self GiveMaxAmmo( weap ); 
			return true; 
		}
	}
	return false; 
}