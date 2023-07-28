extends Spatial

#IN-GAME STATS 
var update_highscore : float 
var update_kill_count : int
var update_death_count : int
var update_chips_count : int 


#SOME UI/GAME BEHAVIOR CONTROLS
var game_paused : bool 

var is_game_restarted : bool = false
var on_main_menu_called : bool = false


#GAME MEMORY VARS FOR IN-GAME STATS/ITEM[1] 

var pilot_name : String
var best_score : int 
var kills : int
var deaths : int
var chips : int = update_chips_count
var player_rank : String

#Rank System 
var rank : Rank = Rank.new()



var is_player_promoted : bool = false


const FILE_PATH : String = 'user://x639dkx.xxx'
const NEW_FILE_PATH : String = 'res://x369x.odngw'
#game_data

func _ready():
	audio_manager()
	load_game_data()
	rank.manager()
	print(pass_key)
	
# FOR RESETS ONLY , REMOVE IN FINAL VERSION !	
#	player_data["kills"] = kills
#	player_data["player_rank"] = player_rank
#	player_data["best_score"] = 2345
#	player_data["chips"] = chips
#	player_data["deaths"] = deaths
	player_data["pilot_name"] = ""
#	save_game_data()
	print(player_data)
	
#	set_chips_count(chips)
# warning-ignore:unused_argument




# warning-ignore:unused_argument

func _process(delta):

	update_stats()
	save_game_data()
	rank.manager()


func audio_manager():
	AudioServer.set_bus_layout(load("res://default_bus_layout.tres"))

func update_stats():
	#MEMORY UPDATER
	if update_highscore > player_data["best_score"]:
		
		best_score = update_highscore
		player_data["best_score"] = update_highscore
		print('Best SCORE : '+ str(best_score))
		
	if update_kill_count >= 1:
		player_data["kills"] += update_kill_count
		update_kill_count = 0
		
	if update_death_count >=1 :
		player_data["deaths"] += update_death_count
		update_death_count = 0

		
	if update_chips_count >= 1  :
		player_data["chips"] += update_chips_count
		update_chips_count = 0
		

	#-----END-----
	
	


#GAME DATA SAVE/LOAD FUNCTION






var player_data : Dictionary = {
		"pilot_name": pilot_name,
		"player_rank" : player_rank,
		"best_score": best_score,
		"kills": kills,
		"deaths": deaths,
		"chips": chips,
	}


var pass_key = OS.get_unique_id()

func save_game_data():
	
	
	var file = File.new()
	file.open_encrypted_with_pass(NEW_FILE_PATH, File.WRITE,pass_key)
	file.store_string(to_json(player_data))
	file.close()
	
	
func load_game_data():
	
	var file = File.new()
	if file.file_exists(NEW_FILE_PATH):
		file.open_encrypted_with_pass(NEW_FILE_PATH, File.READ,pass_key)
		var data = parse_json(file.get_as_text())
		print(player_data["kills"])
		file.close()
		
		if typeof(data) == TYPE_DICTIONARY:
			player_data = data
		else:
			printerr("Spoilt Data")
	else:
		printerr("Data Not Found")
#-----END-----





		
#OBSOLETE ; REMOVE BEFORE FINAL VERSION!
func load_data():
	var FILE = File.new()
	if !FILE.file_exists(FILE_PATH): return
	FILE.open(FILE_PATH, FILE.READ)
	
	player_rank = FILE.get_var()
	best_score = FILE.get_var()
	kills = FILE.get_var()
	deaths = FILE.get_var()
	chips = FILE.get_var()
	

	FILE.close()

func save_data():
	var FILE = File.new()
	FILE.open(FILE_PATH, FILE.WRITE)
	
	FILE.store_var(player_rank)
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

func set_player_rank(value: String):
	player_data["player_rank"] = value
	save_game_data()
	
