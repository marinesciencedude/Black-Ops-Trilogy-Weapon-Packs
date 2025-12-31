// ------------------------------------------
// 				Common Macros
// ------------------------------------------
// For On/Off Mutators
#define MUTATOR_ONOFF_ON			1
#define MUTATOR_ONOFF_OFF			2
// For Off/On Mutators
#define MUTATOR_OFFON_OFF			1
#define MUTATOR_OFFON_ON			2
// For Boolean GameTypeSettings
#define BOOLMUTATOR_OFFON_ON 		1
#define BOOLMUTATOR_OFFON_OFF 		0
#define BOOLMUTATOR_ONOFF_ON 		0
#define BOOLMUTATOR_ONOFF_OFF 		1

// Uncomment to enable debug printing.
#define MUTATOR_DEBUG_PRINT(msg) 	// IPrintLnBold(msg)

#define mutator_phd_widows					"delayPlayer"
#define mutator_doubletap					"autoDestroyTime"
#define mutator_doubletap_existence			"ballCount"
#define mutator_deadshot_existence			"bombTimer"
#define mutator_deadshot_price 				"disableClassSelection"
#define mutator_scopeads					"carrierArmor"
#define mutator_sidestep					"disableContracts"
#define mutator_health_difficulty 			"flagDecayTime"
#define mutator_revive_anim					"disableTacInsert"
#define mutator_deathmachine				"disableThirdPersonSpectating"
#define mutator_aug							"enemyCarrierVisible"
#define mutator_claymore					"disableVehicleSpawners"
#define mutator_shinonuma_perk				"flagRespawnTime"
#define mutator_startingweapon				"gameAdvertisementRuleScorePercent"
#define mutator_waw_wall_weapons			"gameAdvertisementRuleTimeLeft"
#define mutator_verruckt_springfield		"gameAdvertisementRuleRound"
#define mutator_wallbuys_kino_der_toten		"gameAdvertisementRuleRoundsWon"
#define mutator_wallbuys_origins			"idleFlagResetTime"
#define mutator_wallbuys_der_eisendrache	"incrementalSpawnDelay"
#define mutator_double_packapunch			"droppedTagRespawn"
#define mutator_enable_gobblegum			"leaderBonus"
#define mutator_enable_wunderfizz			"maxAllocation"
#define mutator_widowswine_existence		"maxObjectiveEventsPerMinute"
#define mutator_spacemonkey					"flagCanBeNeutralized"
#define mutator_falldamage					"flagCaptureCondition"
#define mutator_slide_dive					"maxPlayerOffensive"
#define mutator_grenade_wallbuy				"objectivePingTime"
#define mutator_random_perk_machines		"idleFlagDecay"
#define mutator_ak47						"pointsForSurvivalBonus"
#define mutator_uzi							"pointsPerMeleeKill"
#define mutator_skorpion					"pointsPerPrimaryGrenadeKill"
#define mutator_mac11						"pointsPerPrimaryKill"
#define mutator_m60 						"loadoutKillstreaksEnabled"
#define mutator_stoner63					"multiBomb"
#define mutator_enfield						"pregameDraftRoundTime"
#define mutator_wa2000						"pregameAlwaysShowStreakEdit"
#define mutator_psg1						"pregameDraftType"
#define mutator_ppsh						"pregameItemVoteRoundTime"
#define mutator_freezegun					"rebootPlayers"
#define mutator_raygunmkii					"robotShield"
#define mutator_crossbow					"setbacks"
#define mutator_ballistic_knife				"silentPlant"
#define mutator_camo_disable				"timePausesWhenInZone"
#define mutator_wunderwaffe_camo			"vehiclesEnabled"
#define mutator_camo_ingame_cycle			"vehiclesTimed"
#define mutator_camo_black_ops				"voipDeadHearKiller"
#define mutator_camo_world_at_war			"voipKillersHearVictim"
#define mutator_camo_gold					"robotSpeed"
#define mutator_camo_dark_matter			"setbacks"
#define mutator_camo_ice					"shutdownDamage"
#define mutator_camo_ritual					"cleanDepositOnlineTime"
#define mutator_camo_etching				"cleanDepositRotation"
#define mutator_camo_der_eisendrache		"antiBoostDistance"
#define mutator_camo_overgrowth				"bootTime"
#define mutator_camo_gorod_krovi			"crateCaptureTime"
#define mutator_camo_revelations			"defuseTime"
#define mutator_camo_kino					"destroyTime"
#define mutator_camo_origins				"flagCaptureGracePeriod"
#define mutator_camo_weaponized_115			"infectionMode"
#define mutator_declassified_ppsh			"maxPlayerDefensive"
#define mutator_declassified_mg42			"maxPlayerEventsPerMinute"
#define mutator_george_reward				"objectiveSpawnTime"
#define mutator_wallbuys_callofthedead		"pointsPerSecondaryKill"

#define mutator_wallbuys_gorod_krovi		"rebootTime"
#define mutator_quickrevive					"teamkillpointloss"
#define mutator_wallbuybox					"moveplayers"
#define	mutator_dp27						"scoreperplayer"
#define	mutator_svt40						"hotpotato"
#define	mutator_type99						"allowkillcam"
#define	mutator_monkey_bomb					"killstreaksgivegamescore"
#define	mutator_camo_world_at_war_adjusted	"wagermatchhud"
#define	mutator_declassified_bonuspoints	"scoreresetondeath"
#define	mutator_carpenter					"deathpointloss"
#define	mutator_firesale					"playerqueuedrespawn"

#define mutator_double_packapunch_bo2		"pointsPerWeaponKill"

//ints or int-compatible
/*#define mutator_						"pregameItemVoteRoundTime"
#define mutator_						"pregameItemMaxVotes"
#define mutator_						"pregamePositionShuffleMethod"
#define mutator_						"pregamePositionSortType"
#define mutator_						"pregamePostRoundTime"
#define mutator_						"pregamePostStageTime"
#define mutator_						"pregamePreStageTime"
#define mutator_						"pregameScorestreakModifyTime"
#define mutator_						"prematchrequirement"
#define mutator_						"prematchrequirementtime"
#define mutator_						"randomObjectiveLocations"*/

//bools
/*#define "kothMode"
#define "OvertimetimeLimit"*/
//#define "pregameDraftEnabled"	//game stuck loading
//#define "pregameItemVoteEnabled"	//game stuck loading
/*#define	mutator_		"cumulativeroundscores"
#define	mutator_		"playerforcerespawn"*/

//floats
/*#define "defuseTime							
#define "destroyTime							
#define "plantTime
#define "playerObjectiveHeldRespawnDelay*/