extends Control


var is_stats_screen : bool = false
onready var best_score  = $container_h2/best_score
onready var mobile_control_dialog = get_parent().get_node("InGameHud/mobile_controls/directions/accept_dialog")

func _process(delta):
	best_score.text = "BEST SCORE: " +str(mainScript.best_score)
	if is_stats_screen == true:
		mobile_control_dialog.show()
		$".".show()
		get_parent().get_node("main_menu").out_of_focus = true
		if Input.is_action_just_pressed("enter"):
			mobile_control_dialog.hide()
			$".".hide()
			$choosen.play()
			get_parent().get_node("main_menu").out_of_focus = false
			is_stats_screen = false
		


