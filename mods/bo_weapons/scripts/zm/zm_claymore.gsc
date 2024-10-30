#using scripts\zm\_zm_score;
#using scripts\shared\callbacks_shared;
#using scripts\shared\hud_util_shared;
#using scripts\zm\_zm_weapons;

#precache( "material", "claymore_hud" );
#precache( "material", "claymore_hud_inactive" );
#precache( "fx", "custom/weapon/fx_claymore_laser" );
#precache( "fx", "explosions/fx_exp_grenade_default" );

/* |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
Zombie Claymores
Scripter: JBird632
|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| */

function init()
{	
	level._effect["claymore_laser"] = "custom/weapon/fx_claymore_laser";
	level._effect["explosion"] = "explosions/fx_exp_grenade_default";
	claymoreDetectionConeAngle = 70;
	level.claymoreDetectionDot = cos( claymoreDetectionConeAngle );
	level.claymoreDetectionMinDist = 20;
	level.claymoreDetectionGracePeriod = .75;
	thread purchaseClaymores();
	callback::on_spawned( &claymoreSetup );
}

function purchaseClaymores()
{
	trigger = GetEnt("claymore_trigger", "targetname");
	trigger.zombie_cost = 1000;	
	trigger SetHintString( "Hold ^3&&1^7 to buy Claymores [Cost: 1000]" );	
	trigger SetCursorHint( "HINT_NOICON" );
	trigger.claymore_triggered = false;
	
	thread give_claymores_after_rounds();

	while(1)
	{
		trigger waittill("trigger_activated", player);

		if( player.score >= trigger.zombie_cost )
		{				
			if(!isDefined(player.has_claymores))
			{
				player.has_claymores = true;
				PlaySoundAtPosition( "zmb_cha_ching", trigger.origin );
				player zm_score::minus_to_player_score( trigger.zombie_cost );
				player giveClaymores();

				if( trigger.claymore_triggered == false )
				{
					model = getent( trigger.target, "targetname" );
					/*if ( isdefined( model ) )
					{
						model UseWeaponModel( GetWeapon("claymore") );
						model hide(); 
					} 
					model thread zm_weapons::weapon_show( player );*/
					trigger.claymore_triggered = true;
				}

				trigger SetInvisibleToPlayer(player, true);
			}
		}
		
		wait(0.05);
	}
}

function give_claymores_after_rounds()
{
	while(1)
	{
		level waittill( "between_round_over" );
		players = GetPlayers();
		
		for(i=0;i<players.size;i++)
		{
			if(isDefined(players[i].has_claymores) && players[i].has_claymores)
			{
				claymore = GetWeapon("claymore");
				ammo = players[i] GetWeaponAmmoStock( claymore );
				
				if(ammo < 2)
				{
					players[i]  giveweapon(claymore);
					players[i]  setactionslot(4,"weapon",claymore);
					players[i]  setweaponammoclip(claymore,2);
				}
			}
		}
		
		wait(0.05);
	}
}

function giveClaymores()
{
	claymore = getWeapon("claymore");
	self giveweapon(claymore);
	self setactionslot(4, "weapon", claymore);
	self setweaponammostock(claymore, 2);
	self thread claymore_death_think();

	// Hud
	self.claymoreHud = self hud::createServerIcon( "claymore_hud", 18, 18 );
	self.claymoreHud.horzAlign = "right";
	self.claymoreHud.vertAlign = "bottom";
	self.claymoreHud.x = -36;
	self.claymoreHud.y = -73;
	self.claymoreHud.foreground = true;
	self.claymoreHud.alpha = 1;

	self thread manageClaymoreHud();

	self waittill("death");
	self.claymoreHud hud::destroyElem();
	self.claymoreHud = undefined;
}

function manageClaymoreHud()
{
	self endon("death");

	while(1)
	{
		claymore = GetWeapon("claymore");
		ammo = self GetWeaponAmmoStock( claymore );

		if(ammo <= 0)
			self.claymoreHud SetShader("claymore_hud_inactive", 18, 18);
		else
			self.claymoreHud SetShader("claymore_hud", 18, 18);

		wait(0.1);
	}
}

function claymore_death_think(claymore)
{
	self waittill("death");

	self.has_claymores = false;
	claymore delete_claymore();
}

function claymoreSetup()
{
	players = GetPlayers();
	
	for(i=0;i<players.size;i++)
		players[i] thread watchClaymores();
}

function watchClaymores()
{
	self endon("disconnect");
	
	while(1)
	{
		self waittill( "grenade_fire", claymore, weap );
		
		if(isDefined(weap) && weap.name == "claymore")
		{
			self addClaymoreArray( claymore );
			
			claymore.angles = self.angles;
			claymore.owner = self;
			claymore thread claymoreDetonation();
			claymore thread playClaymoreEffects();
			self thread claymore_death_think(claymore);
		}
	}
}

