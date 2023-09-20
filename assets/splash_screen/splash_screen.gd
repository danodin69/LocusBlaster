extends Control

var main_scene = "res://Main.tscn"
var pilot_name_scene = preload("res://scenes/ui/pilot_name.tscn")

func _ready():
	
	$AudioStreamPlayer2D.bus = "splash"
	$AudioStreamPlayer2D2.bus = "splash"
	$AnimationPlayer.play("splash!")
	

func go_to_main():
	self.hide()
	$retro_shader/CanvasLayer.visible = false
# warning-ignore:return_value_discarded
	if mainScript.player_data["pilot_name"]=="":
		get_tree().change_scene_to(pilot_name_scene)
		
	else:
		Loader.load_scene(main_scene)
#		get_tree().change_scene(main_scene)
