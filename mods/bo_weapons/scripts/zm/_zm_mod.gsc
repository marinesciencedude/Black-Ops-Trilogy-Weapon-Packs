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
#using scripts\zm\_zm_counter;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_melee_weapon;
#using scripts\zm\zmSaveData;
#using scripts\zm\gametypes\_clientids;

#using scripts\zm\_zm_magicbox;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_blockers;

#using scripts\zm\_zm_powerup_random_weapon;
#using scripts\shared\aat_shared;

// NSZ Zombie Money Powerup
#using scripts\_NSZ\nsz_powerup_money;
//bottomless clip
#using scripts\_NSZ\nsz_powerup_bottomless_clip;
// NSZ Zombie Blood Powerup
#using scripts\_NSZ\nsz_powerup_zombie_blood;

//bo4 max ammo
#using scripts\zm\bo4_full_ammo;

//bo4 carpenter
//#using scripts\zm\bo4_carpenter;

//better nuke
#using scripts\zm\better_nuke;

//hit markers
#using scripts\zm\zm_damagefeedback;


//Custom Powerups By ZoekMeMaar
#using scripts\_ZoekMeMaar\custom_powerup_free_packapunch_with_time;

//timed gameplay
#using scripts\zm\ugxmods_timedgp;

#insert scripts\zm\_zm_perks.gsh;
#insert scripts\zm\_zm_utility.gsh;
#insert scripts\zm\_zm_mutators.gsh;




#namespace zm_mod;

function init() {
    if(GetDvarString("mapname") != "zm_coast") //breaks George A. Romero
		level.round_prestart_func = &do_pregame_menu;
    create_tf_options_defaults();
    create_options_keys_array();
    
	zm_utility::register_lethal_grenade_for_level( "sticky_grenade" );
	zm_weapons::add_retrievable_knife_init_name("t9_ballistic_knife");
	zm_weapons::add_retrievable_knife_init_name("t9_ballistic_knife_up");
}


function create_tf_options_defaults () {
	level.TFOptions = [];
    level.TFOptions["empty"] = 0; // need a temp one to stop bug
    level.TFOptions["max_ammo"] = 0; //1 - enabled, 0 - disabled
    level.TFOptions["higher_health"] = 100;  //1 - enabled, 0 - disabled
    level.TFOptions["no_perk_lim"] = 0;  //1 - enabled, 0 - disabled
    level.TFOptions["more_powerups"] = 2; //0 = none, 1 = less, 2 = default, 3 = more, 4 = insane
    level.TFOptions["bigger_mule"] = 0; //1 - enabled, 0 - disabled
    level.TFOptions["extra_cash"] = 0; //number of extra points per kill
    level.TFOptions["weaker_zombs"] = 0; //number of extra points per kill
	level.TFOptions["roamer_enabled"] = 0;  //1 - enabled, 0 - disabled
    level.TFOptions["roamer_time"] = 0;  //number of seconds to wait, 0 is infinite
    level.TFOptions["zcounter_enabled"] = 0;  //1 - enabled, 0 - disabled
    level.TFOptions["starting_round"] = 1; //number round to start on
    level.TFOptions["perkaholic"] = 0; //1 - enabled, 0 - disabled
    level.TFOptions["exo_movement"] = 0; //1 - enabled, 0 - disabled
    level.TFOptions["perk_powerup"] = 0; //1 - enabled, 0 - disabled
    level.TFOptions["melee_bonus"] = 0; //number of extra points per melee
    level.TFOptions["headshot_bonus"] = 0; //number of extra points per headshot
    level.TFOptions["zombs_always_sprint"] = 0; //1 - enabled, 0 - disabled
    level.TFOptions["max_zombies"] = 24; //1 - enabled, 0 - disabled
    level.TFOptions["no_delay"] = 0; //1 - enabled, 0 - disabled
    level.TFOptions["start_rk5"] = 0; //1 - enabled, 0 - disabled
    level.TFOptions["hitmarkers"] = 0; //1 - enabled, 0 - disabled
    level.TFOptions["zcash_powerup"] = 0; //1 - enabled, 0 - disabled
    level.TFOptions["starting_points"] = 500; //number of points to start with
    level.TFOptions["no_round_delay"] = 0; //1 - enabled, 0 - disabled
    level.TFOptions["bo4_max_ammo"] = 0; //1 - enabled, 0 - disabled
    level.TFOptions["better_nuke"] = 0; //1 - enabled, 0 - disabled
    level.TFOptions["better_nuke_points"] = 0; //how many points better nuke gives
    level.TFOptions["packapunch_powerup"] = 0; //1 - enabled, 0 - disabled
    level.TFOptions["spawn_with_quick_res"] = 0; //1 - enabled, 0 - disabled
    level.TFOptions["bo4_carpenter"] = 0; //1 - enabled, 0 - disabled
    level.TFOptions["bottomless_clip_powerup"] = 0; //1 - enabled, 0 - disabled
    level.TFOptions["zblood_powerup"] = 0; //1 - enabled, 0 - disabled
    level.TFOptions["timed_gameplay"] = 0; //1 - enabled, 0 - disabled
    level.TFOptions["move_speed"] = 1; //multiplier
    level.TFOptions["weap_mw2019"] = 0; //1 - enabled, 0 - disabled
    level.TFOptions["open_all_doors"] = 0; //1 - enabled, 0 - disabled
    level.TFOptions["every_box"] = 0; //1 - enabled, 0 - disabled
    level.TFOptions["random_weapon"] = 0; //1 - enabled, 0 - disabled
    level.TFOptions["start_bowie"] = 0; //1 - enabled, 0 - disabled
    level.TFOptions["start_power"] = 0; //1 - enabled, 0 - disabled

    
    

}



