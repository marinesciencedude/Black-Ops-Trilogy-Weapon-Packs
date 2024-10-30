#using scripts\zm\_zm_utility;

#namespace _zm_weap_crossbow;

function init()
{
	level thread crossbow_on_player_connect();
}

function crossbow_on_player_connect()
{
	level waittill("connecting", player);
	level thread watch_for_monkey_bolt();
}

function watch_for_monkey_bolt()
{
	for(;;)
	{
		self waittill ( "grenade_launcher_fire", grenade, weapon );
		
		if(weapon.name == "t9_crossbow_up")
			grenade thread crossbow_monkey_bolt();
	}
}

function crossbow_monkey_bolt()
{
	valid_poi = zm_utility::check_point_in_enabled_zone(self.origin, undefined, undefined);
	if(isdefined(level.move_valid_poi_to_navmesh) && level.move_valid_poi_to_navmesh)
	{
		valid_poi = self move_valid_poi_to_navmesh(valid_poi);
	}
	if(isdefined(level.check_valid_poi))
	{
		valid_poi = self [[level.check_valid_poi]](valid_poi);
	}
	if(valid_poi)
	{
		self zm_utility::create_zombie_point_of_interest(1536, 96, 10000);
		self.attract_to_origin = 1;
		self thread zm_utility::create_zombie_point_of_interest_attractor_positions(4, 45);
		self thread zm_utility::wait_for_attractor_positions_complete();
	}
}

function move_valid_poi_to_navmesh(valid_poi)
{
	if(!(isdefined(valid_poi) && valid_poi))
	{
		return false;
	}
	if(ispointonnavmesh(self.origin))
	{
		return true;
	}
	v_orig = self.origin;
	queryresult = positionquery_source_navigation(self.origin, 0, level.valid_poi_max_radius, level.valid_poi_half_height, level.valid_poi_inner_spacing, level.valid_poi_radius_from_edges);
	if(queryresult.data.size)
	{
		foreach(point in queryresult.data)
		{
			height_offset = abs(self.origin[2] - point.origin[2]);
			if(height_offset > level.valid_poi_height)
			{
				continue;
			}
			if(bullettracepassed(point.origin + vectorscale((0, 0, 1), 20), v_orig + vectorscale((0, 0, 1), 20), 0, self, undefined, 0, 0))
			{
				self.origin = point.origin;
				return true;
			}
		}
	}
	return false;
}