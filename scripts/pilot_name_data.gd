extends Control


var pilot_name : String 


func _ready():
	$LineEdit.grab_focus()

func _physics_process(delta):
	get_player_name()
	
func get_player_name():
	if Input.is_action_just_pressed("enter"):
		pilot_name = $LineEdit.text.to_lower()
		mainScript.player_data["pilot_name"] = pilot_name
		get_tree().change_scene("res://Main.tscn")
	
