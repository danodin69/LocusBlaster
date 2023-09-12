extends Control


func _ready():
	pass

func _process(_delta):
	

	if Input.is_action_just_pressed("enter"):
		$retro_shader/CanvasLayer.visible = false

		sound_system.sound_fx[4].play()
		# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Main.tscn")
		
