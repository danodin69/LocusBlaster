extends AudioStreamPlayer


var stream_player = AudioStreamPlayer2D.new()
const tracks = [
	'lady_of_the_80s.ogg',
	'Zombie Hyperdrive.ogg',
	'stranger_things.mp3',  
	'hero_of_the_80s.mp3',
   ]

func _ready():
#	self.add_child(stream_player)
	pass
	
func play_random_song():
	var randomise_track = randi() % tracks.size()
	var audiostream = load('res://assets/audio/music/' + tracks[randomise_track])
	set_stream(audiostream)
	play()
	print('now playing: ' + str(tracks[randomise_track]))
	yield(self,"finished")
	
