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

//#using scripts\zm\_zm_powerup_random_weapon;
#using scripts\shared\aat_shared;

#insert scripts\zm\_zm_perks.gsh;
#insert scripts\zm\_zm_utility.gsh;
#insert scripts\zm\_zm_mutators.gsh;




#namespace zm_mod;

function init() {
    //level.round_prestart_func = &do_pregame_menu;
    
	zm_utility::register_lethal_grenade_for_level( "sticky_grenade_custom" );
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
	
	/*case MUTATOR_OFFON_ON:
		{
			zm_utility::include_weapon( "t5_ak47", true );
			zm_utility::include_weapon( "t5_ak47_up_alt", false );
			zm_weapons::add_zombie_weapon( "t5_ak47", "t5_ak47_up_alt", "", 1300, "rifle", "", undefined, undefined, false, "" );
			
			break;
		}
	}

	switch(GetGametypeSetting(mutator_uzi))
	{
	case 2:
		{
			zm_utility::include_weapon( "t5_uzi", true );
			zm_utility::include_weapon( "t5_uzi_up", false );
			zm_weapons::add_zombie_weapon( "t5_uzi", "t5_uzi_up", "", 1500, "smg", "", undefined, undefined, false, "" );
			break;
		}
	}*/
	
	/*switch(GetGametypeSetting(mutator_scopeads))
	{
		case 1:
		{
			zm_utility::include_weapon( "t5_dragunov_overlay", true );
			zm_utility::include_weapon( "t5_dragunov_up_overlay", false );
			zm_weapons::add_zombie_weapon( "t5_dragunov_overlay", "t5_dragunov_up_overlay", "", 1750, "sniper", "", undefined, undefined, false, "" );
			level.zombie_weapons[GetWeapon("t5_dragunov")].is_in_box = false;
			zm_utility::include_weapon( "t5_dragunov", false);
			
			zm_utility::include_weapon( "t5_g11_overlay", true );
			zm_utility::include_weapon( "t5_g11_up_overlay", false );
			zm_weapons::add_zombie_weapon( "t5_g11_overlay", "t5_g11_up_overlay", "", 1700, "rifle", "", undefined, undefined, false, "" );
			level.zombie_weapons[GetWeapon("t5_g11")].is_in_box = false;
			zm_utility::include_weapon( "t5_g11", false);
			
			if(GetGametypeSetting(mutator_wa2000) == BOOLMUTATOR_OFFON_ON)
			{
				zm_utility::include_weapon( "t5_wa2000_overlay", true );
				zm_utility::include_weapon( "t5_wa2000_up_overlay", false );
				zm_weapons::add_zombie_weapon( "t5_wa2000_overlay", "t5_wa2000_up_overlay", "", 1600, "sniper", "", undefined, undefined, false, "" );
			}
			
			if(GetGametypeSetting(mutator_psg1) == BOOLMUTATOR_OFFON_ON)
			{
				zm_utility::include_weapon( "t5_psg1_overlay", true );
				zm_utility::include_weapon( "t5_psg1_up_overlay", false );
				zm_weapons::add_zombie_weapon( "t5_psg1_overlay", "t5_psg1_up_overlay", "", 2000, "sniper", "", undefined, undefined, false, "" );
			}
			
			break;
		}
		case 3:
		{
			zm_utility::include_weapon( "t5_dragunov_switch", true );
			zm_utility::include_weapon( "t5_dragunov_up_switch", false );
			zm_weapons::add_zombie_weapon( "t5_dragunov_switch", "t5_dragunov_up_switch", "", 1750, "sniper", "", undefined, undefined, false, "" );
			level.zombie_weapons[GetWeapon("t5_dragunov")].is_in_box = false;
			zm_utility::include_weapon( "t5_dragunov", false);
			
			zm_utility::include_weapon( "t5_g11_switch", true );
			zm_utility::include_weapon( "t5_g11_up_switch", false );
			zm_weapons::add_zombie_weapon( "t5_g11_switch", "t5_g11_up_switch", "", 1700, "rifle", "", undefined, undefined, false, "" );
			level.zombie_weapons[GetWeapon("t5_g11")].is_in_box = false;
			zm_utility::include_weapon( "t5_g11", false);
			
			if(GetGametypeSetting(mutator_wa2000) == MUTATOR_OFFON_ON)
			{
				zm_utility::include_weapon( "t5_wa2000_switch", true );
				zm_utility::include_weapon( "t5_wa2000_up_switch", false );
				zm_weapons::add_zombie_weapon( "t5_wa2000_switch", "t5_wa2000_up_switch", "", 1600, "sniper", "", undefined, undefined, false, "" );
			}
			
			if(GetGametypeSetting(mutator_psg1) == BOOLMUTATOR_OFFON_ON)
			{
				zm_utility::include_weapon( "t5_psg1_switch", true);
				zm_utility::include_weapon( "t5_psg1_up_switch", false);
				zm_weapons::add_zombie_weapon( "t5_psg1_switch", "t5_psg1_up_switch", "", 2000, "sniper", "", undefined, undefined, false, "" );
			}
			
			break;
		}
	}*/
	
	if(GetDvarString("mapname") == "zm_der_riese")
	{
		if(GetGametypeSetting(mutator_declassified_ppsh) == MUTATOR_OFFON_ON)
		{
			zm_utility::include_weapon( "smg_ppsh", true );
			zm_utility::include_weapon( "smg_ppsh_upgraded", false );
			zm_weapons::add_zombie_weapon( "smg_ppsh", "smg_ppsh_upgraded", "", 5000, "smg", "", undefined, undefined, false, "" );
		}
		
		if(GetGametypeSetting(mutator_declassified_mg42) == MUTATOR_OFFON_ON)
		{
			zm_utility::include_weapon( "s2_mg42", true );
			zm_utility::include_weapon( "s2_mg42_upgraded", false );
			zm_weapons::add_zombie_weapon( "s2_mg42", "s2_mg42_upgraded", "", 3000, "lmg", "", undefined, undefined, false, "" );
		}
	}
	
	if(GetGametypeSetting(mutator_double_packapunch_bo2) == 1 || GetGametypeSetting(mutator_double_packapunch_bo2) == 4)
	{
		keys = GetArrayKeys(level.zombie_weapons_upgraded);
		for ( i = 0; i < keys.size; i++ )
			aat::register_aat_exemption(keys[i]);
	}
	
	if(GetGametypeSetting(mutator_enable_gobblegum) == MUTATOR_OFFON_ON)
	{
		foreach(bgb_machine in level.bgb_machines)
		{
			bgb_machine thread hide_bgb_machine();
			bgb_machine thread fire_sale_disable();
		}
	}
	
	/*if(GetDvarInt("mutator_ray_gun") == 2)
	{
		level.zombie_weapons[GetWeapon("t4_ray_gun")].is_in_box = false;
		zm_utility::include_weapon( "t4_ray_gun", false);
		zm_utility::include_weapon( "ray_gun", true );
		zm_utility::include_weapon( "ray_gun_upgraded", false );
		zm_weapons::add_zombie_weapon( "ray_gun", "ray_gun_upgraded", "", 10000, "raygun", "", undefined, undefined, false, "" );
		aat::register_aat_exemption(getweapon("ray_gun_upgraded"));
	}*/
	
	if(level.pack_a_punch_camo_index == 141 && GetGametypeSetting(mutator_camo_ingame_cycle) != BOOLMUTATOR_OFFON_ON)
	{
		ArrayRemoveIndex(level.zombie_weapons_upgraded, GetWeapon("t4_ray_gun_camo_up"));
		level.zombie_weapons[GetWeapon("t4_ray_gun")].upgrade = GetWeapon("t4_ray_gun_up");
		aat::register_aat_exemption(getweapon("t4_ray_gun_up"));
	}
	
	if(GetDvarString("mapname") == "zm_giant")
	{
		zm_utility::include_weapon( "tesla_gun", true );
		level.zombie_weapons[GetWeapon("tesla_gun")].is_in_box = true;
	}
	
	/*level.weaponzmthundergun = getweapon("t5_thundergun");
	level.weaponzmthundergunupgraded = getweapon("t5_thundergun_upgraded");
	
	if(GetGametypeSetting(mutator_raygunmkii) == BOOLMUTATOR_ONOFF_OFF)
		level.zombie_weapons[GetWeapon("raygun_mark2")].is_in_box = false;
	else
	{
		if(isdefined(GetWeapon("raygun_mark2").worldmodel)) //stock maps
		{
			zm_utility::include_weapon( "raygun_mark2", true );
			zm_utility::include_weapon( "raygun_mark2_upgraded", false );
			zm_weapons::add_zombie_weapon( "raygun_mark2", "raygun_mark2_upgraded", "raygun", 10000, "", "", undefined, undefined, true, "" );
			zm_weapons::add_limited_weapon("raygun_mark2", 1);
			aat::register_aat_exemption(getweapon("raygun_mark2_upgraded"));
		}
		else
		{
			zm_utility::include_weapon( "raygun_mark_ii", true );
			zm_utility::include_weapon( "raygun_mark_ii_upgraded", false );
			zm_weapons::add_zombie_weapon( "raygun_mark_ii", "raygun_mark_ii_upgraded", "raygun", 10000, "", "", undefined, undefined, true, "" );
			zm_weapons::add_limited_weapon("raygun_mark_ii", 1);
			aat::register_aat_exemption(getweapon("raygun_mark_ii_upgraded"));
		}
	}
	
	if(GetGametypeSetting(mutator_ballistic_knife) == BOOLMUTATOR_ONOFF_OFF)
	{
		level.zombie_weapons[GetWeapon("t9_ballistic_knife")].is_in_box = false;
		zm_utility::include_weapon( "t9_ballistic_knife", false);
	}*/
	
	if(GetGametypeSetting(mutator_enable_wunderfizz) == 2)
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
		switch(GetGametypeSetting(mutator_health_difficulty))
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
	
	if(GetGametypeSetting(mutator_deathmachine) == BOOLMUTATOR_OFFON_OFF)
		zm_powerups::powerup_remove_from_regular_drops("minigun");
	
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