var enable_debug = keyboard_check_pressed(vk_tab) || gamepad_button_check_pressed(global.gp_slot, gp_face4);
if (enable_debug) show_debug = !show_debug;