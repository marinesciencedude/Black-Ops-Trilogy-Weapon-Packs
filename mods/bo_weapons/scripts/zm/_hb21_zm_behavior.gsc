#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\math_shared;
#using scripts\shared\ai_shared;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\animation_state_machine_notetracks;
#using scripts\shared\ai\systems\animation_state_machine_mocomp;
#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\archetype_locomotion_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\zombie;
#using scripts\shared\ai\zombie_utility;

#using scripts\zm\_zm_attackables;
#using scripts\zm\_zm_behavior_utility;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\ai\zombie.gsh;
#insert scripts\shared\ai\systems\animation_state_machine.gsh;
#insert scripts\shared\ai\systems\behavior.gsh;
#insert scripts\shared\ai\systems\behavior_tree.gsh;
#insert scripts\shared\ai\systems\blackboard.gsh;
#insert scripts\shared\ai\utility.gsh;
#insert scripts\shared\archetype_shared\archetype_shared.gsh;
#insert scripts\shared\aat_zm.gsh;

#insert scripts\zm\_zm_behavior.gsh;

#define	ZOMBIE_SIDE_STEP_CHANCE		  					.7
#define	ZOMBIE_RIGHT_STEP_CHANCE		  					.5
#define	ZOMBIE_FORWARD_STEP_CHANCE		  				.3

#define	ZOMBIE_REACTION_INTERVAL							2000
#define	ZOMBIE_MIN_REACTION_DIST    						64
#define	ZOMBIE_MAX_REACTION_DIST		  					1000

#namespace hb21_zm_behavior;

REGISTER_SYSTEM_EX( "hb21_zm_behavior", &__init__, &__main__, undefined )

function __init__()
{
	// ------- ZOMBIE SIDE STEP -----------//
	BB_REGISTER_ATTRIBUTE( "_zombie_side_step_type", 					"none",		 											&zombie_side_step_type );
	BT_REGISTER_API( 			"zombiesidestepservice", 						&zombie_side_step_service );
	BT_REGISTER_API( 			"zombieshouldsidestep", 						&zombie_should_side_step );
	BT_REGISTER_ACTION( 	"zombiesidestepaction", 							&zombie_side_step_action,						undefined, 												&zombie_side_step_terminate );
}

function __main__()
{
}

function enable_side_step()
{
	self.n_stepped_direction 							= 0;
	self.n_zombie_can_side_step 						= 1;
	self.n_zombie_can_forward_step 				= 1;
	self.n_zombie_side_step_step_chance 		= ZOMBIE_SIDE_STEP_CHANCE;
	self.n_zombie_right_step_step_chance 		= ZOMBIE_RIGHT_STEP_CHANCE;
	self.n_zombie_forward_step_step_chance 	= ZOMBIE_FORWARD_STEP_CHANCE;
	self.n_zombie_reaction_interval 					= ZOMBIE_REACTION_INTERVAL;
	self.n_zombie_min_reaction_dist 				= ZOMBIE_MIN_REACTION_DIST;
	self.n_zombie_max_reaction_dist 				= ZOMBIE_MAX_REACTION_DIST;
}

function disable_ai_pain()
{
	self.a.disablepain = 1;
	self.allowpain = 0;
	self.a.disableReact = 1;
	self.allowReact = 0;
}

function enable_ai_pain()
{
	self.a.disablepain = 0;
	self.allowpain = 1;
	self.a.disableReact = 0;
	self.allowReact = 1;
}

function zombie_side_step_type()
{
	return self._zombie_side_step_type;
}

