#using scripts\codescripts\struct;

#namespace namespace_82ed610e;

/*
	Name: init
	Namespace: namespace_82ed610e
	Checksum: 0x920784F8
	Offset: 0x1F8
	Size: 0x6CB
	Parameters: 0
	Flags: AutoExec
*/
function autoexec init()
{
	foreach(struct in struct::get_array("weapon_upgrade", "targetname"))
	{
		struct struct::delete();
	}
	foreach(struct in struct::get_array("claymore_purchase", "targetname"))
	{
		struct struct::delete();
	}
	//switch( GetDvarString("ui_mapname") )
	{
		//Kino Der Toten
	//case "zm_theater":
		level thread function_ccc224aa("t5_m14", (2434, 5364, -313), VectorScale((0, -1, 0), 90), "wm_t5_m14");
		level thread function_ccc224aa("t5_olympia", (2027, 4521, -251), (0, 0, 0), "wm_t5_olympia");
		level thread function_ccc224aa("shotgun_pump", (1530, 3697, -264), (0, 0, 0), "wb_870_chalk");
		level thread function_ccc224aa("t6_b23r", (2239, 3536, -259), (0, 0, 0), "wb_b23r_chalk");
		level thread function_ccc224aa("claymore", (1205, 4364, -294), VectorScale((0, -1, 0), 90), "wb_claymore_chalk");
		level thread function_ccc224aa("sticky_grenade", (2301, 2861, -222), VectorScale((0, 1, 0), 90), "wb_semtex_chalk");
		level thread function_ccc224aa("t6_ak74u", (698, 2629, -177), (0, 0, 0), "wb_ak74u_chalk");
		level thread function_ccc224aa("ar_stg44", (-524, 4503, -293), VectorScale((0, 1, 0), 180), "wb_mp40_chalk");
		level thread function_ccc224aa("t6_fiveseven", (-927, 3049, -55), VectorScale((0, -1, 0), 90), "wb_fiveseven_chalk");
		level thread function_ccc224aa("ar_stg44", (-646, 686, 199), VectorScale((0, 1, 0), 60), "wb_mp40_chalk");
		level thread function_ccc224aa("claymore", (-2851, -71, 295), VectorScale((0, 1, 0), 90), "wb_claymore_chalk");
		level thread function_ccc224aa("shotgun_pump", (-3327, 80, -18), VectorScale((0, -1, 0), 90), "wb_870_chalk");
		level thread function_ccc224aa("sticky_grenade", (814, -2884, 102), VectorScale((0, 1, 0), 15), "wb_semtex_chalk");
		level thread function_ccc224aa("t6_b23r", (-56, -2716, 107), VectorScale((0, -1, 0), 75), "wb_b23r_chalk");
		level thread function_ccc224aa("smg_mp40_1940", (575, -2518, 409), VectorScale((0, -1, 0), 165), "wb_stg44_chalk");
		level thread function_ccc224aa("shotgun_pump", (958, -4052, 352), (0, 0, 0), "wb_870_chalk");
		level thread function_ccc224aa("t6_fiveseven", (1271, -2592, 149), VectorScale((0, -1, 0), 165), "wb_fiveseven_chalk");
		level thread function_ccc224aa("ar_stg44", (3226, -429, 190), (0, 0, 0), "wb_mp40_chalk");
		level thread function_ccc224aa("claymore", (2355, 471, 163), VectorScale((0, 1, 0), 270), "wb_claymore_chalk");
		level thread function_ccc224aa("t6_ak74u", (-335, 139, 375), VectorScale((0, -1, 0), 90), "wb_ak74u_chalk");
		level thread function_ccc224aa("smg_mp40_1940", (12, 494, -206), VectorScale((0, -1, 0), 180), "wb_stg44_chalk");
		level thread function_ccc224aa("smg_mp40_1940", (9451, -7268, -334), VectorScale((0, -1, 0), 90), "wb_stg44_chalk");
		level thread function_ccc224aa("t6_ak74u", (11187, -8395, -359), VectorScale((0, 1, 0), 90), "wb_ak74u_chalk");
	}
}

/*
	Name: function_ccc224aa
	Namespace: namespace_82ed610e
	Checksum: 0xC5C018BA
	Offset: 0x8D0
	Size: 0x16B
	Parameters: 4
	Flags: Private
*/
function private function_ccc224aa(var_db75de4a, v_origin, v_angles, var_40fd1793)
{
	struct = struct::spawn(v_origin, v_angles);
	struct.zombie_weapon_upgrade = var_db75de4a;
	struct.targetname = "weapon_upgrade";
	struct.target = "weapon" + v_origin;
	struct struct::init();
	model = spawn("script_model", v_origin);
	model SetModel(var_40fd1793);
	model.angles = v_angles;
	/*var_8892298a = struct::spawn(v_origin, v_angles);
	var_8892298a.targetname = "weapon" + v_origin;
	var_8892298a.model = "wpn_t7_ar_talon_world";
	var_8892298a struct::init();*/
}

