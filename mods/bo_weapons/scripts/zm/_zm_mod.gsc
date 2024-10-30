#using scripts\codescripts\struct;

#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\hud_message_shared;
#using scripts\shared\util_shared;
#using scripts\shared\_oob;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\statstable_shared.gsh;
#insert scripts\shared\version.gsh;

#using scripts\shared\ai\zombie_utility;

#using scripts\zm\_util;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_melee_weapon;
#using scripts\zm\gametypes\_clientids;

#using scripts\zm\_zm_magicbox;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_blockers;

#using scripts\zm\_zm_powerup_random_weapon;
#using scripts\shared\aat_shared;

#insert scripts\zm\_zm_perks.gsh;
#insert scripts\zm\_zm_utility.gsh;
#insert scripts\zm\_zm_mutators.gsh;




#namespace zm_mod;

function init() {
    //level.round_prestart_func = &do_pregame_menu;
    
	zm_utility::register_lethal_grenade_for_level( "sticky_grenade" );
	zm_weapons::add_retrievable_knife_init_name("t9_ballistic_knife");
	zm_weapons::add_retrievable_knife_init_name("t9_ballistic_knife_up");
}

function load_tf_options(){
    
    level endon("game_ended");
    level waittill("initial_blackscreen_passed");
    
    apply_choices();
    
    level.game_began = true;
    level notify("menu_closed");
    
}

/*function do_pregame_menu() {
    level waittill("menu_closed");
    wait 2;
}*/