function claymoreDetonation()
{
	self endon("claymore_pickup");
	
	self playsound("claymore_plant");
	
	wait(1.1);
	
	detonateRadius = 96;
	
	trigger = spawn("trigger_radius", self.origin + (0,0,0-detonateRadius), 9, detonateRadius, detonateRadius*2);
	trigger SetCursorHint( "HINT_NOICON" );
	trigger setvisibletoplayer( self.owner );
	trigger.owner = self.owner;
	trigger sethintstring( "Hold ^3&&1^7 to pick up Claymore" );
	
	trigger enablelinkto();
	trigger linkto( self );
			
	while(1)
	{
		trigger waittill( "trigger", player );
		if(player shouldAffectClaymore( self ) && player != self.owner)
			break;
		else if(player == self.owner)
		{
			trigger delete();
			self pickup_claymores();
			self notify("claymore_pickup");
		}
		wait(0.05);
	}
	
	self notify("claymore_detonate");
	self playsound("claymore_alert");
	wait(0.25);	
	playfx(level._effect["explosion"], self.origin);
	fake_model = spawn("script_model",self.origin);
	fake_model setmodel(self.model);
	self hide();
	tag_origin = spawn("script_model",self.origin);
	tag_origin setmodel("tag_origin");
	tag_origin linkto(fake_model);
	self playsound("claymore_explode");
	earthquake(1, .4, fake_model.origin, 512);
	zombs = getaispeciesarray("axis");
	
	for(i=0;i<zombs.size;i++)
	{
		if(!zombs[i] shouldAffectClaymore( self ))
			continue;
			
		if(zombs[i].origin[2] < fake_model.origin[2] + 80 && zombs[i].origin[2] > fake_model.origin[2] - 80 && DistanceSquared(zombs[i].origin, fake_model.origin) < 200 * 200)
		{
			zombs[i] doDamage(zombs[i].health + 666, self.origin);
			self.owner zm_score::add_to_player_score(60);
			self.owner.kills++;
		}
	}
	
	trigger delete();
	fake_model delete();
	tag_origin delete();
		
	if( isdefined( self ) )
		self delete();
}

function shouldAffectClaymore( claymore )
{
	pos = self.origin + (0,0,32);
	
	dirToPos = pos - claymore.origin;
	claymoreForward = anglesToForward( claymore.angles );
	
	dist = vectorDot( dirToPos, claymoreForward );
	if ( dist < level.claymoreDetectionMinDist )
		return false;
	
	dirToPos = vectornormalize( dirToPos );
	
	dot = vectorDot( dirToPos, claymoreForward );
	return ( dot > level.claymoreDetectionDot );
}

function pickup_claymores()
{
	self endon("death");

	claymore = GetWeapon("claymore");
	ammo = self.owner GetWeaponAmmoStock( claymore );
	if(ammo < 2)
		new_ammo = self.owner GetWeaponAmmoStock( claymore ) + 1;
	else
		new_ammo = 2;
	self.owner  giveweapon(claymore);
	self.owner  setactionslot(4,"weapon",claymore);
	self.owner  setweaponammoclip(claymore,new_ammo);
	self Delete();
}

function playClaymoreEffects()
{
	fx = spawn("script_model", self.origin - (0,0,50));
	fx.angles = self.angles;
	fx setmodel("tag_origin");
	
	playfxontag(level._effect["claymore_laser"], fx, "tag_origin");
	
	while(isDefined(self))
		wait(0.05);
	
	fx delete();
}

function addClaymoreArray( claymore )
{
	if( !isDefined(self.claymoreArray) )
		self.claymoreArray = [];
	
	if( self.claymoreArray.size >= 10 )
	{
		newArray = [];
		explodingClaymore = self.claymoreArray[0];
		
		for( i = 1; i < self.claymoreArray.size; i++ )
		{
			index = newArray.size;
			newArray[index] = self.claymoreArray[i];
			newArray[index].index = index;
		}
			
		explodingClaymore thread earlyExplode();
		self.claymoreArray = newArray;
	}
	
	index = self.claymoreArray.size;
	self.claymoreArray[index] = claymore;
	self.claymoreArray[index].index = index;
}

function removeClaymoreArray( claymore )
{
	newArray = [];
	skipIndex = claymore.index;
	
	for( i = 0; i < self.claymoreArray.size; i++ )
	{
		if( i == skipIndex )
			continue;
			
		index = newArray.size;
		newArray[index] = self.claymoreArray[i];
		newArray[index].index = index;
	}
	
	self.claymoreArray = newArray;
	
	claymore thread delete_claymore();
}

function earlyExplode()
{
	self notify("early_explode");
	self notify("claymore_detonate");
	
	self playsound("claymore_alert");
	wait(0.1);
	playfx(level._effect["explosion"], self.origin);
	earthquake(1, .4, self.origin, 512);
	zombs = getaispeciesarray("axis");
	
	for(i=0;i<zombs.size;i++)
	{
		if(!zombs[i] shouldAffectClaymore( self ))
			continue;
		if(zombs[i].origin[2] < self.origin[2] + 80 && zombs[i].origin[2] > self.origin[2] - 80 && DistanceSquared(zombs[i].origin, self.origin) < 200 * 200)
		{
			zombs[i] doDamage(zombs[i].health + 666, self.origin);
			self.owner zm_score::add_to_player_score(60);
			self.owner.kills++;
		}
	}
	
	//Setup for spikemore plug hole easter egg step
	if(GetDvarString("mapname") == "zm_temple")
	{
		ents = GetEntArray("trigger_damage", "targetname");
		for(i = 0; ents.size; i++)
		{
			if(DistanceSquared(ents[i].origin, self.origin) < 200 * 200)
				ents[i] notify("spiked", self.owner);
				//ents[i] doDamage(666, self.origin, self.owner, self, "MOD_EXPLOSIVE", undefined, getweapon("claymore"));
		}
	}
	
	playsoundatposition("claymore_explode", self.origin);
	self thread delete_claymore();
}

function delete_claymore()
{
	self notify("deleted");
	
	if(isdefined(self.trigger))
		self.trigger delete();
	if(isdefined(self))
		self delete();
}