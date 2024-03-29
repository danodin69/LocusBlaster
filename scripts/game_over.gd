extends Control


var game_over : bool = false
var best_score : int = mainScript.best_score

var current_selector : int = 0
onready var selector1 = $score/restart/selector
onready var selector2 = $score/menu/selector

onready var best_score_text = $score/best_score


onready var mobile_in_game_control_shooter = get_parent().get_node("InGameHud/mobile_controls/shooter")
onready var mobile_in_game_control_joystick = get_parent().get_node("InGameHud/mobile_controls/virtual_joystick")
onready var mobile_pause_button = get_parent().get_node("InGameHud/mobile_controls/pause")
onready var mobile_ui_directions = get_parent().get_node("InGameHud/mobile_controls/directions")


func _ready():
	set_current_selection(0)
	is_game_over(false)

# warning-ignore:unused_argument
func _process(delta):
	is_game_over(game_over)
	best_score_text.text = str(mainScript.player_data["best_score"])
	
		


func is_game_over(var _is_game_over : bool):
	
	if _is_game_over == true:
		
		
		get_parent().toggle_pilot_controls(false)
		
		
		
		if Input.is_action_just_pressed("ui_right") and current_selector < 1:
			sound_system.sound_fx[4].play()
			current_selector += 1
			set_current_selection(current_selector)
		elif Input.is_action_just_pressed("ui_left") and current_selector > 0:
			current_selector -= 1
			sound_system.sound_fx[4].play()
			set_current_selection(current_selector)
		elif Input.is_action_just_pressed("ui_up"):
			sound_system.sound_fx[3].play()
			
			sound_system.music[1].stop()

			selection_handler(current_selector)
			
func selection_handler(_current_selection):
	
	if _current_selection == 0:
		mainScript.is_game_restarted = true
		
		get_parent().restart_game()
		
		get_parent().toggle_pilot_controls(true)
		
		print_debug("GAME RESTARTED")
		
	elif _current_selection == 1:
		
		
		mainScript.on_main_menu_called = true
		Loader.load_scene("res://Main.tscn")
		get_parent().restart_game()
		
		
		print_debug("GAME MENU LOADED")
	
func set_current_selection(_current_selection):
	selector1.hide()
	selector2.hide()
	if _current_selection == 0:
		selector1.show()
	elif _current_selection == 1:
		selector2.show()
