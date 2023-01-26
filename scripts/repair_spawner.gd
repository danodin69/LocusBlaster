extends Spatial

onready var main = get_tree().current_scene
var repair = load("res://scenes/power_ups/repair_power_up.tscn")

func spawn():
	if get_parent().get_node("player").game_started == true:
		var repair_powerup = repair.instance()
		main.add_child(repair_powerup)
		repair_powerup.transform.origin = transform.origin + Vector3(rand_range(-18,18), rand_range(-12,12), 0)

func _on_Timer_timeout():
	spawn()