function create_options_keys_array() {
    level.TFKeys = GetArrayKeys(level.TFOptions);
	tempKeys = [];

	for(i = 0; i < level.TFKeys.size; i ++) {
		tempKeys[level.TFKeys.size - 1 - i] = level.TFKeys[i];
	}

	level.TFKeys = tempKeys;
}


function load_tf_options(){
    
    level endon("game_ended");
    level waittill("initial_blackscreen_passed");

    
	if(GetDvarString("mapname") != "zm_coast") //breaks George A. Romero
	{
		foreach(player in level.players) {
			player FreezeControls(true);
		}
	}

    IPrintLnBold("Loading TF Options! Please Wait...");

    for(i = 0; i < level.TFKeys.size; i++){
        if(level.TFKeys[i] != "starting_points") {
            
        
        } else { //special case for starting points as it needs 3 values to save
            

        }

        if(level.TFKeys[i] == "starting_points") {
            value = self zmSaveData::getSaveData(300);
		    level.TFOptions[level.TFKeys[i]] = value;
        } else if (level.TFKeys[i] == "move_speed") {
            value = self zmSaveData::getSaveDataFloat(i);
		    level.TFOptions[level.TFKeys[i]] = value;
        } else {
            value = self zmSaveData::getSaveData(i);
		    level.TFOptions[level.TFKeys[i]] = value;
        }
		
    }

    if(level.TFOptions["max_zombies"] == 0) {
        level.TFOptions["max_zombies"] = 24;
    }

    if(level.TFOptions["starting_round"] == 0) {
        level.TFOptions["starting_round"] = 1;
    }

    if(level.TFOptions["better_nuke_points"] == 0) {
        level.TFOptions["better_nuke_points"] = 100;
        
    }
    
    
    apply_choices();
    IPrintLnBold("Options Loaded!");

    foreach(player in level.players) {
            player playsound ( "zmb_cha_ching" );
    }


    if(GetDvarString("mapname") != "zm_coast") //breaks George A. Romero
	{
		foreach(player in level.players) {
			player FreezeControls(false);
		}
		level.game_began = true;
	}
    level notify("menu_closed");
    
}

