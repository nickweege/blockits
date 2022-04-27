if (global.pause)
	exit;

player_landing();
update_player_collision_variables();
update_player_jump_limit();
update_player_walls_collision();
update_player_default_accel();
update_player_inputs();

_h_speed = (right - left) * max_h_speed;

update_player_state();
set_player_state();

h_speed_final = h_speed + h_speed_f;
h_speed_f = h_speed_final - floor(abs(h_speed_final)) * sign(h_speed_final);
h_speed_final -= h_speed_f;

v_speed_final = v_speed + v_speed_f;
v_speed_f = v_speed_final - floor(abs(v_speed_final)) * sign(v_speed_final);
v_speed_final -= v_speed_f;

update_player_collision();
move_camera();
