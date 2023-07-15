class_name Rank

extends Node

#RANKS
var zero : bool = false
var novice : bool = false
var hero : bool = false
var captain_locus : bool = false


#RANKS TEXTURE




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
		print("Player Rank Set: ", mainScript.player_rank)
		
	match rank:
		"zero":
			start_rank_zero_objective()
			
		"novice":
			start_rank_novice_objective()
			
		"hero":
			start_rank_hero_objective()
			
		"captain_locus":
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
	zero = true
	
	allowed_bullet_damage = 15
	allowed_maximum_shield = 1
	is_ship_repair_allowed = false
	if kills_per_game >= 10:
		zero = false
		kills_per_game = 0
		mainScript.set_player_rank("novice")
		start_rank_novice_objective()
		print(">>>PROMOTED TO NOVICE")

	
func start_rank_novice_objective():
	"""
	  Rank Novice
	| Attributes |

	- 3 BULLETS KILLS ONE ENEMY
	- MAXIMUM OF TWO SHIELDS
	- SHIP REPAIR CAPABILITIES

	| Promotion |

	- KILL 666 ENEMIES IN ONE FLIGHT

"""
	novice = true
	
		
	allowed_bullet_damage = 21
	allowed_maximum_shield = 2
	is_ship_repair_allowed = true
	
	if kills_per_game >= 50:
		kills_per_game = 0
		novice = false
		mainScript.set_player_rank("hero")
		start_rank_hero_objective()
		print(">>>PROMOTED TO HERO")
	
func start_rank_hero_objective():
	"""
	  Rank Hero
	| Attributes |

	- 2 BULLETS KILLS ONE ENEMY
	- MAXIMUM OF TWO SHIELDS
	- SHIP REPAIR CAPABILITIES

	| Promotion |

	- KILL 666 ENEMIES IN ONE FLIGHT

"""
	hero = true
	
	
	
	allowed_bullet_damage = 50
	allowed_maximum_shield = 2
	is_ship_repair_allowed = true
	
	if kills_per_game >= 10 && boss_kills >= 3:
		kills_per_game = 0
		hero = false
		mainScript.set_player_rank("captain_locus")
		print(">>>PROMOTED TO CAPTAIN LOCUS")
		
func start_rank_captain_locus_objective():
	

	
	
	captain_locus = true
	is_ship_repair_allowed = true
	allowed_maximum_shield = 3
	allowed_bullet_damage = 100

