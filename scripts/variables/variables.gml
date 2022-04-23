global.pause = false;
global.device = 0;
global.is_gamepad = false;

#region Keyboard Inputs
global.input_vk_right = ord("D");
global.input_vk_left = ord("A");
global.input_vk_down = ord("S");
global.input_vk_up = ord("W");
global.input_vk_jump = ord("K");
global.input_vk_dash = ord("L");
global.input_vk_invoke_debug = ord("J");
global.input_vk_select = vk_enter;
global.input_vk_pause = vk_escape;
#endregion

#region Gamepad Inputs
global.input_gp_right = gp_padr;
global.input_gp_left = gp_padl;
global.input_gp_down = gp_padd;
global.input_gp_up = gp_padu;
global.input_gp_jump = gp_face1;
global.input_gp_dash = gp_face2;
global.input_gp_invoke_debug = gp_face3;
global.input_gp_select = gp_face1;
global.input_gp_pause = gp_start;
global.input_gp_back = gp_select;
global.input_gp_lh_analog = gp_axislh;
global.input_gp_lv_analog = gp_axislv;
#endregion