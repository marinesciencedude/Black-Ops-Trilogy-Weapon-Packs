#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;

#using scripts\zm\_zm;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;
#insert scripts\zm\_zm_mutators.gsh;

#namespace dive;

function autoexec __init__system__()
{
	system::register( "dive", &__init__, undefined, undefined );
}

#define VEL_MULTIPLIER 1.3 // forward lunge
#define N_DIVE_JUMP 25 // upward lunge
#define N_DIVE_FORCE 180 // fall strength
#define N_DIVE_FORCE_LOWGRAV 150 // lowgrav fall strength
#define GROUNDDIST_CHECK 400 // ground proximity to end dive
#define DIVE_COOLDOWN 1 // wait before can dive again
#define DEVPRINT 0

function __init__()
{
	callback::on_connect( &on_player_connect );
	if(GetGametypeSetting(mutator_slide_dive) == 1)
		zm::register_player_damage_callback(&divetoprone_falldamage);
}

function private divetoprone_falldamage(inflictor, attacker, damage, flags, mod, weapon, vpoint, vdir, sHitLoc, psOffsetTime, boneIndex, surfaceType) 
{
	gradient = 0.228506360820769; //find better value and actual damage function instead of graphing experimental bg_fallDamageMin/MaxHeight 128-300 (206: 17, 314: 42, 423: 66, 502: 66, 250: 28, 547: 96, 147: 3, 357: 52, 551: 96, 558: 97, 562: 98, 563: 98, 140: 2, 137: 1, 136: 1, ≤135 0, ≥564: DEAD)
	//y = mx - a; x = (y + a)/m; z = mx - b; z = m((y + a)/m) - b; z = y + a - b
	offset = (/*128*/131.385052707463-65) * gradient; 	//it should start at 128 but as mentioned in zm_ffotd.gsc only start getting damage at 136 so this is what LINEST produces
														//also good question as to whether 65-200 produces the same ramp-up as 128-300
	//also to-do: verify default BO III fall damage values to check gradient
	if(GetGametypeSetting(mutator_falldamage) == 1)
		return -1;
	
    if(IsPlayer(self) && mod == "MOD_FALLING" && self.divetoprone && !(self HasPerk("specialty_phdflopper")) )
        return int(damage + offset);

    return -1;
}

function on_player_connect()
{
    self.maxfps = GetDvarInt( "com_maxfps" );
    //self thread disable_slide();
	
	if(GetDvarInt("mutator_reload_cancel") == 2)
		self thread sprint_cancels_reload();
	
	if(GetDvarInt("mutator_sprint_cancel") == 2)
		self thread reload_cancels_sprint();
	
	if(GetGametypeSetting(mutator_slide_dive) == 1)
		self thread monitor_stance_response();
}

function fuckshit()
{
    self endon( "disconnect" );
    for(;;) {
        if( self StanceButtonPressed()) {
            wait .05;
            continue;
        }
        while( !self StanceButtonPressed())
            wait .05; // needs to be here
        wait .05; // wait an additional time to register a button press and release in this time
        if( !self StanceButtonPressed())
            wait .05; // wait before checking if button is pressed again
        else
            continue; // if button is pressed you failed
        if( self StanceButtonPressed()) {
            if( DEVPRINT )
                IPrintLnBold( "THIS IS NOT POSSIBLE" );
            self SetStance( "prone" );
        }
    } 
}

function disable_slide()
{
    self endon( "disconnect" );
    for(;;) {
        self AllowSlide(0);
        wait 3;
    }
}

function sprint_cancels_reload()
{
    self endon( "disconnect" );
    for(;;) {
        while( !self IsReloading())
            wait 1;
        while( self IsReloading()) {
            wait .05;
            if( self IsSprinting()) {
                if( DEVPRINT )
                    IPrintLnBold( "RELOAD CANCEL" );
                self cancel_reload();
            }
        }
    }
}

