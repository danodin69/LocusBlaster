extends Control


# """
# Dan: I might have done some magic in this script
# 	 in case future me comes back here
	


# """

var m : int = 1
var e : int = 1
var t : int = 1

var is_settings_dialog_menu : bool = false
var is_settings_dialog_pause : bool = false

onready var controls_hud = get_parent().get_node("InGameHud")

onready var selector1 = $PopupPanel/music/selector
onready var selector2 = $PopupPanel/sounds/selector
onready var selector3 = $PopupPanel/close/selector
onready var selector4 = $PopupPanel/invert_controls/selector

onready var music_switch =$PopupPanel/music/switch
onready var sound_switch = $PopupPanel/sounds/switch 

onready var invert_controls = $PopupPanel/invert_controls/switch

var current_selector = 0


onready var mobile_control_dialog = get_parent().get_node("InGameHud/mobile_controls/directions/rect/accept_dialogue") #This node makes it possible to close dialogs

func _ready():
#	$PopupPanel.show()
	set_current_selection(0)


func _process(_delta):
	
	handle_main_menu_input()
	handle_pause_menu_input()
	
	set_ui()

func handle_main_menu_input():
	if is_settings_dialog_menu == true:
		mobile_control_dialog.show()
		get_parent().get_node("main_menu").out_of_focus = true
		$PopupPanel.show()
		if Input.is_action_just_pressed("ui_right") and current_selector < 3:
			sound_system.sound_fx[4].play()
			current_selector += 1
			set_current_selection(current_selector)
		elif Input.is_action_just_pressed("ui_left") and current_selector > 0:
			current_selector -= 1
			sound_system.sound_fx[4].play()
			set_current_selection(current_selector)
		elif Input.is_action_just_pressed("ui_down"):
			sound_system.sound_fx[3].play()
			
			
			
			selection_handler_main_menu(current_selector)
			


func selection_handler_main_menu(_current_selection):
	if _current_selection == 0:
		
		toggle_music_button()
		
	elif _current_selection == 1:
		toggle_effects_button()
	elif _current_selection == 2:
		toggle_invert_controls()
#		invert
	elif _current_selection == 3:
		$PopupPanel.hide()
		get_parent().get_node("main_menu").out_of_focus = false
		is_settings_dialog_menu = false
		mobile_control_dialog.hide()


func handle_pause_menu_input():
	if is_settings_dialog_pause == true:
		get_parent().toggle_accept_button_mobile(true)
		mobile_control_dialog.show()
		get_parent().get_node("pause_HUD").out_of_focus = true
		$PopupPanel.show()
		if Input.is_action_just_pressed("ui_right") and current_selector < 3:
			sound_system.sound_fx[4].play()
			current_selector += 1
			set_current_selection(current_selector)
		elif Input.is_action_just_pressed("ui_left") and current_selector > 0:
			current_selector -= 1
			sound_system.sound_fx[4].play()
			set_current_selection(current_selector)
		elif Input.is_action_just_pressed("ui_down"):

			sound_system.sound_fx[3].play()
			
			
			
			selection_handler_pause_menu(current_selector)
			
func selection_handler_pause_menu(_current_selection):
	if _current_selection == 0:
		
		toggle_music_button()
		
	elif _current_selection == 1:
		toggle_effects_button()
		
	elif _current_selection == 2 :
		toggle_invert_controls()
#		invert
	elif _current_selection == 3:
		$PopupPanel.hide()
		get_parent().get_node("pause_HUD").show()
		get_parent().get_node("pause_HUD").out_of_focus = false
		is_settings_dialog_pause = false
		_current_selection = 0
		mobile_control_dialog.hide()
		get_parent().toggle_accept_button_mobile(false)
		
func set_current_selection(_current_selection):
	selector1.hide()
	selector2.hide()
	selector3.hide()
	selector4.hide()
	
	
	if _current_selection == 0:
		selector1.show()
	elif _current_selection == 1:
		selector2.show()
	elif _current_selection == 3:
		selector3.show()
	elif _current_selection == 2:
		selector4.show()





func toggle_music_button():
	m = m * -1
	if m == 1:
		
		mainScript.music_on = true
		AudioServer.set_bus_mute(1,mainScript.music_on)
		
		mainScript.save_settings()
			
	elif m == -1: 
		
		mainScript.music_on = false
		AudioServer.set_bus_mute(1,mainScript.music_on)	
		mainScript.save_settings()
	






func toggle_effects_button():
	e = e * -1

	if e == 1:
		
		mainScript.fx_on = false
		AudioServer.set_bus_mute(2,mainScript.fx_on)
		mainScript.save_settings()
		
	elif e == -1: 
		
		mainScript.fx_on = true
		AudioServer.set_bus_mute(2,mainScript.fx_on)
		mainScript.save_settings()
		
func toggle_invert_controls():
	t = t * -1

	if t == 1:

		mainScript.inverted_controls = false
		controls_hud.invert_mobile_controls(mainScript.inverted_controls)

		
	elif t == -1:
		
		print_debug("INVERT CONTROL - TRUE")
		mainScript.inverted_controls = true
		controls_hud.invert_mobile_controls(mainScript.inverted_controls)
		


func set_ui():
	
	
	
	match mainScript.inverted_controls:
		true:
			t = -1
			invert_controls.text = "   + o "
		false:
			t = 1
			invert_controls.text = "   o + "
			
			
	match mainScript.music_on:
		true:
			m = 1
			music_switch.text = "   OFF"
			
		false:
			m = -1
			music_switch.text = "    ON"
			
			
	match mainScript.fx_on:
		true:
			sound_switch.text = "   OFF"
			
		false:
			sound_switch.text = "    ON"

func _on_Timer_timeout():
	get_parent().get_node("InGameHud").show()
	get_parent().get_node("InGameHud/pilot_hud/CanvasLayer").show()
	get_parent().get_node("player").game_started = true
	queue_free()