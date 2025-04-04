/*#========================================###
###                                                                   							  ###
###                                                                   							  ###
###           			Harry Bo21s Black Ops 3 Magmagat					  ###
###                                                                   							  ###
###                                                                   							  ###
###========================================#*/
/*============================================

								CREDITS

=============================================
Raptroes
Hubashuba
WillJones1989
alexbgt
NoobForLunch
Symbo
TheIronicTruth
JAMAKINBACONMAN
Sethnorris
Yen466
Lilrifa
Easyskanka
Erthrock
Will Luffey
ProRevenge
DTZxPorter
Zeroy
JBird632
StevieWonder87
BluntStuffy
RedSpace200
Frost Iceforge
thezombieproject
Smasher248
JiffyNoodles
MadGaz
MZSlayer
AndyWhelen
Collie
ProGamerzFTW
Scobalula
Azsry
GerardS0406
PCModder
IperBreach
TomBMX
Treyarch and Activision
AllModz
TheSkyeLord
===========================================*/
#using scripts\codescripts\struct;
#using scripts\shared\_burnplayer;
#using scripts\shared\array_shared;
#using scripts\shared\system_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\animation_shared;
#using scripts\shared\util_shared;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai\systems\gib;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_utility;
#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#namespace crossbow_bolt; 

REGISTER_SYSTEM_EX( "crossbow_bolt", &__init__, &__main__, undefined )

// ============================== INITIALIZE ==============================

/* 
INITIALIZE 
Description : This function starts the script and will setup everything required
Notes : None  
*/
function __init__()
{		
	// # CLIENTFIELD REGISTRATION
	clientfield::register( "missile", "blundersplat_missile", VERSION_SHIP, 1, "int" );
	// # CLIENTFIELD REGISTRATION
}

/* 
MAIN 
Description : This function starts the script and will setup everything required - POST-load
Notes : None  
*/
function __main__()
{
}

// ============================== INITIALIZE ==============================

// ============================== CALLBACKS ==============================

