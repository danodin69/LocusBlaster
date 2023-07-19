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


# TODO : REMEMBER TO MAKE ENTER KEY WORK ONLY BASED ON CONDITION THAT THE DIALOGUE SYSTEM IS IN USE


	
func _process(delta):
	manager(mainScript.is_player_promoted)
	input_manager()

func manager(value = false):
	var is_Promoted : bool = value
	
	var rank : String = mainScript.player_rank
		
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



func input_manager():
	if Input.is_action_just_pressed("enter"):
		if obj_dialogue.visible == true:
			_on_d_sys_out_pressed()
		elif promotion_dialogue.visible == true:
			_on_d_sys_out_promo_pressed()

func _on_d_sys_out_pressed():
	get_parent().continue_game()
	obj_dialogue.hide()
	
	promotion_dialogue.hide()
	print("Clicked")
	$".".hide()


func _on_d_sys_out_promo_pressed():
	mainScript.is_player_promoted = false
	
	
	close_promo_dialogue.hide()
	
	close_all_dialogues.show()
	
	obj_dialogue.show()
	promotion_dialogue.hide()
