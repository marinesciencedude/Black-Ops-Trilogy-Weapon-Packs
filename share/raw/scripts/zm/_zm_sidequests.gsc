
#namespace zm_sidequests;

function init_sidequests() {}
function is_sidequest_allowed(a_gametypes) {}
function sidequest_debug() {}
function damager_trigger_thread(dam_types, trigger_func) {}
function damage_trigger_thread() {}
function entity_damage_thread() {}
function sidequest_uses_teleportation(name) {}
function register_sidequest_icon(icon_name, version_number) {}
function add_sidequest_icon(sidequest_name, icon_name, var_275b4f28 = 1) {}
function remove_sidequest_icon(sidequest_name, icon_name) {}
function declare_sidequest(name, init_func, logic_func, complete_func, generic_stage_start_func, generic_stage_end_func) {}
function declare_sidequest_stage(sidequest_name, stage_name, init_func, logic_func, exit_func) {}
function set_stage_time_limit(sidequest_name, stage_name, time_limit, timer_func) {}
function declare_stage_asset_from_struct(sidequest_name, stage_name, target_name, thread_func, trigger_thread_func) {}
function declare_stage_title(sidequest_name, stage_name, title) {}
function declare_stage_asset(sidequest_name, stage_name, target_name, thread_func, trigger_thread_func) {}
function declare_sidequest_asset(sidequest_name, target_name, thread_func, trigger_thread_func) {}
function declare_sidequest_asset_from_struct(sidequest_name, target_name, thread_func, trigger_thread_func) {}
function build_asset_from_struct(asset, parent_struct) {}
function delete_stage_assets() {}
function build_assets() {}
function radius_trigger_thread() {}
function thread_on_assets(target_name, thread_func) {}
function stage_logic_func_wrapper(sidequest, stage) {}
function sidequest_start(sidequest_name) {}
function stage_start(sidequest, stage) {}
function display_stage_title(wait_for_teleport_done_notify) {}
function time_limited_stage(sidequest) {}
function sidequest_println(str) {}
function precache_sidequest_assets() {}
function sidequest_complete(sidequest_name) {}
function stage_completed(sidequest_name, stage_name) {}
function stage_completed_internal(sidequest, stage) {}
function stage_failed_internal(sidequest, stage) {}
function stage_failed(sidequest, stage) {}
function get_sidequest_stage(sidequest, stage_number) {}
function get_damage_trigger(radius, origin, damage_types) {}
function dam_trigger_thread(damage_types) {}
function use_trigger_thread() {}
function sidequest_stage_active(sidequest_name, stage_name) {}
function sidequest_start_next_stage(sidequest_name) {}
function main() {}
function is_facing(facee) {}
function fake_use(notify_string, qualifier_func) {}
