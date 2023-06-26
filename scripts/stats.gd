extends Control


var is_stats_screen : bool = false
onready var best_score  = $profile_mid/best_score
onready var chips  = $profile_top/chip_amount
onready var kills = $profile_mid/kills
onready var deaths = $profile_mid/deaths
onready var mobile_control_dialog = get_parent().get_node("InGameHud/mobile_controls/directions/accept_dialog")



#SELECTORS AND SELECTORS VARS

var current_selector = 0



onready var selector : Array = [$profile_top/player_icon/selector, $profile_top/chip_icon/selector, $profile_top/rank_icon/selector, $profile_mid/chart_icon/selector, $profile_mid/kills_icon/selector, $profile_mid/deaths_icon/selector, $container_h3/close/selector]


func _process(delta):
	best_score.text = "BEST SCORE -  " +str(mainScript.best_score)
	chips.text = str(mainScript.chips)
	kills.text = "KILLS - " +str(mainScript.kills)
	deaths.text = "DEATHS - "+str(mainScript.deaths)
	if is_stats_screen == true:
		mobile_control_dialog.show()
		$".".show()
		get_parent().get_node("main_menu").out_of_focus = true
		
		if Input.is_action_just_pressed("ui_up") and current_selector < 6:
			$select.play()
			current_selector += 1
			set_current_selection(current_selector)
		elif Input.is_action_just_pressed("ui_down") and current_selector > 0:
			current_selector -= 1
			$select.play()
			set_current_selection(current_selector)
		elif Input.is_action_just_pressed("enter"):
			$choosen.play()
			selection_handler(current_selector)
#		if Input.is_action_just_pressed("enter"):
#			mobile_control_dialog.hide()
#			$".".hide()
#			$choosen.play()
#			get_parent().get_node("main_menu").out_of_focus = false
#			is_stats_screen = false
			
			


func selection_handler(_current_selection):
	if _current_selection == 0:
		mobile_control_dialog.hide()
		$".".hide()
		$choosen.play()
		get_parent().get_node("main_menu").out_of_focus = false
		is_stats_screen = false
		
	elif _current_selection == 1:
		pass
	
	elif _current_selection == 2:
		pass
	elif _current_selection == 3:
		pass
		
		
		
func set_current_selection(_current_selection):
	selector[0].hide()
	selector[1].hide()
	selector[2].hide()
	selector[3].hide()
	selector[4].hide()
	selector[5].hide()
	selector[6].hide()
	
	if _current_selection == 0:
		selector[6].show()
	elif _current_selection == 1:
		selector[5].show()
	elif _current_selection == 2:
		selector[4].show()
	elif _current_selection == 3:
		selector[3].show()
	elif _current_selection == 4:
		selector[2].show()
	elif _current_selection == 5:
		selector[1].show()
	elif _current_selection == 6:
		selector[0].show()
		


