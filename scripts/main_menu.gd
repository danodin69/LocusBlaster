extends Control

var game_started : bool = false
var out_of_focus : bool = false
var current_selector : int = 0

onready var selector1 : Node = $play/selector
onready var selector2 : Node = $highscores/selector
onready var selector3 : Node = $settings/selector
onready var selector4 : Node = $source/selector


onready var mobile_in_game_control_shooter : Node = get_parent().get_node("InGameHud/mobile_controls/shooter")
onready var mobile_in_game_control_joystick : Node= get_parent().get_node("InGameHud/mobile_controls/virtual_joystick")
onready var mobile_pause_button : Node = get_parent().get_node("InGameHud/mobile_controls/pause")
onready var mobile_ui_controls : Node = get_parent().get_node("InGameHud/mobile_controls/directions")



func _ready():
	set_current_selection(0)

func _process(_delta):
	
	if out_of_focus == false:
		get_parent().toggle_accept_button_mobile(false)
		if Input.is_action_just_pressed("ui_right") and current_selector < 3:
			sound_system.sound_fx[4].play()
			current_selector += 1
			set_current_selection(current_selector)
		elif Input.is_action_just_pressed("ui_left") and current_selector > 0:
			current_selector -= 1
			sound_system.sound_fx[4].play()
			set_current_selection(current_selector)
		elif Input.is_action_just_pressed("ui_up"):
			sound_system.sound_fx[3].play()
			selection_handler(current_selector)
			get_parent().toggle_accept_button_mobile(true)
			

func selection_handler(_current_selection):
	if _current_selection == 0:
		
		$Timer.start()
		
	elif _current_selection == 1:
		get_parent().get_node("Stats").is_stats_screen = true
		
	
	elif _current_selection == 2:
		get_parent().get_node("settings").is_settings_dialog_menu = true
		print("settings")
	elif _current_selection == 3:
		get_parent().get_node("source_canvas/source").is_source_screen = true
		
		
func set_current_selection(_current_selection):
	selector1.hide()
	selector2.hide()
	selector3.hide()
	selector4.hide()
	
	if _current_selection == 0:
		selector1.show()
	elif _current_selection == 1:
		selector2.show()
	elif _current_selection == 2:
		selector3.show()
	elif _current_selection == 3:
		selector4.show()


func _on_Timer_timeout():
	get_parent().get_node("pilot_hud").show()
	get_parent().get_node("InGameHud").show()
	get_parent().get_node("player").game_started = true
	get_parent().toggle_pilot_controls(true)
	get_parent().show_objective_dialogue()
	queue_free()
