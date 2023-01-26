extends Control

#onready var main = get_tree().current_scene
var out_of_focus : bool = false
var pause_scene = load("res://Main.tscn")
onready var selector1 = $continue/selector
onready var selector2 = $settings/selector
onready var selector3 = $quit/selector

var current_selector = 0
export var game_paused = false
func _ready():
	set_current_selection(0)
	is_game_paused(false)
# warning-ignore:unused_argument
func _process(delta):
	is_game_paused(game_paused)
	

func selection_handler(_current_selection):
	
	if _current_selection == 0:
		get_tree().paused = false
		game_paused = false
		$".".hide()
		
		#$Timer.start()
	elif _current_selection == 1:
		
		$".".hide()
		
		get_parent().get_node("settings").is_settings_dialog_pause = true
		
		print("settings")
	elif _current_selection == 2:
		mainScript.on_main_menu_called = true
		
		get_parent().restart_game()
		
		print("MENU")
		
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
	#is_game_paused(false)
	queue_free()
	
func is_game_paused(var isPaused : bool):
	if isPaused == true:
		if out_of_focus == false:
			if Input.is_action_just_pressed("ui_down") and current_selector < 2:
				$select.play()
				current_selector += 1
				set_current_selection(current_selector)
			elif Input.is_action_just_pressed("ui_up") and current_selector > 0:
				current_selector -= 1
				$select.play()
				set_current_selection(current_selector)
			elif Input.is_action_just_pressed("shoot"):
				$choosen.play()
				selection_handler(current_selector)
