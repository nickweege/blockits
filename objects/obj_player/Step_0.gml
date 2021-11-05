if (global.pause) exit;

var temp = place_meeting(x, y+1, obj_default_collider);

if (temp && !on_floor) audio_play_sound(landing_sound, 1, false);

on_floor = place_meeting(x, y+1, obj_default_collider);
on_left_wall = place_meeting(x-1, y, obj_wall_collider);
on_right_wall = place_meeting(x+1, y, obj_wall_collider);

if (on_floor){
	player_jump_timer = player_jump_limit;
	player_dash_cooldown = 1;
} else if (player_jump_timer > 0) player_jump_timer--;

if (on_left_wall || on_right_wall){
	last_wall = on_left_wall ? 0 : 1;
	wall_timer = wall_limit;
} else if (wall_timer > 0) wall_timer--;

player_default_accel = on_floor ? player_floor_accel : player_air_accel;

var left, right, up, down, jump, jump_released, dash;
left = keyboard_check(ord("A"));
right = keyboard_check(ord("D"));
up = keyboard_check(ord("W"));
down = keyboard_check(ord("S"));
jump = keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("K"));
jump_released = keyboard_check_released(vk_space) || keyboard_check_released(ord("K"));
dash = keyboard_check_pressed(ord("L"));

var h_spd = (right - left) * max_player_horizontal_speed;

#region STATE MACHINE

	switch(player_state){
		#region IDLE
		
			case "idle":
				player_horizontal_speed = 0;
				player_vertical_speed = 0;
				
				if (!on_floor) player_vertical_speed += player_gravity;
				
				if (on_floor && jump){
					player_vertical_speed = -max_player_vertical_speed;
					audio_play_sound(jump_sound, 1, false);
				}
				
				if (abs(player_horizontal_speed) > 0 || abs(player_vertical_speed) > 0 || left || right || jump) player_state = "moving";
				
				#region GOING TO DASH STATE
				
					var on_collision_with_walls = place_meeting(x+side, y, obj_default_collider);
					
					if !(on_collision_with_walls){
						if (dash && player_dash_cooldown > 0){
							player_dash_direction = point_direction(0, 0, (right-left), 0);
							audio_play_sound(dash_sound, 1, false);
							player_state = "dash";
							player_dash_cooldown--;
						}
					}
				
				#endregion
			break;
			
		#endregion
		
 		#region MOVING
		
			case "moving":
				player_horizontal_speed = lerp(player_horizontal_speed, h_spd, player_default_accel);
				
				var foot_steps_sound_is_playing = audio_is_playing(foot_steps_sound);
				if (on_floor && !foot_steps_sound_is_playing) audio_play_sound(foot_steps_sound, 1, false);
				else if (!on_floor && foot_steps_sound_is_playing) audio_stop_sound(foot_steps_sound);
				if (player_horizontal_speed <= .8 && player_horizontal_speed >= -.8 && foot_steps_sound_is_playing) audio_stop_sound(foot_steps_sound);
				
				if (jump && (on_floor || player_jump_timer)){
						player_vertical_speed = -max_player_vertical_speed;
						audio_play_sound(jump_sound, 1, false);
					}
				if (jump_released && player_vertical_speed < 0) player_vertical_speed *= .2;
				
				#region ON THE SIDES OF THE WALLS
				
					var wall_slide_sound_is_playing = audio_is_playing(wall_slide_sound);
				
					if (!on_floor && (on_left_wall || on_right_wall || wall_timer)){
						var _lerp = lerp(player_vertical_speed, slide, player_default_accel);
						if ((on_left_wall || on_right_wall) && player_vertical_speed > 0 && !wall_slide_sound_is_playing) audio_play_sound(wall_slide_sound, 1, false);
					
						if (player_vertical_speed > 0) player_vertical_speed = _lerp;
						else player_vertical_speed += player_gravity;
				
						if (!last_wall && jump){	//on left wall
							player_vertical_speed = -max_player_vertical_speed;
							player_horizontal_speed = max_player_horizontal_speed * 3;
							audio_play_sound(wall_jump_sound, 1, false);
						}
						else if (last_wall && jump){	//on right wall
							player_vertical_speed = -max_player_vertical_speed;
							player_horizontal_speed = -max_player_horizontal_speed * 3;
							audio_play_sound(wall_jump_sound, 1, false);
						}
					} else if (!on_floor) player_vertical_speed += player_gravity;
					
					if (!(on_left_wall || on_right_wall) && wall_slide_sound_is_playing) audio_stop_sound(wall_slide_sound);
					if ((on_left_wall || on_right_wall) && on_floor && wall_slide_sound_is_playing) audio_stop_sound(wall_slide_sound);
				
				#endregion
				
				#region GOING TO DASH STATE
				
					var on_collision_with_walls = place_meeting(x+side, y, obj_default_collider);
					
					if !(on_collision_with_walls){
						if (dash && player_dash_cooldown > 0){
							if (left || right) player_dash_direction = point_direction(0, 0, (right-left), 0);
							else player_dash_direction = point_direction(0, 0, side, 0);
							audio_play_sound(dash_sound, 1, false);
							player_state = "dash";
							player_dash_cooldown--;
						}
					}
				
				#endregion
			break;
			
		#endregion
		
		#region DASH
		
			case "dash":
				player_dash_timer--;
				player_horizontal_speed = lengthdir_x(player_dash_speed, player_dash_direction);
				player_vertical_speed = lengthdir_y(player_dash_speed, player_dash_direction);
				
				if (player_trail_timer_to_create <= 0){
					var trail = instance_create_layer(x, y, "PlayerTrail", obj_player_trail);
					trail.sprite_index = sprite_index;
					player_trail_timer_to_create = player_trail_time_to_count;
				} else player_trail_timer_to_create--;
				
				#region GOING TO MOVING STATE
				
					if (player_dash_timer <= 0){
						player_state = "moving";
						player_dash_timer = room_speed / 4;
						player_horizontal_speed = (max_player_horizontal_speed*sign(player_horizontal_speed)) * .5;
						player_vertical_speed = (max_player_vertical_speed*sign(player_vertical_speed)) * .5;
					}
					
				#endregion
			break;
			
		#endregion
		
		#region DEATH
		
			case "death":
				room_restart();
			break;
			
		#endregion
	}
	
	x_scale = lerp(x_scale, 1, .15);
	y_scale = lerp(y_scale, 1, .15);
	
#endregion

#region COLLISION

	if (place_meeting(x+player_horizontal_speed, y, obj_default_collider)){
		var sign_player_horizontal_speed = sign(player_horizontal_speed);
		while (!place_meeting(x+sign_player_horizontal_speed, y, obj_default_collider)){
			x += sign_player_horizontal_speed;
		}
		player_horizontal_speed = 0;
	}
	
	if (place_meeting(x, y+player_vertical_speed, obj_default_collider)){
		var sign_player_vertical_speed = sign(player_vertical_speed);
		while (!place_meeting(x, y+sign_player_vertical_speed, obj_default_collider)){
			y += sign_player_vertical_speed;
		}
		player_vertical_speed = 0;
	}

#endregion

var on_change_room_mode = place_meeting(x, y, obj_change_room_collider);

x += !on_change_room_mode ? player_horizontal_speed : obj_change_room_collider.x;
y += !on_change_room_mode ? player_vertical_speed : obj_change_room_collider.y;