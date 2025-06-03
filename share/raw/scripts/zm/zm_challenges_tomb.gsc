
#namespace zm_challenges_tomb;

function autoexec __init__sytem__() {}
function __init__() {}
function __main__() {}
function onplayerconnect() {}
function onplayerspawned() {}
function stats_init() {}
function add_stat(str_name, b_team = 0, str_hint = &"", n_goal = 1, str_reward_model, fp_give_reward, fp_init_stat) {}
function player_stats_init(n_index) {}
function team_stats_init(n_index) {}
function challenge_exists(str_name) {}
function get_stat(str_stat, player) {}
function increment_stat(str_stat, n_increment = 1) {}
function set_stat(str_stat, n_set) {}
function function_fbbc8608(str_hint, var_7ca2c2ae) {}
function check_stat_complete(s_stat) {}
function stat_reward_available(stat, player) {}
function player_has_unclaimed_team_reward() {}
function board_init(m_board) {}
function box_init() {}
function box_prompt_and_visiblity(player) {}
function update_box_prompt(player) {}
function box_think() {}
function get_reward_category(player, s_select_stat) {}
function get_reward_stat(s_category) {}
function open_box(player, ut_stub, fp_reward_override, param1) {}
function spawn_reward(player, s_select_stat) {}
function reward_grab_wait(n_timeout = 10) {}
function reward_sink(n_delay, n_z, n_time) {}
function reward_rise_and_grab(m_reward, n_z, n_rise_time, n_delay, n_timeout) {}
function reward_points(player, s_stat) {}
function challenges_devgui() {}
function watch_devgui_award_challenges() {}
function devgui_award_challenge(n_index) {}