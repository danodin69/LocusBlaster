extends Node2D

onready var sound_fx  = [$shield_powerup, $health_powerup, $chip_sound, $choosen, $select, $explode, $counter, $BulletSound, $explosion]

onready var music = [$gameplay, $game_over]

onready var voice_over #TO IMPLEMENT

func _ready():
	
	start_audio_manager()

	
	
func start_audio_manager():
	
	
	
	AudioServer.set_bus_layout(load("res://misc/audio_bus/default_bus_layout.tres"))
	
	AudioServer.set_bus_mute(1,mainScript.music_on)
	AudioServer.set_bus_mute(2,mainScript.fx_on)
	
	$gameplay.bus = "Music"
	$game_over.bus = "Music"
	$shield_powerup.bus = "SoundFX"
	$health_powerup.bus = "SoundFX"
	$chip_sound.bus = "SoundFX"
	$select.bus = "ui"
	$choosen.bus = "ui"
	$explode.bus = "SoundFX"
	$counter.bus = "ui"
	$BulletSound.bus = "impact"
	$explosion.bus = "echo"
	
	
