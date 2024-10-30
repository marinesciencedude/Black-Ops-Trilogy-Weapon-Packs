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
	
	switch(GetDvarInt("mutator_ak47"))
	{
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
	case MUTATOR_OFFON_ON:
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
	
	switch(GetDvarInt("mutator_uzi"))
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
	}
	
	if(GetDvarInt("mutator_raygunmkii") == MUTATOR_ONOFF_ON)
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
	
	if(GetDvarInt("mutator_skorpion") == MUTATOR_OFFON_ON)
	{
		zm_weapons::include_weapon( "t5_skorpion", true, 1100, 500);
		zm_weapons::include_upgraded_weapon( "t5_skorpion", "t5_skorpion_rdw_up", false, 1100, 500);
	}
	
	if(GetDvarInt("mutator_stoner63") == MUTATOR_OFFON_ON)
	{
		if(GetDvarInt("mutator_bocw_stoner63") == MUTATOR_OFFON_ON)
		{
			zm_weapons::include_weapon( "t9_stoner63", true, 2250, 500);
			zm_weapons::include_upgraded_weapon( "t9_stoner63", "t9_stoner63_up", false, 2250, 500);
		}
		else
		{
			zm_weapons::include_weapon( "t5_stoner63", true, 2250, 500);
			zm_weapons::include_upgraded_weapon( "t5_stoner63", "t5_stoner63_up", false, 2250, 500);
		}
	}
	
	if(GetDvarInt("mutator_bo3_weapons") == MUTATOR_OFFON_ON)
	{
		//VMP
		zm_weapons::include_weapon( "smg_versatile", true, 1300, 500);
		zm_weapons::include_upgraded_weapon( "smg_versatile", "smg_versatile_upgraded", false, 2250, 500);
		//Weevil
		zm_weapons::include_weapon( "smg_capacity", true, 5000, 500);
		zm_weapons::include_upgraded_weapon( "smg_capacity", "smg_capacity_upgraded", false, 5000, 500);
		//Pharo
		zm_weapons::include_weapon( "smg_burst", true, 700, 350);
		zm_weapons::include_upgraded_weapon( "smg_burst", "smg_burst_upgraded", false, 700, 500);
		//Man-O-War
		zm_weapons::include_weapon( "ar_damage", true, 5000, 500);
		zm_weapons::include_upgraded_weapon( "ar_damage", "ar_damage_upgraded", false, 5000, 500);
		//HVK-30
		zm_weapons::include_weapon( "ar_cqb", true, 1600, 500);
		zm_weapons::include_upgraded_weapon( "ar_cqb", "ar_cqb_upgraded", false, 1600, 500);
		//Sheiva
		zm_weapons::include_weapon( "ar_marksman", true, 500, 250);
		zm_weapons::include_upgraded_weapon( "ar_marksman", "ar_marksman_upgraded", false, 500, 250);
		//ICR-1
		zm_weapons::include_weapon( "ar_accurate", true, 1500, 500);
		zm_weapons::include_upgraded_weapon( "ar_accurate", "ar_accurate_upgraded", false, 1500, 500);
		//Argus
		zm_weapons::include_weapon( "shotgun_precision", true, 1100, 500);
		zm_weapons::include_upgraded_weapon( "shotgun_precision", "shotgun_precision_upgraded", false, 1100, 500);
		//205 Brecci
		zm_weapons::include_weapon( "shotgun_semiauto", true, 5000, 500);
		zm_weapons::include_upgraded_weapon( "shotgun_semiauto", "shotgun_semiauto_upgraded", false, 5000, 500);
		//Haymaker 12
		zm_weapons::include_weapon( "shotgun_fullauto", true, 5000, 500);
		zm_weapons::include_upgraded_weapon( "shotgun_fullauto", "shotgun_fullauto_upgraded", false, 5000, 500);
		//Dingo
		zm_weapons::include_weapon( "lmg_cqb", true, 5000, 500);
		zm_weapons::include_upgraded_weapon( "lmg_cqb", "lmg_cqb_upgraded", false, 5000, 500);
		//BRM
		zm_weapons::include_weapon( "lmg_light", true, 5000, 500);
		zm_weapons::include_upgraded_weapon( "lmg_light", "lmg_light_upgraded", false, 5000, 500);
		//48 Dredge
		zm_weapons::include_weapon( "lmg_heavy", true, 5000, 500);
		zm_weapons::include_upgraded_weapon( "lmg_heavy", "lmg_heavy_upgraded", false, 5000, 500);
		//Gorgon
		zm_weapons::include_weapon( "lmg_slowfire", true, 5000, 500);
		zm_weapons::include_upgraded_weapon( "lmg_slowfire", "lmg_slowfire_upgraded", false, 5000, 500);
		//Locus
		if(isdefined(level.zombie_weapons_upgraded[GetWeapon("sniper_fastbolt_upgraded")]))
		{
			zm_weapons::include_weapon( "sniper_fastbolt", true, 5000, 500);
			zm_weapons::include_upgraded_weapon( "sniper_fastbolt", "sniper_fastbolt_upgraded", false, 5000, 500);
		}
		//Drakon
		zm_weapons::include_weapon( "sniper_fastsemi", true, 5000, 500);
		zm_weapons::include_upgraded_weapon( "sniper_fastsemi", "sniper_fastsemi_upgraded", false, 5000, 500);
		//SVG-100
		zm_weapons::include_weapon( "sniper_powerbolt", true, 5000, 500);
		zm_weapons::include_upgraded_weapon( "sniper_powerbolt", "sniper_powerbolt_upgraded", false, 5000, 500);
		//XM-53
		zm_weapons::include_weapon( "launcher_standard", true, 10000, 500);
		zm_weapons::include_upgraded_weapon( "launcher_standard", "launcher_standard_upgraded", false, 10000, 500);
		//KN-44
		zm_weapons::include_weapon( "ar_standard", true, 1400, 500);
		zm_weapons::include_upgraded_weapon( "ar_standard", "ar_standard_upgraded", false, 1400, 500);
		//Vesper
		zm_weapons::include_weapon( "smg_fastfire", true, 1250, 500);
		zm_weapons::include_upgraded_weapon( "smg_fastfire", "smg_fastfire_upgraded", false, 1250, 500);
		//Kuda
		zm_weapons::include_weapon( "smg_standard", true, 1250, 500);
		zm_weapons::include_upgraded_weapon( "smg_standard", "smg_standard_upgraded", false, 1250, 500);
		//M8A7
		zm_weapons::include_weapon( "ar_longburst", true, 1500, 500);
		zm_weapons::include_upgraded_weapon( "ar_longburst", "ar_longburst_upgraded", false, 1500, 500);
		//L-CAR 9
		zm_weapons::include_weapon( "pistol_fullauto", true, 750, 375);
		zm_weapons::include_upgraded_weapon( "pistol_fullauto", "pistol_fullauto_upgraded", false, 750, 375);
		//FFAR
		zm_weapons::include_weapon( "ar_famas", true, 5000, 500);
		zm_weapons::include_upgraded_weapon( "ar_famas", "ar_famas_upgraded", false, 5000, 500);
		//KRM-262
		zm_weapons::include_weapon( "shotgun_pump", true, 750, 375);
		zm_weapons::include_upgraded_weapon( "shotgun_pump", "shotgun_pump_upgraded", false, 750, 375);
	}
	
	if(GetDvarInt("mutator_bo3_rk5") == MUTATOR_OFFON_ON)
	{
		zm_weapons::include_weapon( "pistol_burst", true, 500, 250);
		zm_weapons::include_upgraded_weapon( "pistol_burst", "pistol_burst_upgraded", false, 500, 250);
	}
	
	/*if(GetDvarInt("mutator_bo3_l4_siege") == MUTATOR_OFFON_ON)
	{
		zm_weapons::include_weapon( "launcher_multi", true, 5000, 500);
		zm_weapons::include_upgraded_weapon( "launcher_multi", "launcher_multi_upgraded", false, 5000, 500);
	}*/
	
	if(GetDvarInt("mutator_bo3_rpk") == MUTATOR_OFFON_ON)
	{
		zm_weapons::include_weapon( "lmg_rpk", true, 5000, 500);
		zm_weapons::include_upgraded_weapon( "lmg_rpk", "lmg_rpk_upgraded", false, 5000, 500);
	}
	
	if(GetDvarInt("mutator_bo3_ak74u") == MUTATOR_OFFON_ON)
	{
		zm_weapons::include_weapon( "smg_ak74u", true, 5000, 500);
		zm_weapons::include_upgraded_weapon( "smg_ak74u", "smg_ak74u_upgraded", false, 5000, 500);
	}
	
	if(GetDvarInt("mutator_bo3_galil") == MUTATOR_OFFON_ON)
	{
		zm_weapons::include_weapon( "ar_galil", true, 5000, 500);
		zm_weapons::include_upgraded_weapon( "ar_galil", "ar_galil_upgraded", false, 5000, 500);
	}
	
	if(GetDvarInt("mutator_bo3_m16") == MUTATOR_OFFON_ON)
	{
		zm_weapons::include_weapon( "ar_m16", true, 5000, 500);
		zm_weapons::include_upgraded_weapon( "ar_m16", "ar_m16_upgraded", false, 5000, 500);
	}
	
	if(GetDvarInt("mutator_bo3_m14") == MUTATOR_OFFON_ON)
	{
		zm_weapons::include_weapon( "ar_m14", true, 5000, 500);
		zm_weapons::include_upgraded_weapon( "ar_m14", "ar_m14_upgraded", false, 5000, 500);
	}
	
	/*if(GetDvarInt("mutator_bo3_mx_garand") == MUTATOR_OFFON_ON)
	{
		zm_weapons::include_weapon( "ar_garand", true, 5000, 500);
		zm_weapons::include_upgraded_weapon( "ar_garand", "ar_garand_upgraded", false, 5000, 500);
	}*/
	
	/*if(GetDvarInt("mutator_bo3_hg40") == MUTATOR_OFFON_ON)
	{
		zm_weapons::include_weapon( "smg_mp40", true, 5000, 500);
		zm_weapons::include_upgraded_weapon( "smg_mp40", "smg_mp40_upgraded", false, 5000, 500);
	}*/
	
	if(GetDvarInt("mutator_bo3_mp40") == MUTATOR_OFFON_ON)
	{
		zm_weapons::include_weapon( "smg_mp40_1940", true, 1300, 650);
		zm_weapons::include_upgraded_weapon( "smg_mp40_1940", "smg_mp40_1940_upgraded", false, 1300, 650);
	}
	
	if(GetDvarInt("mutator_bo3_stg") == MUTATOR_OFFON_ON)
	{
		zm_weapons::include_weapon( "ar_stg44", true, 1400, 700);
		zm_weapons::include_upgraded_weapon( "ar_stg44", "ar_stg44_upgraded", false, 1400, 700);
	}
	
	/*if(GetDvarInt("mutator_bo3_ppsh") == MUTATOR_OFFON_ON)
	{
		zm_weapons::include_weapon( "smg_ppsh", true, 5000, 500);
		zm_weapons::include_upgraded_weapon( "smg_ppsh", "smg_ppsh_upgraded", false, 5000, 500);
	}*/
	
	/*if(GetDvarInt("mutator_bo3_bootlegger") == MUTATOR_OFFON_ON)
	{
		zm_weapons::include_weapon( "smg_sten", true, 5000, 500);
		zm_weapons::include_upgraded_weapon( "smg_sten", "smg_sten_upgraded", false, 5000, 500);
	}*/
	
	if(GetDvarInt("mutator_bo3_m1927") == MUTATOR_OFFON_ON)
	{
		zm_weapons::include_weapon( "smg_thompson", true, 1750, 875);
		zm_weapons::include_upgraded_weapon( "smg_thompson", "smg_thompson_upgraded", false, 1750, 875);
	}
	
	if(GetDvarInt("mutator_bo3_mg08") == MUTATOR_OFFON_ON)
	{
		zm_weapons::include_weapon( "lmg_mg08", true, 5000, 500);
		zm_weapons::include_upgraded_weapon( "lmg_mg08", "lmg_mg08_upgraded", false, 5000, 500);
	}
	
	/*if(GetDvarInt("mutator_bo3_peacekeeper") == MUTATOR_OFFON_ON)
	{
		zm_weapons::include_weapon( "ar_peacekeeper", true, 5000, 500);
		zm_weapons::include_upgraded_weapon( "ar_peacekeeper", "ar_peacekeeper_upgraded", false, 5000, 500);
	}*/
	
	/*if(GetDvarInt("mutator_bo3_marshal") == MUTATOR_OFFON_ON)
	{
		zm_weapons::include_weapon( "pistol_shotgun_dw", true, 5000, 500);
		zm_weapons::include_upgraded_weapon( "pistol_shotgun_dw", "pistol_shotgun_dw_upgraded", false, 5000, 500);
	}*/
	
	/*if(GetDvarInt("mutator_bo3_razorback") == MUTATOR_OFFON_ON)
	{
		zm_weapons::include_weapon( "smg_longrange", true, 5000, 500);
		zm_weapons::include_upgraded_weapon( "smg_longrange", "smg_longrange_upgraded", false, 5000, 500);
	}*/
	
	/*if(GetDvarInt("mutator_bo3_banshii") == MUTATOR_OFFON_ON)
	{
		zm_weapons::include_weapon( "shotgun_energy", true, 5000, 500);
		zm_weapons::include_upgraded_weapon( "shotgun_energy", "shotgun_energy_upgraded", false, 5000, 500);
	}*/
	
	if(GetDvarString("mapname") == "zm_coast")
	{
		zm_weapons::include_weapon( "t9_crossbow", true, 4000, 500 );
		zm_weapons::include_upgraded_weapon( "t9_crossbow", "t9_crossbow_up", false, 4000, 500 );
		
		zm_weapons::include_weapon( "t9_ballistic_knife", true, 2000, 500 );
		zm_weapons::include_upgraded_weapon( "t9_ballistic_knife", "t9_ballistic_knife_up", false, 2000, 500 );
		
		zm_weapons::include_weapon( "knife_ballistic_sickle", false, 2000, 500 );
		zm_weapons::include_upgraded_weapon( "knife_ballistic_sickle", "knife_ballistic_sickle_upgraded", false, 2000, 500 );
	}
	
	if(GetDvarInt("mutator_crossbow") == MUTATOR_ONOFF_OFF)
		RemoveZombieBoxWeapon(GetWeapon("t9_crossbow"));
	
	if(GetDvarInt("mutator_ballistic_knife") == MUTATOR_ONOFF_OFF)
		RemoveZombieBoxWeapon(GetWeapon("t9_ballistic_knife"));
	
	if(GetDvarInt("mutator_enfield") == MUTATOR_OFFON_ON)
	{
		zm_weapons::include_weapon( "t5_enfield", true, 1250, 500);
		zm_weapons::include_upgraded_weapon( "t5_enfield", "t5_enfield_up", false, 1250, 500);
	}
	
	if(GetDvarInt("mutator_wa2000") == MUTATOR_OFFON_ON && GetDvarInt("mutator_scopeads") == 2)
	{
		zm_weapons::include_weapon( "t5_wa2000", true, 1600, 500 );
		zm_weapons::include_upgraded_weapon( "t5_wa2000", "t5_wa2000_up", false, 1600, 500 );
		weapon = GetWeapon("t5_wa2000");
		AddZombieBoxWeapon(weapon, weapon.worldmodel, false);
	}
	
	if(GetDvarInt("mutator_psg1") == MUTATOR_OFFON_ON && GetDvarInt("mutator_scopeads") == 2)
	{
		zm_weapons::include_weapon( "t5_psg1", true, 2000, 500 );
		zm_weapons::include_upgraded_weapon( "t5_psg1", "t5_psg1_up", false, 2000, 500 );
	}
	
	switch(GetDvarInt("mutator_scopeads"))
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
	}
	
	if(GetDvarInt("mutator_ppsh") == MUTATOR_OFFON_ON)
	{
		if(GetDvarInt("mutator_bocw_ppsh") == MUTATOR_OFFON_ON)
		{
			zm_weapons::include_weapon( "t9_ppsh41_drum", true, 2000, 500 );
			zm_weapons::include_upgraded_weapon( "t9_ppsh41_drum", "t9_ppsh41_drum_up", false, 2000, 500 );
		}
		else
		{
			zm_weapons::include_weapon( "t4r_ppsh", true, 2000, 500 );
			zm_weapons::include_upgraded_weapon( "t4r_ppsh", "t4r_ppsh_etch_upgraded", false, 2000, 500 );
		}
	}
	
	if(GetDvarString("mapname") == "zm_der_riese")
	{
		if(GetDvarInt("mutator_declassified_ppsh") == 2)
		{
			zm_weapons::include_weapon( "smg_ppsh", true, 5000, 500 );
			zm_weapons::include_upgraded_weapon( "smg_ppsh", "smg_ppsh_upgraded", false, 5000, 500 );
		}
		
		if(GetDvarInt("mutator_declassified_mg42") == 2)
		{
			zm_weapons::include_weapon( "s2_mg42", true, 3000, 500 );
			zm_weapons::include_upgraded_weapon( "s2_mg42", "s2_mg42_upgraded", false, 3000, 500 );
		}
	}
	
	if(GetDvarInt("mutator_bocw_1911") == MUTATOR_OFFON_ON)
	{
		zm_weapons::include_weapon( "t9_1911", false, 300, undefined );
		zm_weapons::include_upgraded_weapon( "t9_1911", "t9_1911_rdw_up", false, 300, undefined );
	}
	
	if(GetDvarInt("mutator_bocw_magnum") == MUTATOR_OFFON_ON)
	{
		zm_weapons::include_weapon( "t9_magnum", true, 1300, undefined );
		zm_weapons::include_upgraded_weapon( "t9_magnum", "t9_magnum_up", false, 1300, undefined );
		RemoveZombieBoxWeapon(GetWeapon("t5_python"));
	}
	
	if(GetDvarInt("mutator_bocw_gallosa12") == MUTATOR_OFFON_ON)
	{
		zm_weapons::include_weapon( "t9_gallo_sa12", true, 1250, undefined );
		zm_weapons::include_upgraded_weapon( "t9_gallo_sa12", "t9_gallo_sa12_up", false, 1250, undefined );
		RemoveZombieBoxWeapon(GetWeapon("t5_spas12"));
	}
	
	/*if(GetDvarInt("mutator_bocw_commando") == MUTATOR_OFFON_ON)
	{
		zm_weapons::include_weapon( "t9_xm4", true, 1400, undefined );
		zm_weapons::include_upgraded_weapon( "t9_xm4", "t9_xm4_up", false, 1400, undefined );
		RemoveZombieBoxWeapon(GetWeapon("t5_commando"));
	}*/
	
	if(GetDvarInt("mutator_bocw_galil") == MUTATOR_OFFON_ON)
	{
		zm_weapons::include_weapon( "t9_grav", true, 1500, undefined );
		zm_weapons::include_upgraded_weapon( "t9_grav", "t9_grav_up", false, 1500, undefined );
		RemoveZombieBoxWeapon(GetWeapon("t5_galil"));
	}
	
	if(GetDvarInt("mutator_bocw_hk21") == MUTATOR_OFFON_ON)
	{
		zm_weapons::include_weapon( "t9_hk21", true, 2750, undefined );
		zm_weapons::include_upgraded_weapon( "t9_hk21", "t9_hk21_up", false, 2750, undefined );
		RemoveZombieBoxWeapon(GetWeapon("t5_hk21"));
	}
	
	if(GetDvarInt("mutator_bocw_rpk") == MUTATOR_OFFON_ON)
	{
		zm_weapons::include_weapon( "t9_rpk", true, 2500, undefined );
		zm_weapons::include_upgraded_weapon( "t9_rpk", "t9_rpk_up", false, 2500, undefined );
		RemoveZombieBoxWeapon(GetWeapon("t5_rpk"));
	}
}

function tempCallback(localClientNum, oldVal, newVal, bNewEnt, bInitialSnap, fieldName, bWasTimeJump) {
    
}

