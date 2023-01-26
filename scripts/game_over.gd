extends Control
var game_over : bool = false
onready var selector1 = $score/restart/selector
onready var selector2 = $score/menu/selector
var best_score = mainScript.best_score
onready var best_score_text = $score/best_score
var current_selector = 0

func _ready():
	set_current_selection(0)
	is_game_over(false)

# warning-ignore:unused_argument
func _process(delta):
	is_game_over(game_over)
	best_score_text.text = str(mainScript.best_score)
	
		


func is_game_over(var isGameOver : bool):
	if isGameOver == true:
		if Input.is_action_just_pressed("ui_right") and current_selector < 1:
			$select.play()
			current_selector += 1
			set_current_selection(current_selector)
		elif Input.is_action_just_pressed("ui_left") and current_selector > 0:
			current_selector -= 1
			$select.play()
			set_current_selection(current_selector)
		elif Input.is_action_just_pressed("ui_accept"):
			$choosen.play()
			selection_handler(current_selector)
			
func selection_handler(_current_selection):
	
	if _current_selection == 0:
		mainScript.is_game_restarted = true
		
		get_parent().restart_game()
		
		print("RESTART")
		
	elif _current_selection == 1:
		mainScript.on_main_menu_called = true
		
		get_parent().restart_game()
		
		print("MENU")
	
func set_current_selection(_current_selection):
	selector1.hide()
	selector2.hide()
	if _current_selection == 0:
		selector1.show()
	elif _current_selection == 1:
		selector2.show()
