// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_utility;

#using scripts\shared\visionset_mgr_shared;

#namespace zm_theater_ffotd;

/*
	Name: main_start
	Namespace: zm_theater_ffotd
	Checksum: 0x99EC1590
	Offset: 0x178
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function main_start()
{
}

/*
	Name: main_end
	Namespace: zm_theater_ffotd
	Checksum: 0x99EC1590
	Offset: 0x188
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function main_end()
{
	//if(GetDvarInt("mutator_map_visionset") == 2)
	//{
		//visionset_mgr::init_fog_vol_to_visionset_monitor("default", 0);
		//visionset_mgr::fog_vol_to_visionset_set_info(0, "default");
		
		level._fv2vs_default_visionset = "default";
		visionsetstruct = level._fv2vs_infos[0];
		visionsetstruct.visionset = "default";
		level._fv2vs_infos[0] = visionsetstruct;
	//}
}

