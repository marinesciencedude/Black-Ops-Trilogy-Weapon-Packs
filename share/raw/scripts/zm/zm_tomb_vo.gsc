
#namespace zm_tomb_vo;

function init_flags() {}
function init_level_specific_audio() {}
function tomb_add_player_dialogue(speaker, category, type, alias, response = 0, chance = 100) {}
function tomb_audio_get_mod_type_override(impact, mod, weapon, zombie, instakill, dist, player) {}
function tomb_custom_zombie_oh_shit_vox() {}
function global_oh_shit_cooldown_timer(n_cooldown_time) {}
function tomb_custom_crawler_spawned_vo() {}
function crawler_created_vo_cooldown() {}
function tomb_audio_custom_weapon_check(weapon, magic_box) {}
function tomb_magic_box_used_vo() {}
function easter_egg_song_vo(player) {}
function play_gramophone_place_vo() {}
function setup_personality_character_exerts() {}
function tomb_audio_custom_response_line(player, category, type) {}
function play_vo_category_on_closest_player(category, type) {}
function play_pos_neg_response_on_closest_player(category, type, str_stat) {}
function get_positive_or_negative_suffix(e_player1, e_player2, str_stat) {}
function struggle_mud_vo() {}
function struggle_mud_vo_cooldown() {}
function discover_dig_site_vo() {}
function discover_dig_site_trigger_touch() {}
function maxis_audio_logs() {}
function discover_pack_a_punch() {}
function can_player_speak() {}
function maxis_audio_log_think() {}
function play_maxis_audio_log(v_trigger_origin, n_audiolog_id) {}
function reset_maxis_audiolog_unitrigger(n_robot_id) {}
function restart_maxis_audiolog_unitrigger(n_robot_id) {}
function get_audiolog_vo() {}
function start_narrative_vo() {}
function start_samantha_intro_vo() {}
function samantha_intro_1() {}
function samantha_intro_2() {}
function samantha_intro_3() {}
function play_category_on_player_character_if_present(category, character_name) {}
function get_nearest_friend_within_speaking_distance(other_player) {}
function play_line_on_player_character_if_present(vox_line, character_name) {}
function get_player_character_if_present(character_name) {}
function round_two_end_narrative_vo() {}
function game_start_solo_vo() {}
function build_game_start_solo_convo() {}
function game_start_vo() {}
function build_game_start_convo() {}
function run_staff_crafted_vo(str_sam_line) {}
function staff_craft_vo() {}
function all_staffs_crafted_vo() {}
function build_all_staffs_crafted_vo() {}
function get_left_behind_plea() {}
function get_left_behind_response(e_victim) {}
function tank_left_behind_vo(e_victim, e_rider) {}
function round_one_end_solo_vo() {}
function build_round_one_end_solo_convo() {}
function round_one_end_vo() {}
function build_round_one_end_convo() {}
function round_two_end_solo_vo() {}
function build_round_two_end_solo_convo() {}
function first_magic_box_seen_vo() {}
function wait_and_play_first_magic_box_seen_vo(struct) {}
function build_first_magic_box_seen_vo() {}
function tomb_drone_built_vo(s_craftable) {}
function get_speaking_location_maxis_drone(player, s_craftable) {}
function b_player_has_dieseldrone_weapon() {}
function set_players_dontspeak(bool) {}
function set_player_dontspeak(bool) {}
function is_game_solo() {}
function add_puzzle_completion_line(n_element_enum, str_line) {}
function say_puzzle_completion_line(n_element_enum) {}
function watch_occasional_line(str_category, str_line, str_notify, n_time_between = 30, n_times_to_play = 100) {}
function watch_one_shot_line(str_category, str_line, str_notify) {}
function watch_one_shot_samantha_line(str_line, str_notify) {}
function watch_one_shot_samantha_clue(str_line, str_notify, str_endon) {}
function samantha_discourage_reset() {}
function samantha_encourage_watch_good_lines() {}
function samantha_encourage_think() {}
function samantha_discourage_think() {}
function samanthasay(vox_line, e_source, b_wait_for_nearby_speakers = 0, intro_line = 0) {}
function samanthasayvoplay(e_source, vox_line) {}
function maxissay(vox_line, m_spot_override, b_wait_for_nearby_speakers) {}
function maxissayvoplay(m_vo_spot, vox_line) {}
function richtofenrespondvoplay(vox_category, b_richtofen_first = 0, str_flag) {}
function wunderfizz_used_vo() {}
function init_sam_promises() {}
function sam_promises_watch() {}
function sam_promises_conversation() {}
function play_sam_promises_conversation(a_promises) {}
function sam_promises_conversation_ended_early(str_alias) {}
function sam_promises_cooldown() {}