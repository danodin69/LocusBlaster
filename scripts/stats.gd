extends Control


var is_stats_screen : bool = false
onready var best_score  = $container_h2/best_score


func _process(delta):
	best_score.text = "BEST SCORE: " +str(mainScript.best_score)
	if is_stats_screen == true:
		$".".show()
		get_parent().get_node("main_menu").out_of_focus = true
		if Input.is_action_just_pressed("enter"):
			$".".hide()
			$choosen.play()
			get_parent().get_node("main_menu").out_of_focus = false
			is_stats_screen = false
		


