extends Spatial

onready var main = get_tree().get_root()
var chip = load("res://scenes/power_ups/save_me.tscn")

func spawn():
	if get_parent().get_node("player").game_started == true:
		var chip_power_up = chip.instance()
		main.add_child(chip_power_up)
		chip_power_up.transform.origin = transform.origin + Vector3(rand_range(-20,18), rand_range(-15,15), 0)

func _on_Timer_timeout():
	spawn()