function apply_choices() {
	
	switch(GetDvarInt("mutator_ak47"))
	{
	/*case 2:
		{
			zm_utility::include_weapon( "t5_ak47", true );
			zm_utility::include_weapon( "t5_ak47_up", false );
			zm_weapons::add_zombie_weapon( "t5_ak47", "t5_ak47_up", "", 1300, "rifle", "", 500, "", false, "" );
			break;
		}
	case 3:
		{
			zm_utility::include_weapon( "t5_ak47", true );
			zm_utility::include_weapon( "t5_ak47_up_alt", false );
			zm_weapons::add_zombie_weapon( "t5_ak47", "t5_ak47_up_alt", "", 1300, "rifle", "", 500, "", false, "" );
			break;
		}*/
	case MUTATOR_OFFON_ON:
		{
			if(GetDvarInt("mutator_bocw_ak47") == MUTATOR_OFFON_ON)
			{
				zm_utility::include_weapon( "t9_ak47", true );
				zm_utility::include_weapon( "t9_ak47_up_alt", false );
				zm_weapons::add_zombie_weapon( "t9_ak47", "t9_ak47_up_alt", "", 1300, "rifle", "", 500, "", false, "" );
			}
			else
			{
				zm_utility::include_weapon( "t5_ak47", true );
				zm_utility::include_weapon( "t5_ak47_up_alt", false );
				zm_weapons::add_zombie_weapon( "t5_ak47", "t5_ak47_up_alt", "", 1300, "rifle", "", 500, "", false, "" );
			}
			
			break;
		}
	}

	switch(GetDvarInt("mutator_uzi"))
	{
	case 2:
		{
			zm_utility::include_weapon( "t5_uzi", true );
			zm_utility::include_weapon( "t5_uzi_up", false );
			zm_weapons::add_zombie_weapon( "t5_uzi", "t5_uzi_up", "", 1500, "smg", "", 500, "", false, "" );
			break;
		}
	case 3:
		{
			zm_utility::include_weapon( "t5_uzi_alt", true );
			zm_utility::include_weapon( "t5_uzi_up_alt", false );
			zm_weapons::add_zombie_weapon( "t5_uzi_alt", "t5_uzi_up_alt", "", 1500, "smg", "", 500, "", false, "" );
			break;
		}
	}
	
	if(GetDvarInt("mutator_skorpion") == MUTATOR_OFFON_ON)
	{
		zm_utility::include_weapon( "t5_skorpion", true );
		zm_utility::include_weapon( "t5_skorpion_rdw_up", false );
		zm_weapons::add_zombie_weapon( "t5_skorpion", "t5_skorpion_rdw_up", "", 1100, "smg", "", 500, "", false, "" );
	}
	
	if(GetDvarInt("mutator_stoner63") == MUTATOR_OFFON_ON)
	{
		if(GetDvarInt("mutator_bocw_stoner63") == MUTATOR_OFFON_ON)
		{
			zm_utility::include_weapon( "t9_stoner63", true );
			zm_utility::include_weapon( "t9_stoner63_up", false );
			zm_weapons::add_zombie_weapon( "t9_stoner63", "t9_stoner63_up", "", 2250, "lmg", "", 500, "", false, "" );
		}
		else
		{
			zm_utility::include_weapon( "t5_stoner63", true );
			zm_utility::include_weapon( "t5_stoner63_up", false );
			zm_weapons::add_zombie_weapon( "t5_stoner63", "t5_stoner63_up", "", 2250, "lmg", "", 500, "", false, "" );
		}
	}
	
	if(GetDvarInt("mutator_bo3_weapons") == MUTATOR_OFFON_ON)
	{
		//VMP
		zm_utility::include_weapon( "smg_versatile", true );
		zm_utility::include_weapon( "smg_versatile_upgraded", false );
		zm_weapons::add_zombie_weapon( "smg_versatile", "smg_versatile_upgraded", "", 1300, "smg", "", 500, "", false, "" );
		//Weevil
		zm_utility::include_weapon( "smg_capacity", true );
		zm_utility::include_weapon( "smg_capacity_upgraded", false );
		zm_weapons::add_zombie_weapon( "smg_capacity", "smg_capacity_upgraded", "", 5000, "smg", "", 500, "", false, "" );
		//Pharo
		zm_utility::include_weapon( "smg_burst", true );
		zm_utility::include_weapon( "smg_burst_upgraded", false );
		zm_weapons::add_zombie_weapon( "smg_burst", "smg_burst_upgraded", "", 700, "smg", "", 350, "", false, "" );
		//Man-O-War
		zm_utility::include_weapon( "ar_damage", true );
		zm_utility::include_weapon( "ar_damage_upgraded", false );
		zm_weapons::add_zombie_weapon( "ar_damage", "ar_damage_upgraded", "", 5000, "rifle", "", 500, "", false, "" );
		//HVK-30
		zm_utility::include_weapon( "ar_cqb", true );
		zm_utility::include_weapon( "ar_cqb_upgraded", false );
		zm_weapons::add_zombie_weapon( "ar_cqb", "ar_cqb_upgraded", "", 1600, "rifle", "", 500, "", false, "" );
		//Sheiva
		zm_utility::include_weapon( "ar_marksman", true );
		zm_utility::include_weapon( "ar_marksman_upgraded", false );
		zm_weapons::add_zombie_weapon( "ar_marksman", "ar_marksman_upgraded", "", 500, "rifle", "", 250, "", false, "" );
		//ICR-1
		zm_utility::include_weapon( "ar_accurate", true );
		zm_utility::include_weapon( "ar_accurate_upgraded", false );
		zm_weapons::add_zombie_weapon( "ar_accurate", "ar_accurate_upgraded", "", 1500, "rifle", "", 500, "", false, "" );
		//Argus
		zm_utility::include_weapon( "shotgun_precision", true );
		zm_utility::include_weapon( "shotgun_precision_upgraded", false );
		zm_weapons::add_zombie_weapon( "shotgun_precision", "shotgun_precision_upgraded", "", 1100, "shotgun", "", 500, "", false, "" );
		//205 Brecci
		zm_utility::include_weapon( "shotgun_semiauto", true );
		zm_utility::include_weapon( "shotgun_semiauto_upgraded", false );
		zm_weapons::add_zombie_weapon( "shotgun_semiauto", "shotgun_semiauto_upgraded", "", 5000, "shotgun", "", 500, "", false, "" );
		//Haymaker 12
		zm_utility::include_weapon( "shotgun_fullauto", true );
		zm_utility::include_weapon( "shotgun_fullauto_upgraded", false );
		zm_weapons::add_zombie_weapon( "shotgun_fullauto", "shotgun_fullauto_upgraded", "", 5000, "shotgun", "", 500, "", false, "" );
		//Dingo
		zm_utility::include_weapon( "lmg_cqb", true );
		zm_utility::include_weapon( "lmg_cqb_upgraded", false );
		zm_weapons::add_zombie_weapon( "lmg_cqb", "lmg_cqb_upgraded", "", 5000, "lmg", "", 500, "", false, "" );
		//BRM
		zm_utility::include_weapon( "lmg_light", true );
		zm_utility::include_weapon( "lmg_light_upgraded", false );
		zm_weapons::add_zombie_weapon( "lmg_light", "lmg_light_upgraded", "", 5000, "lmg", "", 500, "", false, "" );
		//48 Dredge
		zm_utility::include_weapon( "lmg_heavy", true );
		zm_utility::include_weapon( "lmg_heavy_upgraded", false );
		zm_weapons::add_zombie_weapon( "lmg_heavy", "lmg_heavy_upgraded", "", 5000, "lmg", "", 500, "", false, "" );
		//Gorgon
		zm_utility::include_weapon( "lmg_slowfire", true );
		zm_utility::include_weapon( "lmg_slowfire_upgraded", false );
		zm_weapons::add_zombie_weapon( "lmg_slowfire", "lmg_slowfire_upgraded", "", 5000, "lmg", "", 500, "", false, "" );
		//Locus
		if(isdefined(level.zombie_weapons_upgraded[GetWeapon("sniper_fastbolt_upgraded")])) //surprisingly some maps don't have the PaP Locus in them so the machine will steal your gun!
		{
			zm_utility::include_weapon( "sniper_fastbolt", true );
			zm_utility::include_weapon( "sniper_fastbolt_upgraded", false );
			zm_weapons::add_zombie_weapon( "sniper_fastbolt", "sniper_fastbolt_upgraded", "", 5000, "sniper", "", 500, "", false, "" );
		}
		//Drakon
		zm_utility::include_weapon( "sniper_fastsemi", true );
		zm_utility::include_weapon( "sniper_fastsemi_upgraded", false );
		zm_weapons::add_zombie_weapon( "sniper_fastsemi", "sniper_fastsemi_upgraded", "", 5000, "sniper", "", 500, "", false, "" );
		//SVG-100
		zm_utility::include_weapon( "sniper_powerbolt", true );
		zm_utility::include_weapon( "sniper_powerbolt_upgraded", false );
		zm_weapons::add_zombie_weapon( "sniper_powerbolt", "sniper_powerbolt_upgraded", "", 5000, "sniper", "", 500, "", false, "" );
		//XM-53
		zm_utility::include_weapon( "launcher_standard", true );
		zm_utility::include_weapon( "launcher_standard_upgraded", false );
		zm_weapons::add_zombie_weapon( "launcher_standard", "launcher_standard_upgraded", "", 10000, "special", "", 500, "", false, "" );
		aat::register_aat_exemption(getweapon("launcher_standard_upgraded"));
		//KN-44
		zm_utility::include_weapon( "ar_standard", true );
		zm_utility::include_weapon( "ar_standard_upgraded", false );
		zm_weapons::add_zombie_weapon( "ar_standard", "ar_standard_upgraded", "", 1400, "rifle", "", 500, "", false, "" );
		//Vesper
		zm_utility::include_weapon( "smg_fastfire", true );
		zm_utility::include_weapon( "smg_fastfire_upgraded", false );
		zm_weapons::add_zombie_weapon( "smg_fastfire", "smg_fastfire_upgraded", "", 1250, "smg", "", 500, "", false, "" );
		//Kuda
		zm_utility::include_weapon( "smg_standard", true );
		zm_utility::include_weapon( "smg_standard_upgraded", false );
		zm_weapons::add_zombie_weapon( "smg_standard", "smg_standard_upgraded", "", 1250, "smg", "", 500, "", false, "" );
		//M8A7
		zm_utility::include_weapon( "ar_longburst", true );
		zm_utility::include_weapon( "ar_longburst_upgraded", false );
		zm_weapons::add_zombie_weapon( "ar_longburst", "ar_longburst_upgraded", "", 1500, "rifle", "", 500, "", false, "" );
		//L-CAR 9
		zm_utility::include_weapon( "pistol_fullauto", true );
		zm_utility::include_weapon( "pistol_fullauto_upgraded", false );
		zm_weapons::add_zombie_weapon( "pistol_fullauto", "pistol_fullauto_upgraded", "", 750, "pistol", "", 375, "", false, "" );
		//FFAR
		zm_utility::include_weapon( "ar_famas", true );
		zm_utility::include_weapon( "ar_famas_upgraded", false );
		zm_weapons::add_zombie_weapon( "ar_famas", "ar_famas_upgraded", "", 5000, "rifle", "", 500, "", false, "reddot grip" );
		//KRM-262
		zm_utility::include_weapon( "shotgun_pump", true );
		zm_utility::include_weapon( "shotgun_pump_upgraded", false );
		zm_weapons::add_zombie_weapon( "shotgun_pump", "shotgun_pump_upgraded", "", 750, "shotgun", "", 375, "", false, "" );
	}
	
	if(GetDvarInt("mutator_bo3_rk5") == MUTATOR_OFFON_ON)
	{
		zm_utility::include_weapon( "pistol_burst", true );
		zm_utility::include_weapon( "pistol_burst_upgraded", false );
		zm_weapons::add_zombie_weapon( "pistol_burst", "pistol_burst_upgraded", "", 500, "pistol", "", 250, "", false, "" );
	}
	
	/*if(GetDvarInt("mutator_bo3_l4_siege") == MUTATOR_OFFON_ON)
	{
		zm_utility::include_weapon( "launcher_multi", true );
		zm_utility::include_weapon( "launcher_multi_upgraded", false );
		zm_weapons::add_zombie_weapon( "launcher_multi", "launcher_multi_upgraded", "", 5000, "special", "", 500, "", false, "" );
		aat::register_aat_exemption(getweapon("launcher_multi_upgraded"));
	}*/
	
	if(GetDvarInt("mutator_bo3_rpk") == MUTATOR_OFFON_ON)
	{
		zm_utility::include_weapon( "lmg_rpk", true );
		zm_utility::include_weapon( "lmg_rpk_upgraded", false );
		zm_weapons::add_zombie_weapon( "lmg_rpk", "lmg_rpk_upgraded", "", 5000, "lmg", "", 500, "", false, "reflex quickdraw_lmg" );
	}
	
	if(GetDvarInt("mutator_bo3_ak74u") == MUTATOR_OFFON_ON)
	{
		zm_utility::include_weapon( "smg_ak74u", true );
		zm_utility::include_weapon( "smg_ak74u_upgraded", false );
		zm_weapons::add_zombie_weapon( "smg_ak74u", "smg_ak74u_upgraded", "", 5000, "smg", "", 500, "", false, "reflex steadyaim" );
	}
	
	if(GetDvarInt("mutator_bo3_galil") == MUTATOR_OFFON_ON)
	{
		zm_utility::include_weapon( "ar_galil", true );
		zm_utility::include_weapon( "ar_galil_upgraded", false );
		zm_weapons::add_zombie_weapon( "ar_galil", "ar_galil_upgraded", "", 5000, "rifle", "", 500, "", false, "reflex quickdraw fastreload" );
	}
	
	if(GetDvarInt("mutator_bo3_m16") == MUTATOR_OFFON_ON)
	{
		zm_utility::include_weapon( "ar_m16", true );
		zm_utility::include_weapon( "ar_m16_upgraded", false );
		zm_weapons::add_zombie_weapon( "ar_m16", "ar_m16_upgraded", "", 5000, "rifle", "", 500, "", false, "reddot grip stalker" );
	}
	
	if(GetDvarInt("mutator_bo3_m14") == MUTATOR_OFFON_ON)
	{
		zm_utility::include_weapon( "ar_m14", true );
		zm_utility::include_weapon( "ar_m14_upgraded", false );
		zm_weapons::add_zombie_weapon( "ar_m14", "ar_m14_upgraded", "", 5000, "rifle", "", 500, "", false, "grip quickdraw steadyaim" );
	}
	
	/*if(GetDvarInt("mutator_bo3_mx_garand") == MUTATOR_OFFON_ON)
	{
		zm_utility::include_weapon( "ar_garand", true );
		zm_utility::include_weapon( "ar_garand_upgraded", false );
		zm_weapons::add_zombie_weapon( "ar_garand", "ar_garand_upgraded", "", 5000, "rifle", "", 500, "", false, "" );
	}*/
	
	/*if(GetDvarInt("mutator_bo3_hg40") == MUTATOR_OFFON_ON)
	{
		zm_utility::include_weapon( "smg_mp40", true );
		zm_utility::include_weapon( "smg_mp40_upgraded", false );
		zm_weapons::add_zombie_weapon( "smg_mp40", "smg_mp40_upgraded", "", 5000, "smg", "", 500, "", false, "stalker quickdraw" );
	}*/
	
	if(GetDvarInt("mutator_bo3_mp40") == MUTATOR_OFFON_ON)
	{
		zm_utility::include_weapon( "smg_mp40_1940", true );
		zm_utility::include_weapon( "smg_mp40_1940_upgraded", false );
		zm_weapons::add_zombie_weapon( "smg_mp40_1940", "smg_mp40_1940_upgraded", "", 1300, "smg", "", 650, "", false, "" );
	}
	
	if(GetDvarInt("mutator_bo3_stg") == MUTATOR_OFFON_ON)
	{
		zm_utility::include_weapon( "ar_stg44", true );
		zm_utility::include_weapon( "ar_stg44_upgraded", false );
		zm_weapons::add_zombie_weapon( "ar_stg44", "ar_stg44_upgraded", "", 1400, "rifle", "", 700, "", false, "" );
	}
	
	/*if(GetDvarInt("mutator_bo3_ppsh") == MUTATOR_OFFON_ON)
	{
		zm_utility::include_weapon( "smg_ppsh", true );
		zm_utility::include_weapon( "smg_ppsh_upgraded", false );
		zm_weapons::add_zombie_weapon( "smg_ppsh", "smg_ppsh_upgraded", "", 5000, "smg", "", 500, "", false, "" );
	}*/
	
	/*if(GetDvarInt("mutator_bo3_bootlegger") == MUTATOR_OFFON_ON)
	{
		zm_utility::include_weapon( "smg_sten", true );
		zm_utility::include_weapon( "smg_sten_upgraded", false );
		zm_weapons::add_zombie_weapon( "smg_sten", "smg_sten_upgraded", "", 5000, "smg", "", 500, "", false, "" );
	}*/

	if(GetDvarInt("mutator_bo3_m1927") == MUTATOR_OFFON_ON)
	{
		zm_utility::include_weapon( "smg_thompson", true );
		zm_utility::include_weapon( "smg_thompson_upgraded", false );
		zm_weapons::add_zombie_weapon( "smg_thompson", "smg_thompson_upgraded", "", 1750, "smg", "", 875, "", false, "" );
	}
	
	if(GetDvarInt("mutator_bo3_mg08") == MUTATOR_OFFON_ON)
	{
		zm_utility::include_weapon( "lmg_mg08", true );
		zm_utility::include_weapon( "lmg_mg08_upgraded", false );
		zm_weapons::add_zombie_weapon( "lmg_mg08", "lmg_mg08_upgraded", "", 5000, "lmg", "", 500, "", false, "" );
	}
	
	/*if(GetDvarInt("mutator_bo3_peacekeeper") == MUTATOR_OFFON_ON)
	{
		zm_utility::include_weapon( "ar_peacekeeper", true );
		zm_utility::include_weapon( "ar_peacekeeper_upgraded", false );
		zm_weapons::add_zombie_weapon( "ar_peacekeeper", "ar_peacekeeper_upgraded", "", 5000, "rifle", "", 500, "", false, "" );
	}*/

	/*if(GetDvarInt("mutator_bo3_marshal") == MUTATOR_OFFON_ON)
	{
		zm_utility::include_weapon( "pistol_shotgun_dw", true );
		zm_utility::include_weapon( "pistol_shotgun_dw_upgraded", false );
		zm_weapons::add_zombie_weapon( "pistol_shotgun_dw", "pistol_shotgun_dw_upgraded", "", 5000, "pistol", "", 500, "", false, "" );
	}*/

	/*if(GetDvarInt("mutator_bo3_razorback") == MUTATOR_OFFON_ON)
	{
		zm_utility::include_weapon( "smg_longrange", true );
		zm_utility::include_weapon( "smg_longrange_upgraded", false );
		zm_weapons::add_zombie_weapon( "smg_longrange", "smg_longrange_upgraded", "", 5000, "smg", "", 500, "", false, "holo grip" );
	}*/

	/*if(GetDvarInt("mutator_bo3_banshii") == MUTATOR_OFFON_ON)
	{
		zm_utility::include_weapon( "shotgun_energy", true );
		zm_utility::include_weapon( "shotgun_energy_upgraded", false );
		zm_weapons::add_zombie_weapon( "shotgun_energy", "shotgun_energy_upgraded", "", 5000, "shotgun", "", 500, "", false, "quickdraw stalker holo" );
	}*/
	
	if(GetDvarInt("mutator_enfield") == MUTATOR_OFFON_ON)
	{
		zm_utility::include_weapon( "t5_enfield", true );
		zm_utility::include_weapon( "t5_enfield_up", false );
		zm_weapons::add_zombie_weapon( "t5_enfield", "t5_enfield_up", "", 1250, "rifle", "", 500, "", false, "" );
	}
	
	if(GetDvarInt("mutator_wa2000") == MUTATOR_OFFON_ON && GetDvarInt("mutator_scopeads") == MUTATOR_OFFON_ON)
	{
		zm_utility::include_weapon( "t5_wa2000", true );
		zm_utility::include_weapon( "t5_wa2000_up", false );
		zm_weapons::add_zombie_weapon( "t5_wa2000", "t5_wa2000_up", "", 1600, "sniper", "", 500, "", false, "" );
	}
	
	if(GetDvarInt("mutator_psg1") == MUTATOR_OFFON_ON && GetDvarInt("mutator_scopeads") == MUTATOR_OFFON_ON)
	{
		zm_utility::include_weapon( "t5_psg1", true );
		zm_utility::include_weapon( "t5_psg1_up", true );
		zm_weapons::add_zombie_weapon( "t5_psg1", "t5_psg1_up", "", 2000, "sniper", "", 500, "", false, "" );
	}
	
	switch(GetDvarInt("mutator_scopeads"))
	{
		case 1:
		{
			zm_utility::include_weapon( "t5_dragunov_overlay", true );
			zm_utility::include_weapon( "t5_dragunov_up_overlay", false );
			zm_weapons::add_zombie_weapon( "t5_dragunov_overlay", "t5_dragunov_up_overlay", "", 1750, "sniper", "", 500, "", false, "" );
			level.zombie_weapons[GetWeapon("t5_dragunov")].is_in_box = false;
			zm_utility::include_weapon( "t5_dragunov", false);
			
			zm_utility::include_weapon( "t5_g11_overlay", true );
			zm_utility::include_weapon( "t5_g11_up_overlay", false );
			zm_weapons::add_zombie_weapon( "t5_g11_overlay", "t5_g11_up_overlay", "", 1700, "rifle", "", 500, "", false, "" );
			level.zombie_weapons[GetWeapon("t5_g11")].is_in_box = false;
			zm_utility::include_weapon( "t5_g11", false);
			
			if(GetDvarInt("mutator_wa2000") == MUTATOR_OFFON_ON)
			{
				zm_utility::include_weapon( "t5_wa2000_overlay", true );
				zm_utility::include_weapon( "t5_wa2000_up_overlay", false );
				zm_weapons::add_zombie_weapon( "t5_wa2000_overlay", "t5_wa2000_up_overlay", "", 1600, "sniper", "", 500, "", false, "" );
			}
			
			if(GetDvarInt("mutator_psg1") == MUTATOR_OFFON_ON)
			{
				zm_utility::include_weapon( "t5_psg1_overlay", true );
				zm_utility::include_weapon( "t5_psg1_up_overlay", false );
				zm_weapons::add_zombie_weapon( "t5_psg1_overlay", "t5_psg1_up_overlay", "", 2000, "sniper", "", 500, "", false, "" );
			}
			
			break;
		}
		case 3:
		{
			zm_utility::include_weapon( "t5_dragunov_switch", true );
			zm_utility::include_weapon( "t5_dragunov_up_switch", false );
			zm_weapons::add_zombie_weapon( "t5_dragunov_switch", "t5_dragunov_up_switch", "", 1750, "sniper", "", 500, "", false, "" );
			level.zombie_weapons[GetWeapon("t5_dragunov")].is_in_box = false;
			zm_utility::include_weapon( "t5_dragunov", false);
			
			zm_utility::include_weapon( "t5_g11_switch", true );
			zm_utility::include_weapon( "t5_g11_up_switch", false );
			zm_weapons::add_zombie_weapon( "t5_g11_switch", "t5_g11_up_switch", "", 1700, "rifle", "", 500, "", false, "" );
			level.zombie_weapons[GetWeapon("t5_g11")].is_in_box = false;
			zm_utility::include_weapon( "t5_g11", false);
			
			if(GetDvarInt("mutator_wa2000") == MUTATOR_OFFON_ON)
			{
				zm_utility::include_weapon( "t5_wa2000_switch", true );
				zm_utility::include_weapon( "t5_wa2000_up_switch", false );
				zm_weapons::add_zombie_weapon( "t5_wa2000_switch", "t5_wa2000_up_switch", "", 1600, "sniper", "", 500, "", false, "" );
			}
			
			if(GetDvarInt("mutator_psg1") == MUTATOR_OFFON_ON)
			{
				zm_utility::include_weapon( "t5_psg1_switch", true);
				zm_utility::include_weapon( "t5_psg1_up_switch", false);
				zm_weapons::add_zombie_weapon( "t5_psg1_switch", "t5_psg1_up_switch", "", 2000, "sniper", "", 500, "", false, "" );
			}
			
			break;
		}
	}
	
	if(GetDvarInt("mutator_ppsh") == MUTATOR_OFFON_ON)
	{
		if(GetDvarInt("mutator_bocw_ppsh") == MUTATOR_OFFON_ON)
		{
			zm_utility::include_weapon( "t9_ppsh41_drum", true );
			zm_utility::include_weapon( "t9_ppsh41_drum_up", false );
			zm_weapons::add_zombie_weapon( "t9_ppsh41_drum", "t9_ppsh41_drum_up", "", 2000, "smg", "", 500, "", false, "" );
		}
		else
		{
			zm_utility::include_weapon( "t4r_ppsh", true );
			zm_utility::include_weapon( "t4r_ppsh_etch_upgraded", false );
			zm_weapons::add_zombie_weapon( "t4r_ppsh", "t4r_ppsh_etch_upgraded", "", 2000, "smg", "", 500, "", false, "" );
		}
	}
	
	if(GetDvarString("mapname") == "zm_der_riese")
	{
		if(GetDvarInt("mutator_declassified_ppsh") == MUTATOR_OFFON_ON)
		{
			zm_utility::include_weapon( "smg_ppsh", true );
			zm_utility::include_weapon( "smg_ppsh_upgraded", false );
			zm_weapons::add_zombie_weapon( "smg_ppsh", "smg_ppsh_upgraded", "", 5000, "smg", "", 500, "", false, "" );
		}
		
		if(GetDvarInt("mutator_declassified_mg42") == MUTATOR_OFFON_ON)
		{
			zm_utility::include_weapon( "s2_mg42", true );
			zm_utility::include_weapon( "s2_mg42_upgraded", false );
			zm_weapons::add_zombie_weapon( "s2_mg42", "s2_mg42_upgraded", "", 3000, "lmg", "", 500, "", false, "" );
		}
	}
	
	if(GetDvarInt("mutator_bocw_magnum") == MUTATOR_OFFON_ON)
	{
		level.zombie_weapons[GetWeapon("t5_python")].is_in_box = false;
		zm_utility::include_weapon( "t5_python", false);
		zm_utility::include_weapon( "t9_magnum", true);
		zm_utility::include_weapon( "t9_magnum_up", false);
		zm_weapons::add_zombie_weapon( "t9_magnum", "t9_magnum_up", "", 1300, "pistol", "", undefined, "", false, "" );
	}
	
	if(GetDvarInt("mutator_bocw_gallosa12") == MUTATOR_OFFON_ON)
	{
		level.zombie_weapons[GetWeapon("t5_spas12")].is_in_box = false;
		zm_utility::include_weapon( "t5_spas12", false);
		zm_utility::include_weapon( "t9_gallo_sa12", true);
		zm_utility::include_weapon( "t9_gallo_sa12_up", false);
		zm_weapons::add_zombie_weapon( "t9_gallo_sa12", "t9_gallo_sa12_up", "", 1250, "shotgun", "", undefined, "", false, "" );
	}
	
	/*if(GetDvarInt("mutator_bocw_commando") == MUTATOR_OFFON_ON)
	{
		level.zombie_weapons[GetWeapon("t5_commando")].is_in_box = false;
		zm_utility::include_weapon( "t5_commando", false);
		zm_utility::include_weapon( "t9_xm4", true);
		zm_utility::include_weapon( "t9_xm4_up", false);
		zm_weapons::add_zombie_weapon( "t9_xm4", "t9_xm4_up", "", 1400, "rifle", "", undefined, "", false, "" );
	}*/
	
	if(GetDvarInt("mutator_bocw_galil") == MUTATOR_OFFON_ON)
	{
		level.zombie_weapons[GetWeapon("t5_galil")].is_in_box = false;
		zm_utility::include_weapon( "t9_grav", false);
		zm_utility::include_weapon( "t9_grav", true);
		zm_utility::include_weapon( "t9_grav_up", false);
		zm_weapons::add_zombie_weapon( "t9_grav", "t9_grav_up", "", 1500, "rifle", "", undefined, "", false, "" );
	}
	
	if(GetDvarInt("mutator_bocw_hk21") == MUTATOR_OFFON_ON)
	{
		level.zombie_weapons[GetWeapon("t5_hk21")].is_in_box = false;
		zm_utility::include_weapon( "t5_hk21", false);
		zm_utility::include_weapon( "t9_hk21", true);
		zm_utility::include_weapon( "t9_hk21_up", false);
		zm_weapons::add_zombie_weapon( "t9_hk21", "t9_hk21_up", "", 2750, "lmg", "", undefined, "", false, "" );
	}
	
	if(GetDvarInt("mutator_bocw_rpk") == MUTATOR_OFFON_ON)
	{
		level.zombie_weapons[GetWeapon("t5_rpk")].is_in_box = false;
		zm_utility::include_weapon( "t5_rpk", false);
		zm_utility::include_weapon( "t9_rpk", true);
		zm_utility::include_weapon( "t9_rpk_up", false);
		zm_weapons::add_zombie_weapon( "t9_rpk", "t9_rpk_up", "", 2500, "lmg", "", undefined, "", false, "" );
	}
	
	if(GetDvarInt("mutator_double_packapunch") == MUTATOR_ONOFF_OFF)
	{
		keys = GetArrayKeys(level.zombie_weapons_upgraded);
		for ( i = 0; i < keys.size; i++ )
			aat::register_aat_exemption(keys[i]);
	}
	
	if(GetDvarInt("mutator_enable_gobblegum") == MUTATOR_OFFON_ON)
	{
		foreach(bgb_machine in level.bgb_machines)
		{
			bgb_machine thread hide_bgb_machine();
			bgb_machine thread fire_sale_disable();
		}
	}
	
	if(GetDvarInt("mutator_raygunmkii") == MUTATOR_ONOFF_OFF)
		level.zombie_weapons[GetWeapon("raygun_mark2")].is_in_box = false;
	else
	{
		if(isdefined(GetWeapon("raygun_mark2").worldmodel)) //stock maps
		{
			zm_utility::include_weapon( "raygun_mark2", true );
			zm_utility::include_weapon( "raygun_mark2_upgraded", false );
			zm_weapons::add_zombie_weapon( "raygun_mark2", "raygun_mark2_upgraded", "raygun", 10000, "", "", 0, "", true, "" );
			zm_weapons::add_limited_weapon("raygun_mark2", 1);
			aat::register_aat_exemption(getweapon("raygun_mark2_upgraded"));
		}
		else
		{
			zm_utility::include_weapon( "raygun_mark_ii", true );
			zm_utility::include_weapon( "raygun_mark_ii_upgraded", false );
			zm_weapons::add_zombie_weapon( "raygun_mark_ii", "raygun_mark_ii_upgraded", "raygun", 10000, "", "", 0, "", true, "" );
			zm_weapons::add_limited_weapon("raygun_mark_ii", 1);
			aat::register_aat_exemption(getweapon("raygun_mark_ii_upgraded"));
		}
	}
	
	if(GetDvarString("mapname") == "zm_coast")
	{
		zm_utility::include_weapon( "t9_crossbow", true );
		zm_utility::include_weapon( "t9_crossbow_up", false );
		zm_weapons::add_zombie_weapon( "t9_crossbow", "t9_crossbow_up", "", 4000, "special", "", 500, "", false, "" );
		aat::register_aat_exemption(getweapon("t9_crossbow_up"));
		
		zm_utility::include_weapon( "t9_ballistic_knife", true );
		zm_utility::include_weapon( "t9_ballistic_knife_up", false );
		zm_weapons::add_zombie_weapon( "t9_ballistic_knife", "t9_ballistic_knife_up", "", 2000, "special", "", 500, "", false, "" );
		aat::register_aat_exemption(getweapon("t9_ballistic_knife_up"));
		
		zm_utility::include_weapon( "knife_ballistic_sickle", false );
		zm_utility::include_weapon( "knife_ballistic_sickle_upgraded", false );
		zm_weapons::add_zombie_weapon( "knife_ballistic_sickle", "knife_ballistic_sickle_upgraded", "", 2000, "special", "", 500, "", false, "" );
		aat::register_aat_exemption(getweapon("knife_ballistic_sickle_upgraded"));
	}
	
	if(GetDvarInt("mutator_crossbow") == MUTATOR_ONOFF_OFF)
	{
		level.zombie_weapons[GetWeapon("t9_crossbow")].is_in_box = false;
		zm_utility::include_weapon( "t9_crossbow", false);
	}
	
	if(GetDvarInt("mutator_ballistic_knife") == MUTATOR_ONOFF_OFF)
	{
		level.zombie_weapons[GetWeapon("t9_ballistic_knife")].is_in_box = false;
		zm_utility::include_weapon( "t9_ballistic_knife", false);
	}
	
	if(GetDvarInt("mutator_enable_wunderfizz") == 2)
	{
		foreach(perk_random_machine in level.perk_random_machines)
		{
			perk_random_machine thread hide_perk_random_machine();
		}
	}
	
	switch(GetDvarInt("mutator_announcer"))
	{
		case 2: //Classic
		{
			level.zmannouncerprefix = "vox_zmbas_";
			break;
		}
		case 3: //Moon Richtofen
		{
			level.zmannouncerprefix = "vox_zmbamri_";
			level.player_4_vox_override = 1;
			level.zmb_laugh_alias = "zmb_laugh_richtofen";
			break;
		}
		case 4: //BO II Richtofen
		{
			level.zmannouncerprefix = "vox_zmbari_";
			level.player_4_vox_override = 1;
			level.zmb_laugh_alias = "zmb_laugh_richtofen";
			break;
		}
		case 5: //Origins Samantha
		{
			level.zmannouncerprefix = "vox_zmbaos_";
			break;
		}
		case 6: //Shadowman
		{
			level.zmannouncerprefix = "vox_zmbash_";
			level.zmb_laugh_alias = "zmb_laugh_shadowman";
			break;
		}
		case 7: //Dr Monty
		{
			level.zmannouncerprefix = "vox_zmbam_";
			break;
		}
	}
	
	//this doesn't work??? I don't like repeating the maxhealth code
	//if(GetDvarInt("mutator_health_difficulty" != 1))
	//{
		switch(GetDvarInt("mutator_health_difficulty"))
		{	
			case 2: //Recruit
			{
				level.player_deathinvulnerabletime = 4000;
				level.healthoverlaycutoff = 0.01;
				level.invultime_preshield = 0.6;
				level.invultime_onshield = 0.8;
				level.invultime_postshield = 0.5;
				level.playerhealth_regularregendelay = 3000;
				level.worthydamageratio = 0.0;
				
				//well, TF's Zombie Options set it to 75 so...
				foreach(player in level.players){
					player zombie_utility::set_zombie_var( "player_base_health", 75, false);
					player.maxhealth = 75;
					player.health = 75;
				}
				break;
			}
			case 3: //Regular
			{
				level.player_deathinvulnerabletime = 1700;
				level.healthoverlaycutoff = 0.2;
				level.invultime_preshield = 0.35;
				level.invultime_onshield = 0.5;
				level.invultime_postshield = 0.3;
				level.playerhealth_regularregendelay = 2400;
				
				//well, TF's Zombie Options set it to 75 so...
				foreach(player in level.players){
					player zombie_utility::set_zombie_var( "player_base_health", 75, false);
					player.maxhealth = 75;
					player.health = 75;
				}
				break;
			}
			//case 4: //Hardened
			/*{
				level.player_deathinvulnerabletime = 600;
				level.healthoverlaycutoff = 0.3;
				level.invultime_preshield = 0.1;
				level.invultime_onshield = 0.1;
				level.invultime_postshield = 0.1;
				level.playerhealth_regularregendelay = 1200;
				
				//well, TF's Zombie Options set it to 75 so...
				foreach(player in level.players){
					player zombie_utility::set_zombie_var( "player_base_health", 75, false);
					player.maxhealth = 75;
					player.health = 75;
				}
				break;
			}*/
			//case 5: //Veteran
			case 4: //Veteran
			{
				level.player_deathinvulnerabletime = 100;
				level.healthoverlaycutoff = 0.5;
				level.invultime_preshield = 0.0;
				level.invultime_onshield = 0.05;
				level.invultime_postshield = 0.0;
				level.playerhealth_regularregendelay = 1200;
				
				//well, TF's Zombie Options set it to 75 so...
				foreach(player in level.players){
					player zombie_utility::set_zombie_var( "player_base_health", 75, false);
					player.maxhealth = 75;
					player.health = 75;
				}
				break;
			}
		}
	//}
	
    //notify csc for client side scripts
    foreach(player in level.players){
        player util::clientNotify("choices_applied");
    }
	

   
}

