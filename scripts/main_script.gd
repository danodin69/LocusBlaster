extends Spatial

var update_highscore : int 
var game_paused : bool 

var is_game_restarted : bool = false
var on_main_menu_called : bool = false
var best_score : int = 0 setget set_best_score

const file_path : String = 'user://x639dkx.ddp'
#game_data

func _ready():
	load_score_data()
	print('BEST SCORE: DEFAULT IS : '+ str(best_score))

# warning-ignore:unused_argument
func _process(delta):
	if update_highscore > best_score:
		best_score = update_highscore
		set_best_score(best_score)
		print('Best SCORE : '+ str(best_score))



#BEST SCORE LOAD AND SAVE FUNCTIONS

func load_score_data():
	var FILE = File.new()
	if !FILE.file_exists(file_path): return
	FILE.open(file_path, FILE.READ)
	
	best_score = FILE.get_var()
	
	FILE.close()

func save_score_data():
	var FILE = File.new()
	FILE.open(file_path, FILE.WRITE)
	FILE.store_var(best_score)
	FILE.close()

func set_best_score(value):
	best_score = value
	save_score_data()

