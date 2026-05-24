#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_weapons;

#namespace namespace_ce121f88;

/*
	Name: __init__sytem__
	Namespace: namespace_ce121f88
	Checksum: 0x33D344D0
	Offset: 0x290
	Size: 0x33
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__sytem__()
{
	system::register("zm_alt_weapons", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_ce121f88
	Checksum: 0xE4A5FC6C
	Offset: 0x2D0
	Size: 0x83
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(GetDvarString("mapname") == "zm_leviathan")
	{
		clientfield::register("toplayer", "dpadLeftAmmoCount", 1, 8, "int");
		clientfield::register("toplayer", "dpadLeftWeapon", 1, 2, "int");
		callback::on_spawned(&onPlayerSpawned);
	}
}

/*
	Name: onPlayerSpawned
	Namespace: namespace_ce121f88
	Checksum: 0x3D78A5B7
	Offset: 0x360
	Size: 0x33
	Parameters: 0
	Flags: None
*/
function onPlayerSpawned()
{
	self thread function_8509f4d6();
	self thread function_34a91725();
}

/*
	Name: function_8509f4d6
	Namespace: namespace_ce121f88
	Checksum: 0xB4965276
	Offset: 0x3A0
	Size: 0x20F
	Parameters: 0
	Flags: None
*/
function function_8509f4d6()
{
	self endon("disconnect");
	self endon("death");
	while(1)
	{
		if(self laststand::player_is_in_laststand() || self.sessionstate == "spectator")
		{
			self function_a76f3174();
			wait(0.25);
			continue;
		}
		currentWeapon = self GetCurrentWeapon();
		if(function_c983c3ba(currentWeapon))
		{
			self function_a3dfcd(currentWeapon);
		}
		else if(currentWeapon.altweapon != level.weaponNone)
		{
			self function_a3dfcd(currentWeapon.altweapon);
		}
		else
		{
			weapons = self GetWeaponsListPrimaries();
			var_23b51226 = 0;
			foreach(weapon in weapons)
			{
				if(weapon.altweapon != level.weaponNone)
				{
					self function_a3dfcd(weapon.altweapon);
					var_23b51226 = 1;
					break;
				}
			}
			if(!var_23b51226)
			{
				self function_a76f3174();
			}
		}
		wait(0.1);
	}
}

/*
	Name: function_a76f3174
	Namespace: namespace_ce121f88
	Checksum: 0x68177608
	Offset: 0x5B8
	Size: 0x63
	Parameters: 0
	Flags: None
*/
function function_a76f3174()
{
	self clientfield::set_to_player("dpadLeftWeapon", 0);
	self clientfield::set_to_player("dpadLeftAmmoCount", 0);
	self function_a3dfcd(level.weaponNone);
}

/*
	Name: function_a3dfcd
	Namespace: namespace_ce121f88
	Checksum: 0x5B99D8F3
	Offset: 0x628
	Size: 0x1A3
	Parameters: 1
	Flags: None
*/
function function_a3dfcd(weapon)
{
	if(weapon.rootweapon == GetWeapon("microwavegun") || weapon.rootweapon == GetWeapon("microwavegun_upgraded"))
	{
		self clientfield::set_to_player("dpadLeftWeapon", 1);
	}
	else if(weapon.rootweapon == GetWeapon("shotgun_masterkey") || weapon.rootweapon == GetWeapon("t5_aug_shotty") || weapon.rootweapon == GetWeapon("t5_aug_shotty") || weapon.rootweapon == GetWeapon("t5_enfield_shotty"))
	{
		self clientfield::set_to_player("dpadLeftWeapon", 2);
	}
	else if(weapon.rootweapon == GetWeapon("m203") || weapon.rootweapon == GetWeapon("t5_m16a1_launcher"))
	{
		self clientfield::set_to_player("dpadLeftWeapon", 3);
	}
	else
	{
		self clientfield::set_to_player("dpadLeftWeapon", 0);
		return;
	}
	var_2fab9644 = self GetWeaponAmmoClip(weapon) + self GetWeaponAmmoStock(weapon);
	self clientfield::set_to_player("dpadLeftAmmoCount", var_2fab9644);
}

/*
	Name: function_c983c3ba
	Namespace: namespace_ce121f88
	Checksum: 0xAE3F7F39
	Offset: 0x7D8
	Size: 0xAB
	Parameters: 1
	Flags: None
*/
function function_c983c3ba(weapon)
{
	return weapon.rootweapon == GetWeapon("microwavegun") || weapon.rootweapon == GetWeapon("microwavegun_upgraded") || weapon.rootweapon == GetWeapon("shotgun_masterkey") || weapon.rootweapon == GetWeapon("m203") || weapon.rootweapon == GetWeapon("t5_m16a1_launcher") || weapon.rootweapon == GetWeapon("t5_aug_shotty")  || weapon.rootweapon == GetWeapon("t5_enfield_shotty");
}

/*
	Name: function_34a91725
	Namespace: namespace_ce121f88
	Checksum: 0x1CCA1BD6
	Offset: 0x890
	Size: 0x13F
	Parameters: 0
	Flags: None
*/
function function_34a91725()
{
	self endon("disconnect");
	self endon("death");
	while(1)
	{
		self waittill("weapon_give", weapon);
		if(weapon.rootweapon == GetWeapon("microwavegundw") || weapon.rootweapon == GetWeapon("microwavegundw_upgraded"))
		{
			self zm_equipment::show_hint_text(&"LEVIATHAN_EQUIP_WAVEGUN");
		}
		else if(weapon.rootweapon == GetWeapon("ar_aug_upgraded"))
		{
			self zm_equipment::show_hint_text(&"LEVIATHAN_EQUIP_MASTERKEY");
		}
		else if(weapon.rootweapon == GetWeapon("ar_m16_upgraded"))
		{
			self zm_equipment::show_hint_text(&"LEVIATHAN_EQUIP_M203");
		}
	}
}

