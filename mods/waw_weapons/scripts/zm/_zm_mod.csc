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
	if(GetDvarInt("mutator_hud") != 2)
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
	
	/*if(GetDvarInt("mutator_factory_classic") == 2 && GetDvarString("mapname") == "zm_factory_classic")
	{
		RemoveZombieBoxWeapon(GetWeapon("zombie_ray_gun")); AddZombieBoxWeapon(GetWeapon("t4_ray_gun"), "wm_raygun", false);
		RemoveZombieBoxWeapon(GetWeapon("zombie_sw_357")); AddZombieBoxWeapon(GetWeapon("t4_357"), "wm_357", false);
		RemoveZombieBoxWeapon(GetWeapon("zombie_m1garand")); AddZombieBoxWeapon(GetWeapon("t4_m1"), "wm_m1", false);
		RemoveZombieBoxWeapon(GetWeapon("zombie_kar98k")); AddZombieBoxWeapon(GetWeapon("t4_kar98k"), "wm_kar98k", false);
		RemoveZombieBoxWeapon(GetWeapon("zombie_gewehr43")); AddZombieBoxWeapon(GetWeapon("t4_g43"), "wm_g43", false);
		RemoveZombieBoxWeapon(GetWeapon("zombie_m1carbine")); AddZombieBoxWeapon(GetWeapon("t4_carbine"), "wm_carbine", false);
		RemoveZombieBoxWeapon(GetWeapon("zombie_stg44")); AddZombieBoxWeapon(GetWeapon("t4_mp44"), "worldmodel_stg44", false);
		RemoveZombieBoxWeapon(GetWeapon("zombie_fg42")); AddZombieBoxWeapon(GetWeapon("t4_fg42"), "worldmodel_fg42", false);
		RemoveZombieBoxWeapon(GetWeapon("zombie_bar")); AddZombieBoxWeapon(GetWeapon("t4_bar"), "wm_bar_bipod", false);
		RemoveZombieBoxWeapon(GetWeapon("zombie_mg42")); AddZombieBoxWeapon(GetWeapon("t4_mg42"), "wm_mg42", false);
		RemoveZombieBoxWeapon(GetWeapon("zombie_30cal")); AddZombieBoxWeapon(GetWeapon("t4_m1919"), "wm_m1919", false);
		RemoveZombieBoxWeapon(GetWeapon("zombie_thompson")); AddZombieBoxWeapon(GetWeapon("t4_thompson"), "wm_thompson", false);
		RemoveZombieBoxWeapon(GetWeapon("zombie_mp40")); AddZombieBoxWeapon(GetWeapon("t4_mp40"), "wm_mp40", false);
		RemoveZombieBoxWeapon(GetWeapon("zombie_ppsh")); AddZombieBoxWeapon(GetWeapon("t4_ppsh"), "wm_ppsh_drummag", false);
		RemoveZombieBoxWeapon(GetWeapon("zombie_type100_smg")); AddZombieBoxWeapon(GetWeapon("t4_type100"), "wm_type100", false);
		RemoveZombieBoxWeapon(GetWeapon("zombie_doublebarrel")); AddZombieBoxWeapon(GetWeapon("t4_db"), "wm_db", false);
		RemoveZombieBoxWeapon(GetWeapon("zombie_shotgun")); AddZombieBoxWeapon(GetWeapon("t4_m1897"), "wm_m1987", false);
		RemoveZombieBoxWeapon(GetWeapon("m1garand_gl_zombie")); AddZombieBoxWeapon(GetWeapon("t4_m1garand_rg"), "wm_t4_m1garand", false);
		RemoveZombieBoxWeapon(GetWeapon("ptrs41_zombie")); AddZombieBoxWeapon(GetWeapon("t4_ptrs"), "wm_ptrs", false);
		RemoveZombieBoxWeapon(GetWeapon("m2_flamethrower_zombie")); AddZombieBoxWeapon(GetWeapon("m2_flamethrower"), "weapon_usa_flamethrower", false);
		RemoveZombieBoxWeapon(GetWeapon("panzershreck_zombie")); AddZombieBoxWeapon(GetWeapon("t4_panzerschreck"), "wm_t4_panzerschreck", false);
		
		//zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_factory_classic_mod.csv", 1);
	}*/
	
	if((GetDvarString("mapname") != "zm_stalingrad" && GetDvarInt("mutator_wallbuys_gorod_krovi") != 2) && GetDvarInt("mutator_dp27") == MUTATOR_OFFON_ON)
	{
		zm_weapons::include_weapon( "t4_dp28", true, 2400, 0 );
		zm_weapons::include_upgraded_weapon( "t4_dp28", "t4_dp28_up", false, 2400, 0 );
	}
	
	if(GetDvarInt("mutator_svt40") == MUTATOR_OFFON_ON)
	{
		zm_weapons::include_weapon( "t4_svt", true, 600, 0 );
		zm_weapons::include_upgraded_weapon( "t4_svt", "t4_svt_up", false );	}
	
	if(GetDvarInt("mutator_type99") == MUTATOR_OFFON_ON)
	{
		zm_weapons::include_weapon( "t4_type99", true, 2700, 0 );
		zm_weapons::include_upgraded_weapon( "t4_type99", "t4_type99_up", false );
	}
	
	if(GetDvarInt("mutator_ray_gun") == 2)
	{
														 // auto-calculate ammo cost
		zm_weapons::include_weapon( "ray_gun", true, 10000, 0 );
		zm_weapons::include_upgraded_weapon( "ray_gun", "ray_gun_upgraded", false, 10000, 0 );
		RemoveZombieBoxWeapon(GetWeapon("t4_ray_gun"));
	}
	
	if(GetDvarInt("mutator_monkey_bomb") == MUTATOR_ONOFF_OFF)
		RemoveZombieBoxWeapon(GetWeapon("cymbal_monkey"));
	
	if(level.pack_a_punch_camo_index != 142 && GetDvarInt("mutator_camo_ingame_cycle") == 2)
	{
		zm_weapons::include_upgraded_weapon( "t4_ray_gun", "t4_ray_gun_camo_up", false, 10000, 0 );
		ArrayRemoveIndex(level.zombie_weapons_upgraded, GetWeapon("t4_ray_gun_up"));
	}
	
	if(GetDvarString("mapname") == "zm_giant")
		zm_weapons::include_weapon( "tesla_gun", true, 10000, 0 );
}

function tempCallback(localClientNum, oldVal, newVal, bNewEnt, bInitialSnap, fieldName, bWasTimeJump) {
    
}

