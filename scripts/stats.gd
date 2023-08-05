extends Control


var is_stats_screen : bool = false

onready var best_score  = $profile_mid/best_score
onready var chips  = $profile_top/chip_amount
onready var kills = $profile_mid/kills
onready var deaths = $profile_mid/deaths
onready var mobile_control_dialog = get_parent().get_node("InGameHud/mobile_controls/directions/rect/accept_dialogue")

#RANK ICONS
var zero_texture : = load("res://assets/sprites/ranks/zero.png")
var novice_texture :  = load("res://assets/sprites/ranks/novice.png")
var hero_texture :  =  load("res://assets/sprites/ranks/hero.png")
var captain_locus_texture : =load( "res://assets/sprites/ranks/captain_locus.png")

onready var pilot_name = $profile_top/player_name
onready var player_rank_icon = $profile_top/rank_icon
onready var player_rank_text = $profile_top/player_rank
#SELECTORS AND SELECTORS VARS

var current_selector = 0



onready var selector : Array = [$profile_top/player_icon/selector, $profile_top/chip_icon/selector, $profile_top/rank_icon/selector, $profile_mid/chart_icon/selector, $profile_mid/kills_icon/selector, $profile_mid/deaths_icon/selector, $container_h3/close/selector]


# warning-ignore:unused_argument
func _process(delta):
	
	set_stats_screen_ui()
	

	
	if is_stats_screen == true:
		mobile_control_dialog.show()
		$".".show()
		get_parent().get_node("main_menu").out_of_focus = true
		
		if Input.is_action_just_pressed("ui_left") and current_selector < 6:
			sound_system.sound_fx[4].play()
			current_selector += 1
			set_current_selection(current_selector)
		elif Input.is_action_just_pressed("ui_right") and current_selector > 0:
			current_selector -= 1
			sound_system.sound_fx[4].play()
			set_current_selection(current_selector)
		elif Input.is_action_just_pressed("ui_down"):
			sound_system.sound_fx[3].play()
			
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



func set_stats_screen_ui():
	pilot_name.text = str(mainScript.player_data["pilot_name"])
	best_score.text = "BEST SCORE -  " +str(mainScript.player_data["best_score"])
	chips.text = str(mainScript.player_data["chips"])
	kills.text = "KILLS - " +str(mainScript.player_data["kills"])
	deaths.text = "DEATHS - "+str(mainScript.player_data["deaths"])
	
	set_player_rank_ui()

func set_player_rank_ui():
	
	var rank : String = mainScript.player_data["player_rank"]
		
	match rank:
		"zero":
			player_rank_icon.texture = zero_texture
			player_rank_text.text = "ZERO"
			
		"novice":
			player_rank_icon.texture = novice_texture
			player_rank_text.text = "NOVICE"
			
		"hero":
			player_rank_icon.texture = hero_texture
			player_rank_text.text = "HERO"
			
		"captain_locus":
			player_rank_icon.texture = captain_locus_texture
			player_rank_text.text = "CAPTAIN LOCUS"



