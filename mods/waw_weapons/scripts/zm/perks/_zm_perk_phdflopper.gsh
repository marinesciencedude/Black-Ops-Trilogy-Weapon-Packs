// PHD FUNCTIONS
// Alter these things to your liking
// Settings are automatically set to what I (MikeyRay) think are the most "user-friendly" settings

#define PHDFLOPPER_EXPLOSIVE_IMMUNITY			true 	// Makes you immune to explosive damage
#define PHDFLOPPER_EXPLOSIVE_INCREASE			false 	// Increases damage of explosive weapons
#define PHDFLOPPER_EXPLOSIVE_FALL				true 	// Explosion when falling from X height (MUST jump or slide off of platform)
#define PHDFLOPPER_EXPLOSIVE_SLIDE				false 	// Explosion while sliding

// Explosive Damage Increase Settings
#define PHDFLOPPER_EXPLOSIVE_DAMAGE_INCREASE	1.75 	// Increases by 75%

// Explode Fall Settings
#define PHDFLOPPER_EXPLOSIVE_FALL_RANGE			48		// How many units the player needs to be off the ground for the explosion to happen
#define PHDFLOPPER_EXPLOSIVE_FALL_WAIT			3 		// How long the cooldown is before you can explode again from height

// Explode Slide Settings
#define PHDFLOPPER_SLIDE_WAIT					0.2		// How long to wait inbetween explosions
#define PHDFLOPPER_SLIDE_COOLDOWN				5 		// How long the cooldown is before slide explosions can happen again
 
// These are shared for both slide & fall
// Stats straight from BO1 (thanks to MotoLegacy)
#define PHDFLOPPER_EXPLOSION_EFFECT				"explosions/fx_exp_grenade_default"
#define PHDFLOPPER_EXPLOSIVE_SCREEN_SHAKE		true 	// Shakes the screen when landing
#define PHDFLOPPER_EXPLOSIVE_RADIUS				300
#define PHDFLOPPER_MAX_DAMAGE					5000
#define PHDFLOPPER_MIN_DAMAGE					1000

// PHD SETTINGS
#define PHDFLOPPER_PERK_COST					2000
#define PHDFLOPPER_PERK_BOTTLE_WEAPON			"zombie_perk_bottle_phd"
#define PHDFLOPPER_SHADER						"specialty_phdflopper_zombies"
#define PHDFLOPPER_MACHINE_DISABLED_MODEL		"p7_zm_vending_phd"
#define PHDFLOPPER_MACHINE_ACTIVE_MODEL			"p7_zm_vending_phd_active"
#define PHDFLOPPER_RADIANT_MACHINE_NAME			"vending_phd"
#define PHDFLOPPER_MACHINE_LIGHT_FX				"vending_phd_light"	
#define PHDFLOPPER_LIGHTING_FX					"_mikeyray/perks/phd/fx_perk_phd"
#define PHDFLOPPER_PERK_STRING					"phdflopper_perk"		
#define PHDFLOPPER_MUS_STING					"mus_perks_phdflopper_sting"		
#define PHDFLOPPER_MUS_JINGLE					"mus_perks_phdflopper_jingle"		
