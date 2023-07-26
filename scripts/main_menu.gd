extends Control

var game_started : bool = false
var out_of_focus : bool = false
onready var selector1 = $play/selector
onready var selector2 = $highscores/selector
onready var selector3 = $settings/selector
onready var selector4 = $source/selector

var current_selector = 0
onready var mobile_in_game_control_shooter = get_parent().get_node("InGameHud/mobile_controls/shooter")
onready var mobile_in_game_control_joystick = get_parent().get_node("InGameHud/mobile_controls/Virtual joystick")
onready var mobile_pause_button = get_parent().get_node("InGameHud/mobile_controls/pause")
onready var mobile_ui_controls = get_parent().get_node("InGameHud/mobile_controls/directions")
func _ready():
	#$menu_music.play()
	mobile_ui_controls.show()
	set_current_selection(0)

# warning-ignore:unused_argument
func _process(delta):
	if out_of_focus == false:
		if Input.is_action_just_pressed("ui_right") and current_selector < 3:
			$select.play()
			current_selector += 1
			set_current_selection(current_selector)
		elif Input.is_action_just_pressed("ui_left") and current_selector > 0:
			current_selector -= 1
			$select.play()
			set_current_selection(current_selector)
		elif Input.is_action_just_pressed("ui_up"):
			$choosen.play()
			selection_handler(current_selector)

func selection_handler(_current_selection):
	if _current_selection == 0:
		#get_tree().change_scene("res://Main.tscn")
		
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
	mobile_in_game_control_joystick.show()
	mobile_in_game_control_shooter.show()
	mobile_pause_button.show()
	mobile_ui_controls.hide()
	get_parent().show_objective_dialogue()
	queue_free()


func _on_play_pressed():
	$Timer.start()


func _on_highscores_pressed():
	get_parent().get_node("Stats").is_stats_screen = true


func _on_settings_pressed():
	get_parent().get_node("settings").is_settings_dialog_menu = true
