//
//BO4 STYLE CARPENTER v1.0: REPAIRS SHIELD ON GRAB
//CREATED BY FROST ICEFORGE
//ADDITIONAL CREDIT TO MADGAZ FOR CRUSADER ALE SCRIPTS WHICH I MODIFIED
//
#using scripts\zm\_zm;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_powerup_carpenter;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
//#using scripts\zm\_zm_weap_riotshield; 
#using scripts\shared\laststand_shared;
#using scripts\shared\clientfield_shared;
#using scripts\zm\_zm_equipment;
#insert scripts\shared\shared.gsh;

function __init__() {}

#define SHIELD_CODENAME "zod_riotshield" //Edit if your map uses a custom shield
#define SHIELD_UPGRADE_CODENAME "zod_riotshield_upgraded" //Edit if your custom shield has an upgrade

//BO4 Carpenter
function carpenter_upgrade()
{
	shield_name = get_riot_shield();
	while(isDefined(shield_name))
	{
		level waittill( "carpenter_started" );	
		foreach(player in GetPlayers())
		{
			primary_weapons = player getWeaponsList( 1 ); 
			foreach ( weap in primary_weapons )
			{
				if( weap.name == shield_name )
				{
					player /*riotshield::*/player_damage_shield( -1500 );
					player giveMaxAmmo( shield_name ); 
				}
				else if( weap.name == shield_name + "_upgraded" )
				{
					player /*riotshield::*/player_damage_shield( -1500 );
					player giveMaxAmmo( shield_name + "_upgraded" );
				} 
			}
		}
		
	}
}

function player_damage_shield( iDamage, bHeld, fromCode = false, smod = "MOD_UNKNOWN" )
{
	damageMax = level.weaponRiotshield.weaponstarthitpoints; 
	if ( IsDefined(self.weaponRiotshield) )
		damageMax = self.weaponRiotshield.weaponstarthitpoints; 
	shieldHealth = damageMax; 
	shieldDamage = iDamage; 
	rumbled = false; 
	if ( fromCode )
		shieldDamage = 0; 
	shieldHealth = self DamageRiotShield(shieldDamage); 

	if( shieldHealth <= 0 )
	{
		if( !rumbled )
		{
			self PlayRumbleOnEntity( "damage_heavy" );
			Earthquake( 1.0, 0.75, self.origin, 100 );
		}
		self thread player_take_riotshield();
	}
	else
	{
		if( !rumbled )
		{
			self PlayRumbleOnEntity( "damage_light" );
			Earthquake( 0.5, 0.5, self.origin, 100 );
		}
		self PlaySound( "fly_riotshield_zm_impact_zombies" );//sound for zombie attacks hitting the shield while held
	}
	self UpdateRiotShieldModel();
	self clientfield::set_player_uimodel( "zmInventory.shield_health", shieldHealth / damageMax );

}

function player_take_riotshield()
{
//iprintlnbold( "riot shield destroyed" );
	self notify( "destroy_riotshield" );

	// is the shield currently being wielded?
	current = self getCurrentWeapon();
	if ( current.isriotshield )
	{
		if ( !( self laststand::player_is_in_laststand() ) )
		{
			new_primary = level.weaponNone;
			primaryWeapons = self GetWeaponsListPrimaries();
			for ( i = 0; i < primaryWeapons.size; i++ )
			{
				if ( !primaryWeapons[i].isriotshield )
				{
					new_primary = primaryWeapons[i];
					break;
				}
			}
			
			if (new_primary == level.weaponNone )
			{
				self zm_weapons::give_fallback_weapon();
				self SwitchToWeaponImmediate();
				self PlaySound( "wpn_riotshield_zm_destroy" );//when zombies destroy the shield while you are holding it
				// don't wait for "weapon_change", as a weird timing issue prevents it from being received in only this case (no primary weapon)
			}
			else
			{
				self SwitchToWeaponImmediate();
				self PlaySound( "wpn_riotshield_zm_destroy" );//when zombies destroy the shield while you are holding it
				self waittill ( "weapon_change" );
			}
		}
	}

	self playsound( "zmb_rocketshield_break" );

	if ( IsDefined(self.weaponRiotshield) )
		self zm_equipment::take(self.weaponRiotshield);
	else
		self zm_equipment::take(level.weaponRiotshield);

	self.hasRiotShield = false;
	self.hasRiotShieldEquipped = false;
}

function UpdateRiotShieldModel()
{
	WAIT_SERVER_FRAME; 
	self.hasRiotShield = false;
	self.weaponRiotshield = level.weaponNone; 
	foreach ( weapon in self GetWeaponsList( true ) )
	{
		if ( weapon.isriotshield )  
		{
			self.hasRiotShield = true;
			self.weaponRiotshield = weapon;
		}
	}
	current = self getCurrentWeapon();
	self.hasRiotShieldEquipped = (current.isriotshield);
	if ( self.hasRiotShield )
	{
		self clientfield::set_player_uimodel( "hudItems.showDpadDown", 1 );
		if ( self.hasRiotShieldEquipped )
		{
			self zm_weapons::clear_stowed_weapon();
		}
		else
		{
			self zm_weapons::set_stowed_weapon( self.weaponRiotshield );
		}
	}
	else
	{
		self clientfield::set_player_uimodel( "hudItems.showDpadDown", 0 );
		self SetStowedWeapon( level.weaponNone );
	}
	self RefreshShieldAttachment();
	
}

function get_riot_shield () {
	keys = GetArrayKeys( level.zombie_weapons );
	foreach(weapon in keys) {
		//iPrintLn(weapon.name);
		if (weapon.isRiotshield) {
			//iPrintLn(weapon.name);
			return(weapon.name);
		}
	}
	return undefined;
}