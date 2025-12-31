#using scripts\zm\_zm_weapons;
#using scripts\codescripts\struct;

#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;

#using scripts\zm\_zm_powerups;
//#using scripts\zm\_zm_powerup_random_weapon;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;
#insert scripts\zm\_zm_mutators.gsh;

#namespace zm_mod;

function init()
{
	if(GetDvarInt("mutator_hud") != 2)
		LuiLoad( "ui.uieditor.menus.hud.hud_zm_mapname" );
}

function main () {
	self waittill("choices_applied");
	applyChoices();
}

function applyChoices() {
	
	/*case 2:
		{
			zm_weapons::include_weapon( "t5_ak47", true, 1300, 500);
			zm_weapons::include_upgraded_weapon( "t5_ak47", "t5_ak47_up", false, 1300, 500);
			break;
		}
	case 3:
		{
			zm_weapons::include_weapon( "t5_ak47", true, 1300, 500);
			zm_weapons::include_upgraded_weapon( "t5_ak47", "t5_ak47_up_alt", false, 1300, 500);
			break;
		}*/
	/*case MUTATOR_OFFON_ON:
		{
			if(GetDvarInt("mutator_bocw_ak47") == 2)
			{
				zm_weapons::include_weapon( "t9_ak47", true, 1300, 500);
				zm_weapons::include_upgraded_weapon( "t9_ak47", "t9_ak47_up_alt", false, 1300, 500);
			}
			else
			{
				zm_weapons::include_weapon( "t5_ak47", true, 1300, 500);
				zm_weapons::include_upgraded_weapon( "t5_ak47", "t5_ak47_up_alt", false, 1300, 500);
			}
			break;
		}
	}
	
	switch(GetGametypeSetting(mutator_uzi))
	{
	case 2:
		{
			zm_weapons::include_weapon( "t5_uzi", true, 1500, 500);
			zm_weapons::include_upgraded_weapon( "t5_uzi", "t5_uzi_up", false, 1500, 500);
			break;
		}
	case 3:
		{
			zm_weapons::include_weapon( "t5_uzi_alt", true, 1500, 500);
			zm_weapons::include_upgraded_weapon( "t5_uzi_alt", "t5_uzi_up_alt", false, 1500, 500);
			break;
		}
	}/*
	
	if(GetGametypeSetting(mutator_raygunmkii) == BOOLMUTATOR_ONOFF_ON)
	{
		if(isdefined(GetWeapon("raygun_mark2").worldmodel)) //stock maps
		{
			zm_weapons::include_weapon( "raygun_mark2", true, 10000, 0);
			zm_weapons::include_upgraded_weapon( "raygun_mark2", "raygun_mark2_upgraded", false, 10000, 0);
		}
		else
		{
			zm_weapons::include_weapon( "raygun_mark_ii", true, 10000, 0);
			zm_weapons::include_upgraded_weapon( "raygun_mark_ii", "raygun_mark_ii_upgraded", false, 10000, 0);
		}
	}
	
	if(GetGametypeSetting(mutator_ballistic_knife) == BOOLMUTATOR_ONOFF_OFF)
	{
		RemoveZombieBoxWeapon(GetWeapon("t9_ballistic_knife"));
	}
	
	/*switch(GetGametypeSetting(mutator_scopeads))
	{
		case 1:
		{
			zm_weapons::include_weapon( "t5_dragunov_overlay", true, 1750, 500 );
			zm_weapons::include_upgraded_weapon( "t5_dragunov_overlay", "t5_dragunov_up_overlay", false, 1750, 500 );
			RemoveZombieBoxWeapon(GetWeapon("t5_dragunov"));
			
			zm_weapons::include_weapon( "t5_g11_overlay", true, 1700, 500 );
			zm_weapons::include_upgraded_weapon( "t5_g11_overlay", "t5_g11_up_overlay", false, 1700, 500 );
			RemoveZombieBoxWeapon(GetWeapon("t5_g11"));
			
			if(GetGametypeSetting(mutator_wa2000) == BOOLMUTATOR_OFFON_ON)
			{
				zm_weapons::include_weapon( "t5_wa2000_overlay", true, 1600, 500 );
				zm_weapons::include_upgraded_weapon( "t5_wa2000_overlay", "t5_wa2000_up_overlay", false, 1600, 500 );
				RemoveZombieBoxWeapon(GetWeapon("t5_wa2000"));
				weapon = GetWeapon("t5_wa2000_overlay");
				AddZombieBoxWeapon(weapon, weapon.worldmodel, false);
			}
			
			if(GetGametypeSetting(mutator_psg1) == BOOLMUTATOR_OFFON_ON)
			{
				zm_weapons::include_weapon( "t5_psg1_overlay", true, 2000, 500 );
				zm_weapons::include_upgraded_weapon( "t5_psg1_overlay", "t5_psg1_up_overlay", false, 2000, 500 );
			}
			
			break;
		}
		case 3:
		{
			zm_weapons::include_weapon( "t5_dragunov_switch", true, 1750, 500 );
			zm_weapons::include_upgraded_weapon( "t5_dragunov_switch", "t5_dragunov_up_switch", false, 1750, 500 );
			RemoveZombieBoxWeapon(GetWeapon("t5_dragunov"));
			
			zm_weapons::include_weapon( "t5_g11_switch", true, 1700, 500 );
			zm_weapons::include_upgraded_weapon( "t5_g11_switch", "t5_g11_up_switch", false, 1700, 500 );
			RemoveZombieBoxWeapon(GetWeapon("t5_g11"));
			
			if(GetGametypeSetting(mutator_wa2000) == BOOLMUTATOR_OFFON_ON)
			{
				zm_weapons::include_weapon( "t5_wa2000_switch", true, 1600, 500 );
				zm_weapons::include_upgraded_weapon( "t5_wa2000_switch", "t5_wa2000_up_switch", false, 1600, 500 );
				RemoveZombieBoxWeapon(GetWeapon("t5_wa2000"));
				weapon = GetWeapon("t5_wa2000_switch");
				AddZombieBoxWeapon(weapon, weapon.worldmodel, false);
			}
			
			if(GetGametypeSetting(mutator_psg1) == BOOLMUTATOR_OFFON_ON)
			{
				zm_weapons::include_weapon( "t5_psg1_switch", true, 2000, 500);
				zm_weapons::include_upgraded_weapon( "t5_psg1_switch", "t5_psg1_up_switch", false, 2000, 500);
			}
			
			break;
		}
	}*/
	
	if(GetDvarString("mapname") == "zm_der_riese")
	{
		if(GetGametypeSetting(mutator_declassified_ppsh) == MUTATOR_OFFON_ON)
		{
			zm_weapons::include_weapon( "smg_ppsh", true, 5000, 500 );
			zm_weapons::include_upgraded_weapon( "smg_ppsh", "smg_ppsh_upgraded", false, 5000, 500 );
		}
		
		if(GetGametypeSetting(mutator_declassified_mg42) == MUTATOR_OFFON_ON)
		{
			zm_weapons::include_weapon( "s2_mg42", true, 3000, 500 );
			zm_weapons::include_upgraded_weapon( "s2_mg42", "s2_mg42_upgraded", false, 3000, 500 );
		}
	}
	
	/*if(GetDvarInt("mutator_ray_gun") == 2)
	{
														 // auto-calculate ammo cost
		zm_weapons::include_weapon( "ray_gun", true, 10000, 0 );
		zm_weapons::include_upgraded_weapon( "ray_gun", "ray_gun_upgraded", false, 10000, 0 );
		RemoveZombieBoxWeapon(GetWeapon("t4_ray_gun"));
	}*/
	
	/*if(level.pack_a_punch_camo_index == 141 && GetGametypeSetting(mutator_camo_ingame_cycle) != BOOLMUTATOR_OFFON_ON)
	{
		zm_weapons::include_upgraded_weapon( "t4_ray_gun", "t4_ray_gun_up", false, 10000, 0 );
		ArrayRemoveIndex(level.zombie_weapons_upgraded, GetWeapon("t4_ray_gun_camo_up"));
	}*/
	
	if(GetDvarString("mapname") == "zm_giant")
		zm_weapons::include_weapon( "tesla_gun", true, 10000, 0 );
	
	/*level.weaponzmthundergun = getweapon("t5_thundergun");
	level.weaponzmthundergunupgraded = getweapon("t5_thundergun_upgraded");*/
}

function tempCallback(localClientNum, oldVal, newVal, bNewEnt, bInitialSnap, fieldName, bWasTimeJump) {
    
}

