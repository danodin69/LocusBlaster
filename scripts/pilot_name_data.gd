extends Control

var load_scene = Loader
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
			Loader.load_scene("res://Main.tscn")
	#		get_tree().change_scene("res://Main.tscn")
	


func _on_Timer_timeout():
	sound_system.sound_fx[4].play()


func _on_TextureButton_pressed():
	$retro_shader/CanvasLayer.visible = false
	pilot_name = $LineEdit.text.to_lower()
	mainScript.player_data["pilot_name"] = pilot_name
	Loader.load_scene("res://Main.tscn")
