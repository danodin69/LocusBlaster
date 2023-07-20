class_name Rank

extends Node

#RANKS OBJECTIVES COMPLETION
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


#RANKS OBJECTIVES
var zero_obj : String = "SHIP POWER\n- LOW BULLET DAMAGE\n- MAXIMUM OF ONE SHIELD\n- SHIP REPAIR DISABLED\n\nMAIN OBJECTIVE\n- DESTROY 50 ENEMY SHIPS IN ONE FLIGHT"

var novice_obj : String = "SHIP POWER\n- LOW BULLET DAMAGE\n- MAXIMUM OF TWO SHIELDS\n- SHIP REPAIR ACTIVE\n\nMAIN OBJECTIVE\n- DESTROY 150 ENEMY SHIPS IN ONE FLIGHT\n- DESTROY 3 SPINNER SHIP"

var hero_obj : String = "SHIP POWER\n- MEDIUM BULLET DAMAGE\n- MAXIMUM OF TWO SHIELDs\n- SHIP REPAIR ACTIVE\n\nMAIN OBJECTIVE\n- DESTROY 500 ENEMY SHIPS IN ONE FLIGHT\n- Destroy 3 BOSS SHPS\n- DESTROY 10 SPINNER SHIP\n- DESTROY 10 DODGER SHIPS"

var captain_obj : String = "SHIP POWER\n- MAXMUM BULLET DAMAGE\n- MAXIMUM OF ONE SHIELD\n- NO SHIP REPAIR\n\nMAIN OBJECTIVE\n- BLAST FOREVER"

	
func manager():
	var rank : String = mainScript.player_rank
#	rank = ""
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
	
	allowed_bullet_damage = 15
	allowed_maximum_shield = 1
	is_ship_repair_allowed = false
	
	if kills_per_game >= 10:
		
		kills_per_game = 0
		mainScript.set_player_rank("novice")
		novice = true
		
		mainScript.is_player_promoted = true
		print("promo: ",mainScript.is_player_promoted)
		
		
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

	
		
	allowed_bullet_damage = 21
	allowed_maximum_shield = 2
	is_ship_repair_allowed = true
	
	if kills_per_game >= 20:
		kills_per_game = 0
		
		novice = false
		
		mainScript.set_player_rank("hero")
		hero = true
		
		mainScript.is_player_promoted = true
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

	
	
	
	allowed_bullet_damage = 41
	allowed_maximum_shield = 2
	is_ship_repair_allowed = true
	
	if kills_per_game >= 30 :
#		&& boss_kills >= 3
		kills_per_game = 0
		hero = false
		mainScript.set_player_rank("captain_locus")
		captain_locus = true
		
		mainScript.is_player_promoted = true
		print(">>>PROMOTED TO CAPTAIN LOCUS")
		
func start_rank_captain_locus_objective():
	captain_locus = true
	is_ship_repair_allowed = true
	allowed_maximum_shield = 3
	allowed_bullet_damage = 100