function zombie_side_step_service( behavior_tree_entity )
{
	if ( !IS_TRUE( behavior_tree_entity.n_zombie_can_side_step ) )
		return;
	
	if ( !isDefined ( behavior_tree_entity.n_last_side_step_time ) )
		behavior_tree_entity.n_last_side_step_time	= getTime();
	
	if ( isDefined( behavior_tree_entity.enemy ) )
	{
		behavior_tree_entity.str_side_step_type = behavior_tree_entity zombie_get_side_step();
	
		if ( behavior_tree_entity.str_side_step_type != "none" )
		{
			behavior_tree_entity._juke_direction = behavior_tree_entity zombie_get_desired_side_step_direction();
			
			if ( behavior_tree_entity._juke_direction == "none" )
				return;
			
			str_anim_name = behavior_tree_entity animMappingSearch( iString( "anim_" + behavior_tree_entity.archetype + "_side_" + behavior_tree_entity.str_side_step_type + "_" + behavior_tree_entity._juke_direction ) );
			if ( behavior_tree_entity mayMoveFromPointToPoint( behavior_tree_entity.origin, zombie_utility::getAnimEndPos( str_anim_name ) ) )
			{
				behavior_tree_entity._zombie_side_step_type = behavior_tree_entity.str_side_step_type + "_" + behavior_tree_entity._juke_direction;
				behavior_tree_entity.n_zombie_side_step = 1;
			}
		}
	}
}

function zombie_get_side_step()
{
	if ( self zombie_can_side_step() && isPlayer( self.enemy ) && self.enemy isLookingAt( self ) )
	{
		if ( IS_TRUE( self.n_zombie_can_side_step ) && randomFloat( 1 ) < self.n_zombie_side_step_step_chance )
			return "step";
		
	}
	return "none";
}

function zombie_can_side_step()
{
	if ( !IS_TRUE( self.n_zombie_can_side_step ) )
		return 0;
	
	if ( getTime() - self.n_last_side_step_time < self.n_zombie_reaction_interval )
		return 0;
	
	self.n_last_side_step_time	= getTime();
	if ( !isDefined( self.enemy ) )
		return 0;
	
	if( IS_TRUE( self.missingLegs ) )
		return 0;
	
	dist_sq_from_enemy = distanceSquared( self.origin, self.enemy.origin );

	if ( dist_sq_from_enemy < ( self.n_zombie_min_reaction_dist * self.n_zombie_min_reaction_dist ) )
		return 0;

	if ( dist_sq_from_enemy > ( self.n_zombie_max_reaction_dist * self.n_zombie_max_reaction_dist ) )
		return 0;

	if ( !isDefined( self.pathgoalpos ) || distanceSquared( self.origin, self.pathgoalpos ) < ( self.n_zombie_min_reaction_dist * self.n_zombie_min_reaction_dist ) )
		return 0;

	if ( abs( self getMotionAngle() ) > 15 )
		return 0;

	yaw = zombie_utility::getYawToOrigin( self.enemy.origin );

	if ( abs( yaw ) > 45 )
		return 0;
	
	return 1;
}

function zombie_get_desired_side_step_direction()
{
	// if ( self.str_side_step_type == "roll" || self.str_side_step_type == "phase" )		
	// 	return "forward";
	
	randomRoll = randomFloat( 1 );

	if ( randomRoll < self.n_zombie_forward_step_step_chance )
		return "forward";

	if ( self.n_stepped_direction < 0 )
		return "right";
	else if ( self.n_stepped_direction > 0 )
		return "left";
	else if ( randomRoll < self.n_zombie_right_step_step_chance )
		return "right";
	else if ( randomRoll < self.n_zombie_right_step_step_chance * 2 )
		return "left";
	
	return "none";
}

function zombie_should_side_step( behaviorTreeEntity )
{
    if ( IS_TRUE( behaviorTreeEntity.n_zombie_side_step ) )
        return 1;
	
    return 0;
}

function zombie_side_step_action( behavior_tree_entity, asm_state_name )
{
	behavior_tree_entity disable_ai_pain();
    AnimationStateNetworkUtility::RequestState( behavior_tree_entity, asm_state_name );
        
    return BHTN_RUNNING;
}

function zombie_side_step_terminate( behavior_tree_entity, asm_state_name )
{
	behavior_tree_entity enable_ai_pain();
	behavior_tree_entity.n_zombie_side_step = undefined;
    
	if ( behavior_tree_entity._juke_direction == "left" )
		behavior_tree_entity.n_stepped_direction--;
	else
		behavior_tree_entity.n_stepped_direction++;

	behavior_tree_entity.n_last_side_step_time = getTime();

    return BHTN_SUCCESS;    
}