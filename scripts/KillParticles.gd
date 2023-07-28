extends Spatial


func _ready():
	sound_system.sound_fx[8].play()
func _on_Timer_timeout():
	queue_free()
