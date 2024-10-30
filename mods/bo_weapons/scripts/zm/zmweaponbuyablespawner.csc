#using scripts\codescripts\struct;

#namespace namespace_82ed610e;

/*
	Name: init
	Namespace: namespace_82ed610e
	Checksum: 0xC10E8F79
	Offset: 0x180
	Size: 0x64B
	Parameters: 0
	Flags: AutoExec
*/
function autoexec init()
{
	SetDvar("sv_cheats", 1);
	LuiLoad("ui.utility.HUDInject");
	foreach(struct in struct::get_array("weapon_upgrade", "targetname"))
	{
		struct struct::delete();
	}
	foreach(struct in struct::get_array("claymore_purchase", "targetname"))
	{
		struct struct::delete();
	}
	level thread function_ccc224aa("t5_m14", (2434, 5364, -313), VectorScale((0, -1, 0), 90));
	level thread function_ccc224aa("t5_olympia", (2027, 4521, -251), (0, 0, 0));
	level thread function_ccc224aa("shotgun_pump", (1530, 3697, -264), (0, 0, 0));
	level thread function_ccc224aa("t6_b23r", (2239, 3536, -259), (0, 0, 0));
	level thread function_ccc224aa("claymore", (1205, 4364, -294), VectorScale((0, -1, 0), 90));
	level thread function_ccc224aa("sticky_grenade", (2301, 2861, -222), VectorScale((0, 1, 0), 90));
	level thread function_ccc224aa("t6_ak74u", (698, 2629, -177), (0, 0, 0));
	level thread function_ccc224aa("ar_stg44", (-524, 4503, -293), VectorScale((0, 1, 0), 180));
	level thread function_ccc224aa("t6_fiveseven", (-927, 3049, -55), VectorScale((0, -1, 0), 90));
	level thread function_ccc224aa("ar_stg44", (-646, 686, 199), VectorScale((0, 1, 0), 60));
	level thread function_ccc224aa("claymore", (-2851, -71, 295), VectorScale((0, 1, 0), 90));
	level thread function_ccc224aa("shotgun_pump", (-3327, 80, -18), VectorScale((0, -1, 0), 90));
	level thread function_ccc224aa("sticky_grenade", (814, -2884, 102), VectorScale((0, 1, 0), 15));
	level thread function_ccc224aa("t6_b23r", (-56, -2716, 107), VectorScale((0, -1, 0), 75));
	level thread function_ccc224aa("smg_mp40_1940", (575, -2518, 409), VectorScale((0, -1, 0), 165));
	level thread function_ccc224aa("shotgun_pump", (958, -4052, 352), (0, 0, 0));
	level thread function_ccc224aa("t6_fiveseven", (1271, -2592, 149), VectorScale((0, -1, 0), 165));
	level thread function_ccc224aa("ar_stg44", (3226, -429, 190), (0, 0, 0));
	level thread function_ccc224aa("claymore", (2355, 471, 163), VectorScale((0, 1, 0), 270));
	level thread function_ccc224aa("t6_ak74u", (-335, 139, 375), VectorScale((0, -1, 0), 90));
	level thread function_ccc224aa("smg_mp40_1940", (12, 494, -206), VectorScale((0, -1, 0), 180));
	level thread function_ccc224aa("smg_mp40_1940", (9451, -7268, -334), VectorScale((0, -1, 0), 90));
	level thread function_ccc224aa("t6_ak74u", (11187, -8395, -359), VectorScale((0, 1, 0), 90));
}

/*
	Name: function_ccc224aa
	Namespace: namespace_82ed610e
	Checksum: 0x2B2A4A48
	Offset: 0x7D8
	Size: 0x103
	Parameters: 3
	Flags: Private
*/
function private function_ccc224aa(var_db75de4a, v_origin, v_angles)
{
	struct = struct::spawn(v_origin, v_angles);
	struct.zombie_weapon_upgrade = var_db75de4a;
	struct.targetname = "weapon_upgrade";
	struct.target = "weapon" + v_origin;
	struct struct::init();
	/*var_8892298a = struct::spawn(v_origin, v_angles);
	var_8892298a.targetname = "weapon" + v_origin;
	var_8892298a.model = "wpn_t7_ar_talon_world";
	var_8892298a struct::init();*/
}

/*
	Name: function_8228dcce
	Namespace: namespace_82ed610e
	Checksum: 0xEBBFA8B7
	Offset: 0x8E8
	Size: 0x4F
	Parameters: 0
	Flags: Private
*/
function private function_8228dcce()
{
	while(1)
	{
		wait(0.5);
		IPrintLnBold("Change fov");
		SetSavedDvar("cg_fov", 65);
	}
}