function hide_bgb_machine(do_bgb_machine_leave)
{
	self thread zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
	self.hidden = 1;
	self.uses_at_current_location = 0;
	self.current_bgb_machine = 0;
	if(isdefined(do_bgb_machine_leave) && do_bgb_machine_leave)
	{
		self thread set_bgb_machine_state("leaving");
	}
	else
	{
		self thread set_bgb_machine_state("away");
	}
}

function set_bgb_machine_state(state)
{
	for(i = 0; i < self getnumzbarrierpieces(); i++)
	{
		self hidezbarrierpiece(i);
	}
	self notify("zbarrier_state_change");
	self [[level.bgb_machine_state_func]](state);
}

function fire_sale_disable()
{
	level waittill("fire_sale_on");
	self hide_bgb_machine();
	self fire_sale_disable();
}

function Sand() //I wonder why when decompiling from Cypress' Monkey Exterminiation Mod
{
	while(1)
	{
		level waittill("end_of_round");
		level.nextMonkeyStealRound = 0;
		level.next_monkey_round = 0;
	}
}

function hide_perk_random_machine()
{
	self thread zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
	self.uses_at_current_location = 0;
	self.current_bgb_machine = 0;
	self thread set_perk_random_machine_state("away");
}

function set_perk_random_machine_state(state)
{
	wait(0.1);
	for(i = 0; i < self getnumzbarrierpieces(); i++)
	{
		self hidezbarrierpiece(i);
	}
	self notify("zbarrier_state_change");
	self [[level.perk_random_machine_state_func]](state);
}

function hellhound_headshot_init()
{
	self.actor_damage_func = &hellhound_headshot_watcher;
}

function hellhound_headshot_watcher(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, poffsettime, boneindex)
{
	if(zm_utility::is_headshot(weapon, shitloc, meansofdeath))
		return(damage / 4);
	else
		return damage;
}

function private out_of_bounds_callback() {
    return false;
}