extends Spatial

#IN-GAME STATS 
var update_highscore : int 
var update_kill_count : int
var update_death_count : int
var update_chips_count : int = 3


#SOME UI/GAME BEHAVIOR CONTROLS
var game_paused : bool 

var is_game_restarted : bool = false
var on_main_menu_called : bool = false


#GAME MEMORY VARS FOR IN-GAME STATS/ITEM[1] 

var best_score : int 
var kills : int
var deaths : int
var chips : int = update_chips_count



const FILE_PATH : String = 'user://x639dkx.xxi'
#game_data

func _ready():
	load_data()
	print('BEST SCORE: '+ str(best_score))
	print('KILLS: '+ str(kills))
	print('DEATHS: '+ str(deaths))
	print('CHIPS: '+ str(chips))

# warning-ignore:unused_argument



func _process(delta):
	update_stats()
	
		



func update_stats():
	#MEMORY UPDATER
	if update_highscore > best_score:
		best_score = update_highscore
		set_best_score(best_score)
		print('Best SCORE : '+ str(best_score))
	if update_kill_count > kills:
		kills = update_kill_count
		set_kill_count(kills)
	if update_death_count > deaths:
		deaths = update_death_count
		set_death_count(deaths)
	#-----END-----
	
	


#GAME DATA SAVE/LOAD FUNCTION

func load_data():
	var FILE = File.new()
	if !FILE.file_exists(FILE_PATH): return
	FILE.open(FILE_PATH, FILE.READ)

	best_score = FILE.get_var()
	kills = FILE.get_var()
	deaths = FILE.get_var()
	chips = FILE.get_var()

	FILE.close()

func save_data():
	var FILE = File.new()
	FILE.open(FILE_PATH, FILE.WRITE)
	FILE.store_var(best_score)
	FILE.store_var(kills)
	FILE.store_var(deaths)
	FILE.store_var(chips)
	FILE.close()

func set_best_score(value: int):
	best_score = value
	save_data()

func set_kill_count(value: int):
	kills = value
	save_data()

func set_death_count(value: int):
	deaths = value
	save_data()

func set_chips_count(value:int):
	chips = value
	save_data()
#-----END-----
