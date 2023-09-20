extends Control

var pilot_name : String 


func _ready():
	$LineEdit.grab_focus()

func _physics_process(_delta):
	get_player_name()



func get_player_name():
	var line_edit = $LineEdit.text
	if line_edit == "":
		pass
		
	else:
		if Input.is_action_just_pressed("enter"):
			$go.visible = false
			$retro_shader/CanvasLayer.visible = false
			pilot_name = $LineEdit.text.to_lower()
			mainScript.player_data["pilot_name"] = pilot_name

# warning-ignore:return_value_discarded
#LAZY code, switch this from tutorial to main if porting for mobile (check line 49)
			Loader.load_scene("res://scenes/ui/tutorial.tscn")
			# Loader.load_scene("res://Main.tscn")	

	


func _on_Timer_timeout():
	sound_system.sound_fx[4].play()


func _on_TextureButton_pressed():
	var line_edit = $LineEdit.text
	if line_edit == "":
		pass
	else:
		$retro_shader/CanvasLayer.visible = false
		pilot_name = $LineEdit.text.to_lower()
		mainScript.player_data["pilot_name"] = pilot_name
	# warning-ignore:return_value_discarded

	#LAZY code, switch this from tutorial to main if porting for mobile
		Loader.load_scene("res://scenes/ui/tutorial.tscn")
		# Loader.load_scene("res://Main.tscn")		
