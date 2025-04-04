#using scripts\codescripts\struct;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_clone;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\shared\callbacks_shared;

#using scripts\shared\ai\zombie_utility;
#using scripts\zm\_zm_spawner;
#using scripts\shared\ai\systems\gib;

#using scripts\shared\system_shared;

#insert scripts\zm\_zm_utility.gsh;
#insert scripts\shared\version.gsh;
#insert scripts\shared\shared.gsh;

REGISTER_SYSTEM_EX( "zm_weap_crossbow", &__init__, &__main__, undefined )

#precache("fx","carrabella/wpn_crossbow/impact_blink/crossbow_blink_2ms_green"); 
#precache("fx","carrabella/wpn_crossbow/impact_blink/crossbow_blink_2ms_red"); 
#precache("fx","carrabella/wpn_crossbow/exp/crossbow_impact_fx");

#namespace zm_weap_crossbow;

function __init__()
{
}

function __main__()
{
	callback::on_connect(&cross_bowfunctionality);
}

function cross_bowfunctionality()
{
	level.additional_check_to_crossbow = 0;
	while(1)
	{
		self waittill("missile_fire",projectile, weapon);
		//IPrintLnBold("weapon hit and its a crossbow"); //DoDamage (health, source position, attacker
		if(weapon.name == "t5_crossbow" || weapon.name == "t6_crossbow" /*|| weapon.name == "t9_crossbow"*/)
		{
			self thread crossbow_fired(projectile,weapon,0);
			projectile thread watch_for_inaccuracy(5,1);
		}
		if(weapon.name == "t5_crossbow_up" || weapon.name == "t6_crossbow_up" /*|| weapon.name == "t9_crossbow_up"*/)
		{
			self thread crossbow_fired(projectile,weapon,1);
			projectile thread watch_for_inaccuracy(5,1);
		}
		/*if(weapon.name == "sticky_grenade_custom")
			projectile thread detonate_while_upg(2,4,8,17,"carrabella/wpn_crossbow/impact_blink/crossbow_blink_2ms_green","semtex_beep");*/
		
	}
}

function crossbow_fired(projectile,weapon,upgraded)
{
	projectile endon("lost_in_thedark");
		i = 0;
		if(upgraded == 1 )
		{
			valid_poi = 1;
			PlayFXOnTag("karma_fx/weapon_fx/karma_cross_bow_base_trail_up",projectile,"tag_origin");
			if(valid_poi == 1)
			{
				projectile waittill("stationary");
				//IPrintLnBold("stationary");
				attract_dist_diff = 35;
	
				num_attractors = 96;
	
				max_attract_dist = 426;
				if(level.additional_check_to_crossbow == 0)
				{
				level.additional_check_to_crossbow = 1;
				attractor_model = util::spawn_model( "tag_origin", projectile.origin, projectile.angles );
				attractor_model thread watch_for_inaccuracy(7,0);
				attractor_model MoveZ(-75,0.1);
				attractor_model2 = util::spawn_model( "tag_origin", projectile.origin, projectile.angles );
				attractor_model2 thread watch_for_inaccuracy(7,0);
				attractor_model2 MoveZ(5,0.1);
				attractor_model3 = util::spawn_model( "tag_origin", projectile.origin, projectile.angles );
				attractor_model3 thread watch_for_inaccuracy(7,0);
				attractor_model3 MoveZ(-45,0.1);
				wait(0.2);
				level.additional_check_to_crossbow = 0;
				}
				
				attractor_model zm_utility::create_zombie_point_of_interest(max_attract_dist, num_attractors, 10000);
				attractor_model.attract_to_origin = 1;
				attractor_model thread zm_utility::create_zombie_point_of_interest_attractor_positions(4, attract_dist_diff);
				attractor_model2 zm_utility::create_zombie_point_of_interest(max_attract_dist, num_attractors, 10000);
				attractor_model2.attract_to_origin = 1;
				attractor_model2 thread zm_utility::create_zombie_point_of_interest_attractor_positions(4, attract_dist_diff);
				attractor_model3 zm_utility::create_zombie_point_of_interest(max_attract_dist, num_attractors, 10000);
				attractor_model3.attract_to_origin = 1;
				attractor_model3 thread zm_utility::create_zombie_point_of_interest_attractor_positions(4, attract_dist_diff);
				//attractor_model thread zm_utility::wait_for_attractor_positions_complete();

				time = 4.3;
				damage_firstrange = 2500;
				damage_secondrange = 225;
				close_range = 165;
				far_range = 95;
			}
				
		}
		else
		{
			PlayFXOnTag("karma_fx/weapon_fx/karma_cross_bow_base_trail",projectile,"tag_origin");
			time = 2.1;
			damage_firstrange = 400;
			damage_secondrange = 75;
			close_range = 130;
			far_range = 69;
			projectile waittill("stationary");
		}
		PlaySoundAtPosition("wpn_crossbow_impact",projectile.origin);
			if(upgraded == 1)
			{
				projectile thread detonate_while_upg(1,2,3,4,"carrabella/wpn_crossbow/impact_blink/crossbow_blink_2ms_red","wpn_crossbow_alert");
			}
			if(upgraded == 0)
			{
				projectile thread detonate_while_upg(1,2,3,4,"carrabella/wpn_crossbow/impact_blink/crossbow_blink_2ms_green","wpn_crossbow_alert");
			}
			wait(time);
			explosion_pos = projectile.origin;
			projectile notify("detonated");
			PlaySoundAtPosition("blackops_explode",explosion_pos);
			PlayFX("carrabella/wpn_crossbow/exp/crossbow_impact_fx",projectile.origin);
			zombs = getaispeciesarray("axis", "all");
			foreach(potential_target in zombs)
			{
				potential_target.gibbed_by_crossbow = 0;
				down_theline = Distance(potential_target.origin, projectile.origin); //500
				if(down_theline <= close_range)
				{
					potential_target DoDamage (damage_firstrange, projectile.origin, self);
					//potential_target thread gib_and_maim(self);
				}
				else if(down_theline <= far_range)
				{
					potential_target DoDamage (damage_secondrange, projectile.origin, self);
					//potential_target thread gib_and_maim(self); //re roll gib chance if close

				}
			}
			foreach(player in getPlayers())
			{

				player_distance = Distance(player.origin, projectile.origin);
				if(player_distance <= close_range)
				{
					player DoDamage (70, projectile.origin,player,"inflictor","none","MOD_EXPLOSIVE");
				}
				if(player_distance <= far_range)
				{
					player DoDamage (20, projectile.origin,player,"inflictor","none","MOD_EXPLOSIVE");
					player ShellShock("electrocution", 1.7);
				}
			}
			projectile Delete();
			if(isdefined(attractor_model))
			{
				attractor_model notify("arrow_detonated");
				attractor_model Delete();

			}
			if(isdefined(attractor_model2))
			{
				attractor_model2 notify("arrow_detonated");
				attractor_model2 Delete();

			}
			if(isdefined(attractor_model3))
			{
				attractor_model3 notify("arrow_detonated");
				attractor_model3 Delete();

			}
}

