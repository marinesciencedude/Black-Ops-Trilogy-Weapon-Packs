#using scripts\zm\_zm_weapons;
#using scripts\codescripts\struct;

#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;

#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_powerup_random_weapon;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;
#insert scripts\zm\_zm_mutators.gsh;

#namespace zm_mod;

function init()
{
	LuiLoad( "ui.uieditor.menus.hud.hud_zm_mapname" );
}

function main () {
	self waittill("choices_applied");
	applyChoices();
}

function applyChoices() {
	
	/*if(GetDvarInt("mutator_raygunmkii") == MUTATOR_ONOFF_ON)
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
	}*/
	
	/*switch(GetDvarInt("mutator_scopeads"))
	{
		case 1:
		{
			zm_weapons::include_weapon( "t5_dragunov_overlay", true, 1750, 500 );
			zm_weapons::include_upgraded_weapon( "t5_dragunov_overlay", "t5_dragunov_up_overlay", false, 1750, 500 );
			RemoveZombieBoxWeapon(GetWeapon("t5_dragunov"));
			
			zm_weapons::include_weapon( "t5_g11_overlay", true, 1700, 500 );
			zm_weapons::include_upgraded_weapon( "t5_g11_overlay", "t5_g11_up_overlay", false, 1700, 500 );
			RemoveZombieBoxWeapon(GetWeapon("t5_g11"));
			
			if(GetDvarInt("mutator_wa2000") == MUTATOR_OFFON_ON)
			{
				zm_weapons::include_weapon( "t5_wa2000_overlay", true, 1600, 500 );
				zm_weapons::include_upgraded_weapon( "t5_wa2000_overlay", "t5_wa2000_up_overlay", false, 1600, 500 );
				RemoveZombieBoxWeapon(GetWeapon("t5_wa2000"));
				weapon = GetWeapon("t5_wa2000_overlay");
				AddZombieBoxWeapon(weapon, weapon.worldmodel, false);
			}
			
			if(GetDvarInt("mutator_psg1") == MUTATOR_OFFON_ON)
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
			
			if(GetDvarInt("mutator_wa2000") == MUTATOR_OFFON_ON)
			{
				zm_weapons::include_weapon( "t5_wa2000_switch", true, 1600, 500 );
				zm_weapons::include_upgraded_weapon( "t5_wa2000_switch", "t5_wa2000_up_switch", false, 1600, 500 );
				RemoveZombieBoxWeapon(GetWeapon("t5_wa2000"));
				weapon = GetWeapon("t5_wa2000_switch");
				AddZombieBoxWeapon(weapon, weapon.worldmodel, false);
			}
			
			if(GetDvarInt("mutator_psg1") == MUTATOR_OFFON_ON)
			{
				zm_weapons::include_weapon( "t5_psg1_switch", true, 2000, 500);
				zm_weapons::include_upgraded_weapon( "t5_psg1_switch", "t5_psg1_up_switch", false, 2000, 500);
			}
			
			break;
		}
	}*/
	
	if(GetDvarInt("mutator_ray_gun") == 2)
	{
		zm_weapons::include_weapon( "ray_gun", true, 10000, 500 );
		zm_weapons::include_upgraded_weapon( "ray_gun", "ray_gun_upgraded", false, 10000, 500 );
		RemoveZombieBoxWeapon(GetWeapon("t4_ray_gun"));
	}
	
	if(GetDvarInt("mutator_monkey_bomb") == MUTATOR_ONOFF_OFF)
		RemoveZombieBoxWeapon(GetWeapon("cymbal_monkey"));
}

function tempCallback(localClientNum, oldVal, newVal, bNewEnt, bInitialSnap, fieldName, bWasTimeJump) {
    
}

