extends Spatial


var Enemy : Resource = load("res://scenes/npcs/enemy.tscn")

onready var main : Node = get_tree().get_root()


func spawn():
	if get_parent().get_node("player").game_started == true:
		var enemy = Enemy.instance()
		main.add_child(enemy)
		enemy.transform.origin = transform.origin + Vector3(rand_range(-12,18), rand_range(-10,13), 0)

func _on_Timer_timeout():
	
	
	spawn()
