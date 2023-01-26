extends Control
"""
Dan: I might have done some magic in this script
	 in case future me comes back here

"""
var is_settings_dialog_menu : bool = false
var is_settings_dialog_pause : bool = false
onready var selector1 = $PopupPanel/music/selector
onready var selector2 = $PopupPanel/sounds/selector
onready var selector3 = $PopupPanel/close/selector

onready var music_switch =$PopupPanel/music/switch
onready var sound_switch = $PopupPanel/sounds/switch 

var current_selector = 0

var m : int = 1
var e : int = 1


func _ready():
#	$PopupPanel.show()
	AudioServer.set_bus_layout(load("res://default_bus_layout.tres"))
	set_current_selection(0)

# warning-ignore:unused_argument
func _process(delta):
	
	handle_main_menu_input()
	handle_pause_menu_input()


func handle_main_menu_input():
	if is_settings_dialog_menu == true:
		get_parent().get_node("main_menu").out_of_focus = true
		$PopupPanel.show()
		if Input.is_action_just_pressed("ui_down") and current_selector < 2:
			$select.play()
			current_selector += 1
			set_current_selection(current_selector)
		elif Input.is_action_just_pressed("ui_up") and current_selector > 0:
			current_selector -= 1
			$select.play()
			set_current_selection(current_selector)
		elif Input.is_action_just_pressed("enter"):
			$choosen.play()
			
			
			
			selection_handler_main_menu(current_selector)
			


func selection_handler_main_menu(_current_selection):
	if _current_selection == 0:
		
		toggle_music_button()
		
	elif _current_selection == 1:
		toggle_effects_button()
	elif _current_selection == 2:
		$PopupPanel.hide()
		get_parent().get_node("main_menu").out_of_focus = false
		is_settings_dialog_menu = false


func handle_pause_menu_input():
	if is_settings_dialog_pause == true:
		get_parent().get_node("pause_HUD").out_of_focus = true
		$PopupPanel.show()
		if Input.is_action_just_pressed("ui_down") and current_selector < 2:
			$select.play()
			current_selector += 1
			set_current_selection(current_selector)
		elif Input.is_action_just_pressed("ui_up") and current_selector > 0:
			current_selector -= 1
			$select.play()
			set_current_selection(current_selector)
		elif Input.is_action_just_pressed("enter"):

			$choosen.play()
			
			
			
			selection_handler_pause_menu(current_selector)
			
func selection_handler_pause_menu(_current_selection):
	if _current_selection == 0:
		
		toggle_music_button()
		
	elif _current_selection == 1:
		toggle_effects_button()
	elif _current_selection == 2:
		$PopupPanel.hide()
		get_parent().get_node("pause_HUD").show()
		get_parent().get_node("pause_HUD").out_of_focus = false
		is_settings_dialog_pause = false
		_current_selection = 0
		
func set_current_selection(_current_selection):
	selector1.hide()
	selector2.hide()
	selector3.hide()
	
	
	if _current_selection == 0:
		selector1.show()
	elif _current_selection == 1:
		selector2.show()
	elif _current_selection == 2:
		selector3.show()


func _on_Timer_timeout():
	get_parent().get_node("InGameHud").show()
	get_parent().get_node("InGameHud/pilot_hud/CanvasLayer").show()
	get_parent().get_node("player").game_started = true
	queue_free()



func toggle_music_button():
	m = m * -1
	print(m)
	if m == 1:
		music_switch.text = "  OFF"
		AudioServer.set_bus_mute(1,false)		
	elif m == -1: 
		music_switch.text = "   ON"
		AudioServer.set_bus_mute(1,true)
	






func toggle_effects_button():
	e = e * -1
	print(e)
	if e == 1:
		sound_switch.text = "  OFF"
		AudioServer.set_bus_mute(2,false)		
	elif e == -1: 
		sound_switch.text = "   ON"
		AudioServer.set_bus_mute(2,true)

