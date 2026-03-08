#using scripts\zm\_zm_score;
#using scripts\shared\callbacks_shared;
#using scripts\codescripts\struct;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_utility;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#namespace zm_weap_bo1bouncingbetty;

REGISTER_SYSTEM_EX( "zm_weap_bo1bouncingbetty", &__init__, &__main__, undefined )

function __init__() {
	//nothing
}

function __main__()
{	
	/*
    triggers = GetEntArray("betty_trigger", "targetname");
    foreach (trigger in triggers) {
        trigger thread wallBuy();
    }
		*/
	level.waw_betties = GetWeapon("bo1_bouncingbetty");

	zm_equipment::register_for_level( "bo1_bouncingbetty" );

	zm_weapons::register_zombie_weapon_callback( level.waw_betties, &player_give_betty);

	callback::on_spawned( &watchBetties );
}

function player_give_betty( str_weapon = "bo1_bouncingbetty" )
{
	level endon( "game_ended" );

	//IPrintLnBold("Betties Purchased");

	self zm_utility::set_player_placeable_mine( level.waw_betties );
	self zm_equipment::set_player_equipment( level.waw_betties );
	self GiveWeapon(level.waw_betties);
	self SetActionSlot(4, "weapon", level.waw_betties);
	self SetWeaponAmmoStock(level.waw_betties, 2);

	self thread giveBettyEachRound();
}

/* function wallBuy() {
    level endon( "game_ended" );

	self.zombie_cost = 1500;	
	self SetHintString( "Hold ^3&&1^7 to buy Bouncing Betties [Cost: 1500] (One-time purchase only)" );	
	self SetCursorHint( "HINT_NOICON" );
	self.claymore_triggered = false;

	betty = struct::get("betty_struct", "targetname");
	betty2 = struct::get("betty_struct_2", "targetname");

	betty_model = GetEntArray("betty_wallbuy_model", "targetname");
	betty_model2 = GetEntArray("betty_wallbuy_model_2", "targetname");

	for( ;; ) {
		self waittill("trigger", player);

		if( player.score >= self.zombie_cost )
		{				
			if( !isdefined( player.has_claymores ) )
			{
				player.has_claymores = true;
				PlaySoundAtPosition( "purchase", self.origin );

				foreach (model in betty_model) {
					model MoveTo(betty.origin, 1);
				}

				foreach (model2 in betty_model2) {
					model2 MoveTo(betty2.origin, 1);
				}

				player zm_score::minus_to_player_score( self.zombie_cost );
				player giveBetty();

				if( self.claymore_triggered == false ) {
					self.claymore_triggered = true;
				}
				self SetInvisibleToPlayer(player, true);
			}
		}
		wait .05;
	}
}

function giveBetty()
{
	betty = GetWeapon("bo1_bouncingbetty");
	self GiveWeapon(betty);
	self SetActionSlot(4, "weapon", betty);
	self SetWeaponAmmoStock(betty, 2);

	self thread giveBettyEachRound();
} */

function giveBettyEachRound() {
	level endon("end_game");
	
	self endon("disconnect");

	for (;;) {
		level waittill( "start_of_round" );

		self SetWeaponAmmoStock(level.waw_betties, 2);
	}
}


function watchBetties()
{
	self endon( "disconnect" );

	level endon("end_game");
	
	for( ;; ) {
		self waittill( "grenade_fire", betty, weap );
		
		if( isdefined( weap ) && weap.name == "bo1_bouncingbetty" )
		{
			//IPrintLnBold("Watching Betties");
			betty.owner = self;
			betty thread handlePickupTrigger();
		}
	}
}

function deathWatch(trigger) {
	level endon("end_game");

	self waittill("death");

	trigger Delete();
}

function handlePickupTrigger() {
	level endon("end_game");

	self endon("death");

	self endon("betty_pickup");
	
	trigger = Spawn("trigger_radius_use", self.origin, 0, 32, 32);
	trigger SetCursorHint( "HINT_NOICON" );

	players = GetPlayers();
	foreach (player in players) {
		trigger SetInvisibleToPlayer( player );
	}

	trigger SetVisibleToPlayer( self.owner );
	trigger.owner = self.owner;
	trigger SetHintLowPriority(true);
	trigger TriggerIgnoreTeam();
	trigger SetTeamForTrigger("allies");

	self thread deathWatch(trigger);

	trigger SetHintString( "Hold ^3[{+activate}]^7 to pick up Betty" ); 
	
	trigger enablelinkto();
	trigger linkto( self );

	//IPrintLnBold("Created Pick Up Trigger");

	while (1) {
		trigger waittill( "trigger", player );
		if(player != self.owner)
			continue;
		else if(player == self.owner)
		{
			
			self pickup_betty();
			self notify("betty_pickup");
			
			continue;
		}
		
		wait(0.05);
	}
}

function pickup_betty()
{
	ammo = self.owner GetWeaponAmmoStock( level.waw_betties );
	if (ammo >= 2)
		return;
	else if(ammo < 2)
		new_ammo = self.owner GetWeaponAmmoStock( level.waw_betties ) + 1;
	else
		new_ammo = 2;
	self.owner  GiveWeapon(level.waw_betties);
	self.owner  SetActionSlot(4,"weapon",level.waw_betties);
	self.owner  SetWeaponAmmoClip(level.waw_betties,new_ammo);
	self Delete();
	//IPrintLnBold("Betty Picked Up");
}