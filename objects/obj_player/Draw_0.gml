var sign_player_hspeed = sign(player_horizontal_speed);

side = player_horizontal_speed != 0 ? sign_player_hspeed : side;

draw_sprite_ext(sprite_index, image_index, x, y, (x_scale*side), y_scale, image_angle, image_blend, image_alpha);