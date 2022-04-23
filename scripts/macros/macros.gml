#macro VIEW_W 320
#macro VIEW_H 180

#macro CAM_W 320
#macro CAM_H 180

#region Layers
#macro CONTROLLERS_LAYER "Controllers"
#macro PLAYER_LAYER "Player"
#macro DEFAULT_COLLIDERS_LAYER "Default_Colliders"
#macro DEATH_COLLIDERS_LAYER "Death_Colliders"
#macro WALL_COLLIDERS_LAYER "Wall_Colliders"
#endregion

#region Colliders
#macro DEFAULT_COLLIDER obj_default_collider
#macro WALL_COLLIDER obj_wall_collider
#endregion

#region Player Sounds
#macro PLAYER_LANDING_SOUND snd_landing
#macro PLAYER_JUMP_SOUND snd_jump
#macro PLAYER_WALL_JUMP_SOUND snd_wall_jump
#macro PLAYER_DASH_SOUND snd_dash
#macro PLAYER_WALL_SLIDE_SOUND snd_wall_slide
#endregion

#region Menu Sounds
#macro MENU_CHANGE_OPTION_SOUND snd_menu_click
#macro MENU_CLICK_SOUND snd_menu_click
#macro MENU_SELECT_SOUND snd_menu_click
#endregion

#region Sprites
#macro MENU_ICON_SPRITE spr_menu_feedback_icon
#endregion
 
#region Keyboard Default Inputs
#macro DEFAULT_INPUT_VK_RIGHT ord("D")
#macro DEFAULT_INPUT_VK_LEFT ord("A")
#macro DEFAULT_INPUT_VK_DOWN ord("S")
#macro DEFAULT_INPUT_VK_UP ord("W")
#endregion

#region Gamepad Default Inputs
#macro DEFAULT_INPUT_GP_RIGHT gp_padr
#macro DEFAULT_INPUT_GP_LEFT gp_padl
#macro DEFAULT_INPUT_GP_DOWN gp_padd
#macro DEFAULT_INPUT_GP_UP gp_padu
#endregion
