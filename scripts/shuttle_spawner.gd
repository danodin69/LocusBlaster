"""
Dan: Future use(probably)
"""
extends Spatial

onready var model_export = get_tree().current_scene

var space_shuttle = load("res://spaceships/shuttle_evil.tscn")

func spawn_shuttle():
	
	var shuttle = space_shuttle.instance()
	
	model_export.add_child(shuttle)
	
	shuttle.transform.origin = transform.origin + Vector3(rand_range(-18,18), rand_range(-10,10), 0)


func _on_Timer_timeout():
	spawn_shuttle()