function cancel_reload()
{
    self endon( "disconnect" );
    weapons = self GetWeaponsListPrimaries();
    weapon = self GetCurrentWeapon();
    if( weapons.size == 1 ) {
        altweapon = self GetCurrentWeaponAltWeapon();
        if( altweapon.name != "none" ) {
            // self sys::Kill();
            return; // because im lazy. if someone wants to make this extremely rare case work go for it
        }
        clip = self GetWeaponAmmoClip( weapon );
        stock = self GetWeaponAmmoStock( weapon );
        self TakeWeapon( weapon );
        wait .05;
        self GiveWeapon( weapon );
        self SetWeaponAmmoClip( weapon, clip );
        self SetWeaponAmmoStock( weapon, stock );
        self SwitchToWeapon( weapon );
        self ShouldDoInitialWeaponRaise( weapon, 0 );
    }
    else {
        self SwitchToWeaponImmediate(); // this is switching to secondary to cancel reload
        wait .05;
        self SwitchToWeaponImmediate( weapon ); // switch back to the weapon you canceled reload on
    }
}

function reload_cancels_sprint()
{
    self endon( "disconnect" );
    for(;;) {
        while( !self IsSprinting())
            wait 1;
        while( self IsSprinting()) {
            wait .05;
            if( self IsReloading()) {
                if( DEVPRINT )
                    IPrintLnBold( "SPRINT CANCEL" );
                self cancel_sprint();
            }
        }
    }
}

function cancel_sprint()
{
    self AllowSprint(0);
    wait .05;
    self AllowSprint(1);
}

function monitor_stance_response()
{
    self endon( "disconnect" );
    for(;;) {
    	wait .05;
        while(!self StanceButtonPressed()) {
        	wait .05;
            continue;
        }
        if( !self IsSprinting()) {
        	if( DEVPRINT )
        		IPrintLnBold( "NOT SPRINTING" );
        	continue;
        }
        if( self GamepadUsedLast()) {
            wait .2;
            if(!self StanceButtonPressed()) {
            	if( DEVPRINT )
            		IPrintLnBold( "PRESS LONGER" );
                continue;
            }
        }
        /* "superdive" patch
        if( !self JumpButtonPressed())
            self dive();
        */
        if( DEVPRINT )
        	IPrintLnBold( "DIVE START" );
        self dive(); // Neo dive
    }
}

function dive()
{
    self endon( "disconnect" );
    self notify( "diving" );
    self endon( "diving" );
    SetDvar( "com_maxfps", 120 );
    force = self GetVelocity();
    forceX = force[0] * VEL_MULTIPLIER;
    forceY = force[1] * VEL_MULTIPLIER;
    self.divetoprone = 1;
    self SetOrigin( self.origin + ( 0, 0, N_DIVE_JUMP ) );
	startPos = self.origin[2];
    self SetVelocity( ( forceX, forceY, ( IS_TRUE( self.in_low_gravity ) ? N_DIVE_FORCE_LOWGRAV : N_DIVE_FORCE ) ) );
    self notify( "dive_begin" );
    for(;;) {
        wait .05;
        floor = GetClosestPointOnNavMesh( self.origin );
        if( isdefined( floor ) && DistanceSquared( floor, self.origin ) < GROUNDDIST_CHECK ) {
            if( DEVPRINT ) {
                IPrintLnBold( "DIVE STOP" );
            }
            break;
        }
    }
    self notify( "dive_end" );
    SetDvar( "com_maxfps", self.maxfps );
    self.divetoprone = 0;
	
	endPos = self.origin[2];
    heightDiff = startPos - endPos;
	if(GetGametypeSetting(mutator_falldamage) == 2 && heightDiff < GetDvarInt("bg_fallDamageMinHeight") && heightDiff >= 65)
		self DoDamage(int(0.228506360820769*(heightDiff - 65)), self.origin, undefined, undefined, undefined, "MOD_FALLING");
	
    if( DIVE_COOLDOWN )
        wait DIVE_COOLDOWN;
}