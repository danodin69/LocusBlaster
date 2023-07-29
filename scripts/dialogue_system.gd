class_name Dialogue_System

extends Control

var rank_system : = Rank.new()

#RANK ICONS
var zero_texture : = load("res://assets/sprites/ranks/zero.png")
var novice_texture :  = load("res://assets/sprites/ranks/novice.png")
var hero_texture :  =  load("res://assets/sprites/ranks/hero.png")
var captain_locus_texture : =load( "res://assets/sprites/ranks/captain_locus.png")

onready var close_all_dialogues = $d_sys_out
onready var close_promo_dialogue = $d_sys_out_promo

#OBJECTIVES L.S

onready var obj_dialogue :Node= $rank_objective
onready var obj_rank_icon :Node= $rank_objective/TextureRect/left_side/rank_icon
onready var obj_rank_name :Node= $rank_objective/TextureRect/left_side/rank_name

#OBJECTIVES R.S

onready var obj_missions :Node= $rank_objective/TextureRect/right_side/objectives
onready var obj_accept :Node = $rank_objective/TextureRect/right_side/begin

#PROMOTION
onready var promotion_dialogue :Node= $promotion
onready var promo_rank_icon :Node = $promotion/TextureRect/center/rank_icon
onready var promo_rank_name :Node = $promotion/TextureRect/center/rank_name
onready var promo_accept :Node = $promotion/TextureRect/center/accept

#CONTINUE DIALOGUE

onready var continue_options_dialogue :Node= $continue_options

#ACTIVE DIALOGUES

var is_objective_dialogue_active : bool =  false 
var is_promotion_dialogue_active : bool =  false 
var is_continue_dialogue_active : bool = false


var current_selector : int = 0

onready var selector1=$continue_options/TextureRect/selectors/selector_1

onready var selector2 = $continue_options/TextureRect/selectors/selector_2

onready var selector3 = $continue_options/TextureRect/selectors/selector_3

onready var chip_count = $continue_options/TextureRect/chip_label


# TODO : REMEMBER TO MAKE ENTER KEY WORK ONLY BASED ON CONDITION THAT THE DIALOGUE SYSTEM IS IN USE


func _process(_delta):
	manager(mainScript.is_player_promoted)
	input_manager()
	update_chip_count()
	

func manager(value = false):
	
	var _is_Promoted : bool = value
	
	var rank : String = mainScript.player_data["player_rank"]
		
	match rank:
		"zero":
			obj_rank_icon.texture = zero_texture
			obj_rank_name.text = "ZERO"
			obj_missions.text = rank_system.zero_obj
			
			
			
		"novice":
			obj_rank_icon.texture = novice_texture
			obj_rank_name.text = "NOVICE"
			obj_missions.text = rank_system.novice_obj
			#
			promo_rank_name.text = "NOVICE"
			promo_rank_icon.texture = novice_texture
			
			
		"hero":
			obj_rank_icon.texture = hero_texture
			obj_rank_name.text = "HERO"
			obj_missions.text = rank_system.hero_obj
			#
			promo_rank_icon.texture = hero_texture
			promo_rank_name.text = "HERO"
			
			
		"captain_locus":
			obj_rank_icon.texture = captain_locus_texture
			obj_rank_name.text = "CAPTAIN LOCUS"
			obj_missions.text = rank_system.captain_obj
			
			promo_rank_icon.texture = captain_locus_texture
			promo_rank_name.text = "CAPTAIN LOCUS"
		
	if value==true:
		rank_promotion_dialogue()
		mainScript.is_player_promoted = false
		print("value: false")

func rank_objective_dialogue():
	$".".show()
	obj_dialogue.show()
	close_all_dialogues.show()
	get_parent().pause()
	


func rank_promotion_dialogue():
	$".".show()
	promotion_dialogue.show()
	close_promo_dialogue.show()
	get_parent().pause()

func continue_game_dialogue():
	sound_system.sound_fx[5].play()
	$".".show()
	is_continue_dialogue_active = true
	continue_options_dialogue.show()
	
func close_continue_options_dialogue():
	is_continue_dialogue_active = false
	continue_options_dialogue.hide()
	$".".hide()
		
func input_manager():
	handle_continue_options_input()
	
	if Input.is_action_just_pressed("enter"):
		if obj_dialogue.visible == true:
			_on_d_sys_out_pressed()
		elif promotion_dialogue.visible == true:
			_on_d_sys_out_promo_pressed()

func _on_d_sys_out_pressed():
	get_parent().continue_game()
	obj_dialogue.hide()
	sound_system.sound_fx[3].play()
	promotion_dialogue.hide()
	$".".hide()


func _on_d_sys_out_promo_pressed():
	mainScript.is_player_promoted = false
	
	
	close_promo_dialogue.hide()
	
	close_all_dialogues.show()
	
	obj_dialogue.show()
	promotion_dialogue.hide()
	sound_system.sound_fx[3].play()
	
func handle_continue_options_input():
	if is_continue_dialogue_active == true:
		if Input.is_action_just_pressed("ui_right") and current_selector < 2:
			sound_system.sound_fx[4].play()
			current_selector += 1
			set_current_selection(current_selector)
		elif Input.is_action_just_pressed("ui_left") and current_selector > 0:
			current_selector -= 1
			sound_system.sound_fx[4].play()
			set_current_selection(current_selector)
		elif Input.is_action_just_pressed("ui_down"):
			sound_system.sound_fx[3].play()
			
			
			
			selection_handler(current_selector)
			


func selection_handler(_current_selection):
	if _current_selection == 0:
		if mainScript.player_data["chips"] > 0:
			get_parent().is_chip_used = true
			start_revive_timer()
		
	elif _current_selection == 1:
		pass
	elif _current_selection == 2:
		get_parent().show_game_over_screen()
		close_continue_options_dialogue()
		


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



func update_chip_count():
	chip_count.text = str("CHIPS(",mainScript.player_data["chips"],")")

func start_revive_timer():
	close_continue_options_dialogue()
	$".".show()
	$revive_timer.show()
	$revive_timer/revive_timer.play("timer")

func _revive():
	$".".hide()
	get_parent().revive_player()
	sound_system.sound_fx[1].play()
	get_parent().continue_game()
