extends Spatial


func _ready():
	$explosion.play()
func _on_Timer_timeout():
	queue_free()
