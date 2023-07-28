extends Spatial

onready var main = get_tree().get_root()
var shield = load("res://scenes/power_ups/shield_power_up.tscn")

func spawn():
	if get_parent().get_node("player").game_started == true:
		var shield_scene = shield.instance()
		main.add_child(shield_scene)
		shield_scene.transform.origin = transform.origin + Vector3(rand_range(-18,18), rand_range(-12,12), 0)

func _on_Timer_timeout():
	
	spawn()
