class_name Rank

extends Node

#RANKS
var zero : bool = false
var novice : bool = false
var hero : bool = false
var captain_locus : bool = false

#SHIP LIMITATIONS PER RANK

var allowed_bullet_damage : int
var allowed_maximum_shield : int
var is_ship_repair_allowed : bool

#OBJECTIVES

var kills_per_game : int
var boss_kills : int 

	
func manager():
	
	var rank : String = mainScript.player_rank
	if rank == "":
		mainScript.set_player_rank("zero")
		print("Player Rank Set: ",mainScript.player_rank)
		
	match rank:
		"zero":
			zero = true
			
		"novice":
			novice = true
			
		"hero":
			hero = true
			
		"captain_locus":
			captain_locus = true

			
	if zero == true:
		start_rank_zero_objective()
		
	elif novice == true:
		start_rank_novice_objective()
		
	elif hero == true :
		start_rank_hero_objective()
		
	elif captain_locus == true:
		start_rank_captain_locus_objective()
		

func start_rank_zero_objective():
	"""
	  Rank Zero 
	| Attributes |

	- 4 BULLETS KILLS ONE ENEMY
	- MAXIMUM OF ONE SHIELD
	- NO SHIP REPAIR CAPABILITIES 

	| Promotion |

	- KILL 50 ENEMIES IN ONE FLIGHT

"""
	
	allowed_bullet_damage = 25
	allowed_maximum_shield = 1
	is_ship_repair_allowed = false
	if kills_per_game >= 10:
		zero = false
		kills_per_game = 0
		mainScript.set_player_rank("novice")
		start_rank_novice_objective()
		print(">>>PROMOTED TO NOVICE")

	
func start_rank_novice_objective():
	
	novice = true

	allowed_bullet_damage = 33
	if kills_per_game >= 50:
		kills_per_game = 0
		novice = false
		mainScript.set_player_rank("hero")
		start_rank_hero_objective()
		print(">>>PROMOTED TO HERO")
	
func start_rank_hero_objective():
	hero = true

	allowed_bullet_damage = 50
	if kills_per_game >= 3333 && boss_kills >= 3:
		kills_per_game = 0
		hero = false
		mainScript.set_player_rank("captain_locus")
		print(">>>PROMOTED TO CAPTAIN LOCUS")
		
func start_rank_captain_locus_objective():
	captain_locus = true

	allowed_bullet_damage = 100

