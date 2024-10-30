#using scripts\codescripts\struct;

#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#using scripts\zm\_zm_mod;
#using scripts\zm\_zm_mutators;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#using scripts\shared\laststand_shared;

#insert scripts\shared\shared.gsh;

#using scripts\zm\_zm_magicbox;

#precache("menu", "PauseGame");

#namespace clientids;

REGISTER_SYSTEM( "clientids", &__init__, undefined )
	
function __init__()
{
	zm_mod::init();
	callback::on_start_gametype( &init );
	callback::on_connect( &on_player_connect );
	callback::on_spawned( &on_player_spawned );
}	

function init()
{
	// this is now handled in code ( not lan )
	// see s_nextScriptClientId 
	level.clientid = 0;
	
	SetDvar("r_lodbiasrigid", "-1000");
	SetDvar("r_modellodbias", "10");
	SetDvar("r_dof_enable", "0");

	level.game_began = false;
}

function on_player_connect()
{
	self.clientid = matchRecordNewPlayer( self );
	if ( !isdefined( self.clientid ) || self.clientid == -1 )
	{
		self.clientid = level.clientid;
		level.clientid++;	// Is this safe? What if a server runs for a long time and many people join/leave
	}
	
	if(GetDvarInt("mutator_slide_dive") == 2)
		self thread disableSlide();
}

function disableSlide()
{
	self endon("disconnect");

	self AllowSlide(false);
	
	while(GetDvarString("mapname") == "zm_zod")
	{
		self waittill("player_exit_beastmode");
		while(self isthrowinggrenade() || self isgrappling() || (isdefined(self.teleporting) && self.teleporting))
		{
			wait(0.05);
		}
		self AllowSlide(false);
	}
	
	while(GetDvarString("mapname") == "zm_tomb")
	{
		self waittill("mud_slowdown_cleared");
		self AllowSlide(false);
	}
}

function on_player_spawned()
{

	if(!level.game_began) 
	{
    	if( self isHost() )
    	{
    		self thread zm_mod::load_tf_options();	
			
			self thread watch_for_pause();
    	}	
	}
	
	
}

function DebugFuncTest() {
    IPrintLn("PRINTING KEYS");
    

}

function CONTINUE_ROUND() {
	level endon("game_ended");
    level notify("continue_round");
}

function watch_for_pause()
{
    self endon("bled_out");
    self endon("disconnect");
    level endon("end_game");

    for(;;)
    {
        self waittill("menuresponse", menu, response);

        if(IsDefined(menu) && menu == "PauseGame")
        {

            level._is_paused = (!IsDefined(level._is_paused) ? 1 : !level._is_paused);
            level.bzm_worldPaused = level._is_paused;
            SetPauseWorld(level._is_paused);
            SetDvar("cl_paused", level._is_paused);
            SetDvar("sv_paused", level._is_paused);

            if(level flag::exists("world_is_paused"))
            {
                if(IS_TRUE(level._is_paused))
                {
                    level flag::set("world_is_paused");
                }
                else
                {
                    level flag::clear("world_is_paused");
                }
            }

            foreach(player in GetPlayers())
            {
                if(IsAlive(player) && player.sessionState == "playing")
                {
                    if(IS_TRUE(level._is_paused))
                    {
                        player EnableInvulnerability();

                        //player SetStance("stand");
                        //player AllowedStances("stand");
						stance = player GetStance();
                        player AllowedStances(stance);
                        player FreezeControlsAllowLook(level._is_paused);
                        player.frozen_position = util::spawn_model("tag_origin", player.origin, player.angles);
                        player PlayerLinkTo(player.frozen_position, "tag_origin", 0, 0, 0, 0, 0);
                        player SetBlur(10, 0.25);

                        if(player laststand::player_is_in_laststand())
                        {
                            player.actual_bleedout_time = player.bleedout_time;
                            player.bleedout_time = 99999;
                        }
                    }
                    else
                    {
                        player DisableInvulnerability();

                        if(IsDefined(player.frozen_position))
                        {
                            player.frozen_position Delete();
                        }

                        player FreezeControlsAllowLook(level._is_paused);
                        player AllowedStances("stand", "crouch", "prone");
                        player SetBlur(0, 0.25);
                        
                        if(player laststand::player_is_in_laststand())
                        {
                            player.bleedout_time = player.actual_bleedout_time;
                        }
                    }
                }
            }
        }
    }
}