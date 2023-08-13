extends AudioStreamPlayer



const tracks : Array = [
	'lady_of_the_80s.ogg',
	'Zombie Hyperdrive.ogg',
	'stranger_things.mp3',  
	'hero_of_the_80s.mp3',
   ]

var index : int 


func play_random_song():
	randomize()
	var randomise_track = randi() % tracks.size()
	var audiostream = load('res://assets/audio/music/' + tracks[randomise_track])

	set_stream(audiostream)
	play()

	print_debug('Playing -> ' + tracks[randomise_track])
	
func play_next_song_on_list():

	var audiostream = load('res://assets/audio/music/' + tracks[index])
	
	if index < tracks.size():

		set_stream(audiostream)
		play()

		print_debug('Now Playing -> ' + tracks[index])
		index += 1

		if index == tracks.size():
			index = 0
		