function do_pregame_menu() {
    level waittill("menu_closed");
	wait 2;
}

function DebugPrint () {
    level endon("game_ended");
    while(1) {
        IPrintLn(level.zombie_ai_limit);
        wait 1;
    }
    
}




function apply_choices() {

    
    //for upgrade powerup
    level.temp_upgraded_time = 30;

    //move speed
    if(level.TFOptions["move_speed"] != 1) {
        foreach(player in level.players) {
            player SetMoveSpeedScale(level.TFOptions["move_speed"]);
        }
    }
    

    
    
    //starting points

    foreach(player in level.players){
        player zm_score::add_to_player_score(level.TFOptions["starting_points"] - 500, false);
        //player zm_score::add_to_player_score(100000, false);
        //level.player_starting_points = level.TFOptions["starting_points"];
        
    }

    //max ammo
    if(level.TFOptions["max_ammo"] == 1) {
        foreach(player in level.players) {
            player GiveMaxAmmo(level.start_weapon);
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
	
	//higher health
    foreach(player in level.players){
        player zombie_utility::set_zombie_var( "player_base_health", level.TFOptions["higher_health"], false);
        player.maxhealth = level.TFOptions["higher_health"];
        player.health = level.TFOptions["higher_health"]; 
    }  
     

    //no perk limit
    if(level.TFOptions["no_perk_lim"] == 1) {
        level.perk_purchase_limit = 14;
    } else {
        level.perk_purchase_limit = 4;
    }

    //more powerups
    increment = 0;
    maxdrop = 0;
    switch(level.TFOptions["more_powerups"]) {
        case 0:
        increment = 20000;
        maxdrop = 0;
        break;
        case 1:
        increment = 3000;
        maxdrop = 2;
        break;
        case 2:
        increment = 2000;
        maxdrop = 4;
        break;
        case 3:
        increment = 1700;
        maxdrop = 8;
        break;
        case 4:
        increment = 1000;
        maxdrop = 50;
        break;
        case 5:
        increment = 1;
        maxdrop = 500;

    }
    player zombie_utility::set_zombie_var( "zombie_powerup_drop_increment", increment);
    player zombie_utility::set_zombie_var("zombie_powerup_drop_max_per_round", maxdrop);
    
    //bigger mulekick (4gun)
    if(level.TFOptions["bigger_mule"] == 1) {
        level.additionalprimaryweapon_limit = 4;
    } else {
       level.additionalprimaryweapon_limit = 3; 
    }

    //extra cash
    if(level.TFOptions["extra_cash"] != 0) {
        zombie_utility::set_zombie_var( "zombie_score_kill_4player", 		50 + level.TFOptions["extra_cash"] );		
	    zombie_utility::set_zombie_var( "zombie_score_kill_3player",		50 + level.TFOptions["extra_cash"] );		
	    zombie_utility::set_zombie_var( "zombie_score_kill_2player",		50 + level.TFOptions["extra_cash"] );		
	    zombie_utility::set_zombie_var( "zombie_score_kill_1player",		50 + level.TFOptions["extra_cash"] );	
    } else {
        zombie_utility::set_zombie_var( "zombie_score_kill_4player", 		50);		
	    zombie_utility::set_zombie_var( "zombie_score_kill_3player",		50);		
	    zombie_utility::set_zombie_var( "zombie_score_kill_2player",		50);		
	    zombie_utility::set_zombie_var( "zombie_score_kill_1player",		50);
    }

    //weaker zombs
    if(level.TFOptions["weaker_zombs"] == 1) {
        zombie_utility::set_zombie_var( "zombie_health_increase_multiplier", 0.075);
    } else {
        zombie_utility::set_zombie_var( "zombie_health_increase_multiplier", 0.1);
    }

    //zombs always sprint
    if(level.TFOptions["zombs_always_sprint"] == 1) {
        zombie_utility::set_zombie_var( "zombie_move_speed_multiplier", 	  75,	false );
	    level.zombie_move_speed			= 1090;
        level thread sprintSetter() ;
    }

    //starting round
    if(level.TFOptions["starting_round"] == 0) {
        zm::set_round_number(1);
    } else {
        zm::set_round_number(level.TFOptions["starting_round"]);
        level.zombie_move_speed	= level.TFOptions["starting_round"] * level.zombie_vars["zombie_move_speed_multiplier"]; 
    }
    
    //perkaholic
    if(level.TFOptions["perkaholic"] == 1) {
        foreach(player in level.players) {
            player thread zm_utility::give_player_all_perks();
        }
    }

    // exo movement
    if(level.TFOptions["exo_movement"] == 1) {
        foreach(player in level.players) {
            SetDvar( "doublejump_enabled", 1 );
            SetDvar( "juke_enabled", 1 );
            SetDvar( "playerEnergy_enabled", 1 );
            SetDvar( "wallrun_enabled", 1 );
            SetDvar( "sprintLeap_enabled", 1 );
            SetDvar( "traverse_mode", 1 );
            SetDvar( "weaponrest_enabled", 1 );
        }
    }

    //free perk
    if(level.TFOptions["perk_powerup"] == 1) {
        level.zombie_powerups["free_perk"].func_should_drop_with_regular_powerups = &zm_powerups::func_should_always_drop;
    }

    //melee + headshot bonus
    zombie_utility::set_zombie_var( "zombie_score_bonus_melee", (80 + level.TFOptions["melee_bonus"]) );
    zombie_utility::set_zombie_var( "zombie_score_bonus_head", (50 + level.TFOptions["headshot_bonus"]) );

    //max zombie count 
    level.zombie_ai_limit = level.TFOptions["max_zombies"];
    level.zombie_actor_limit = level.TFOptions["max_zombies"] + 7;


    //no spawn delay
    if(level.TFOptions["no_delay"] == 1) {
        zombie_utility::set_zombie_var( "zombie_spawn_delay", 0,	true);
    }

    //start rk5
    if(level.TFOptions["start_rk5"]) {
        foreach(player in level.players) {
            player zm_weapons::weapon_give( level.super_ee_weapon, false, false, true );
        }
    }

    //zombie cash powerup
    if(level.TFOptions["zcash_powerup"] == 1) {
        nsz_powerup_money::init_zcash_powerup();
    }


    //hitmarkers
    if(level.TFOptions["hitmarkers"] == 1) {
        zm_damagefeedback::init_hitmarkers();
    }

    //no round delay
    if(level.TFOptions["no_round_delay"] == 1) {
        zombie_utility::set_zombie_var( "zombie_between_round_time", 0);
    }
    

    //bo4 max ammo
    if(level.TFOptions["bo4_max_ammo"] == 1) {
        level._custom_powerups[ "full_ammo" ].grab_powerup = &bo4_full_ammo::grab_full_ammo;
    }
    //bo4 carpenter
    if(level.TFOptions["bo4_carpenter"] == 1) {
        //level thread bo4_carpenter::carpenter_upgrade();
    }

    if(level.TFOptions["better_nuke"] == 1) {
        level._custom_powerups[ "nuke" ].grab_powerup = &better_nuke::grab_nuke;
    }

    //packapunch powerup
    if(level.TFOptions["packapunch_powerup"] == 1) {
        custom_powerup_free_packapunch_with_time::init_packapunch_powerup();
    }

    //spawn with quick res
    if(level.TFOptions["spawn_with_quick_res"] == 1) {
        foreach(player in level.players) {
            player zm_perks::give_perk("specialty_quickrevive");
        }
    }


    //bottomless clip
    if(level.TFOptions["bottomless_clip_powerup"] == 1) {
        nsz_powerup_bottomless_clip::init_bottomless_clip();
    }
    //zombie blood
    if(level.TFOptions["zblood_powerup"] == 1) {
        nsz_powerup_zombie_blood::init_zblood();
    }

    //ROAMER MOD
    if(level.TFOptions["roamer_enabled"] == 1){
        createRoamerHud();
        level.round_end_custom_logic = &roamer;
        zombie_utility::set_zombie_var( "zombie_between_round_time", 0);
    } else {

        level.round_end_custom_logic = undefined;
    }

    //ZOMBIE COUNTER
    if(level.TFOptions["zcounter_enabled"] == 1) {
        zm_counter::_INIT_ZCOUNTER();
    }

    //Timed Gameplay
    if(level.TFOptions["timed_gameplay"] == 1) {
        ugxmods_timedgp::timed_gameplay();
    }

    //MW2019 Weapons
    //level clientfield::set("mw2019weaps", level.TFOptions["weap_mw2019"]); 
    //if(level.TFOptions["weap_mw2019"]) {
        //zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_custom_weapons.csv", 1);
    //}

    //open all doors on start
    if(level.TFOptions["open_all_doors"]) {
        open_all_doors();
    }
    
    //spawn every mystery box
    if(level.TFOptions["every_box"]) {
        level thread every_box();
    }
    
    //give random starting weapon
    if(level.TFOptions["random_weapon"]) {
        give_random_weapon();
    }

    //start with bowie knife
    if(level.TFOptions["start_bowie"]) {
        give_bowie_knife();
    }

    //start with the power on
    if(level.TFOptions["start_power"]) {
        start_with_power();
    }
	
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

function open_all_doors() {
    //open all doors test 
    types = array("zombie_door", "zombie_airlock_buy");
    foreach(type in types)
    {
        zombie_doors = GetEntArray(type, "targetname");
        for(i=0;i<zombie_doors.size;i++)
        {
                if(zombie_doors[i]._door_open == 0)
                zombie_doors[i] thread set_doors_open();
        } 
    }
    //remove death barrier 
    level.player_out_of_playable_area_monitor_callback = &out_of_bounds_callback;

    open_all_debris();
}

function private out_of_bounds_callback() {
    return false;
}

function set_doors_open()
{
    while(isdefined(self.door_is_moving) && self.door_is_moving)
        wait .1;

    self zm_blockers::door_opened(0);
}

function open_all_debris()
{
    if(isDefined(level.OpenAllDebris))
        return;

    level.OpenAllDebris = true;
    zombie_debris = GetEntArray("zombie_debris", "targetname");
    foreach(debris in zombie_debris)
    {
        debris.zombie_cost = 0;
        debris notify("trigger", self, true);
    }
}


function every_box() {

    
    array::thread_all(level.chests, &show_mystery_box);
    array::thread_all(level.chests, &enable_chest);
    array::thread_all(level.chests, &fire_sale_box_fix);

    if(GetDvarString("magic_chest_movable") == "1")
        setDvar("magic_chest_movable", "0");
}
    
function fire_sale_box_fix()
{
    level endon("game_ended");
    while(true)
    {
        wait .1;
        level waittill("fire_sale_off");
        self.was_temp = undefined;
    }
}

function enable_chest()
{
    level endon("game_ended");
    while(true) 
    {
        wait .1;
        self.zbarrier waittill("closed");
        thread zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, &zm_magicbox::magicbox_unitrigger_think);
    }
}

function get_chest_index()
{
    
    foreach(index, chest in level.chests)
    {
        if(self == chest)
            return index;
    }
    return undefined;
}

function show_mystery_box()
{
    level endon("game_ended");
    if(self zm_magicbox::is_chest_active() || self get_chest_index() == level.chest_index)
        return;
        
    self thread zm_magicbox::show_chest(); 
}

function give_random_weapon() {
    //get list of weapons
    keys = GetArrayKeys( level.zombie_weapons );
    foreach(player in level.players) {
        player zm_weapons::weapon_take(level.start_weapon);
        new_weap = array::random(keys);
        while(new_weap.name == "bowie_knife" || new_weap.name == "bouncingbetty" || new_weap.name == "cymbal_monkey" || new_weap.name == "frag_grenade" || new_weap.name == "knife" || new_weap.name == "hero_gravityspikes_melee" || new_weap.name =="octobomb") {
            wait .1;
            new_weap = array::random(keys);
        }
        player zm_weapons::weapon_give( new_weap );
        
    }

}

function give_bowie_knife () {
    foreach( player in level.players ) {
        player zm_weapons::weapon_give( GetWeapon( "bowie_knife" ) );
    }
}

function start_with_power (size = 0) {
    if(level flag::get("power_on"))
        return;

    Arrays = array("use_elec_switch", "zombie_vending", "zombie_door");
    presets = array("elec", "power", "master");

    for(e=0;e<3;e++)
        size += Arrays[e].size;
    for(e=0;e<size;e++)
        level flag::set("power_on" + e);
        
    foreach(preset in presets)
    {
        trig = getEnt("use_" + preset + "_switch", "targetname");
        if(isDefined(trig))
        {
            trig notify("trigger", self);
            break;
        }
    }
    level flag::set("power_on");
    //remove death barrier 
    level.player_out_of_playable_area_monitor_callback = &out_of_bounds_callback;
}




function sprintSetter () {
    level endon("game_ended");    
    while(1) {
        wait .1;
        zombie_utility::set_zombie_var( "zombie_move_speed_multiplier", 	  75,	false );
	    level.zombie_move_speed			= 1090;
        level waittill( "between_round_over" );
    }
}


function roamer() {

    if(level.TFOptions["roamer_time"] != 0) {
        level thread roamer_wait_time();
    }

    level.TFOptions["roamer_hud"]  thread hudRGBA((1,1,1), 1.0, 1.5); 

    level waittill("continue_round");
    
    level.TFOptions["roamer_hud"]  thread hudRGBA((1,1,1), 0, 1.5);
    level.TFOptions["roamer_counter"]  thread hudRGBA((1,1,1), 0, 1.5); 
    
}

function roamer_wait_time () {
    self endon("continue_round");
    oldRound = level.round_number;
    
    timeLeft = level.TFOptions["roamer_time"];
    level.TFOptions["roamer_counter"]  thread hudRGBA((1,1,1), 1.0, 1.5); 
    level.TFOptions["roamer_counter"] SetValue(timeLeft);
    while(timeLeft > 0) {
        wait 1;
        timeLeft --;
        level.TFOptions["roamer_counter"] SetValue(timeLeft);
    }
    level notify("continue_round");
        
}


//HUD STUFF
function createRoamerHud(){
    level.TFOptions["roamer_hud"] = createNewHudElement("right", "top", -5, 5, 1, 1);
	level.TFOptions["roamer_hud"]  hudRGBA((1,1,1), 0);
	level.TFOptions["roamer_hud"]  SetText("Press ADS + Melee To Start Next Round"); 
    level.TFOptions["roamer_counter"] = createNewHudElement("right", "top", -5, 15, 1, 1);
    level.TFOptions["roamer_counter"]  hudRGBA((1,1,1), 0);
    level.TFOptions["roamer_counter"]  SetValue(0); 
	

}

function createNewHudElement(xAlign, yAlign, posX, posY, foreground, fontScale)
{
	hud = newHudElem();
	hud.horzAlign = xAlign; hud.alignX = xAlign;
	hud.vertAlign = yAlign; hug.alignY = yAlign;
	hud.x = posX; hud.y = posY;
	hud.foreground = foreground;
	hud.fontscale = fontScale;
	return hud;
}

function hudRGBA(newColor, newAlpha, fadeTime)
{
	if(isDefined(fadeTime))
		self FadeOverTime(fadeTime);

	self.color = newColor;
	self.alpha = newAlpha;
}