function watch_for_inaccuracy(wait_time,informplayer)
{
	self endon("stationary");
	self endon("arrow_detonated");
	wait(wait_time);
	self notify("lost_in_thedark");
	if(isdefined(self))
	{
		self Delete();
		//IPrintLnBold("projectile gone");
	}
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		if(isalive(players[i]) && informplayer == 1)
		{
			players[i] playlocalsound(level.zmb_laugh_alias);
		}
	}
}


function detonate_while_upg(frs_tm,snd_tm,trd_tm,frth_tm,fx_name,snd_name) //4,8,10,24
{
	self endon("detonated");

	ite = 0;
	time = 0.3;
	
	PlayFXOnTag(fx_name,self,"tag_fx");
	self PlaySound(snd_name);
	wait(0.2);
	while(1)
	{
		PlayFXOnTag(fx_name,self,"tag_fx");
		self PlaySound(snd_name);
		wait(time);
		ite++;
		
		//so all this ports over:
		/*
		realwait(interval);
		interval = (interval / 1.2);
		if (interval < .05)
		{
			interval = .05;
		}
		*/
		
		if(ite == frs_tm)
		{
			time = 0.25;
		}
		if(ite == snd_tm)
		{
			time = 0.2;
		}
		if(ite == trd_tm)
		{
			time = 0.1;
		}
		if(ite == frth_tm)
		{
			time = 0.05;
		}

	}
}


/*function gib_and_maim(attacker)
{
	if (IsAlive(self) && self.gibbed_by_crossbow == 0)  // Skip if the zombie is dead or already hit
    {
	chance = RandomIntRange(1,101);
	if(chance < 18)
	{
		self.gibbed_by_crossbow = 1;
		self zombie_utility::makezombiecrawler();
	}
	if(chance > 18 && chance < 28)
	{
		self.gibbed_by_crossbow = 1;
		gibserverutils::gibhead(self);
		wait(RandomFloatRange( 1.2,3.1 ));
		self DoDamage (self.health + 666, attacker.origin, attacker);
	}
	if(chance > 95 && chance < 101)
	{
		self DoDamage (650, attacker.origin, attacker);
	}
	
	}
}*/