extends Control


var update_highscore_ui : int
var health : int = 100

var shield_health : int

onready var main = get_tree().current_scene
var pause_scene = load("res://scenes/ui/pause_HUD.tscn")

onready var shield_indicator1 = $shield_status/shield1/active
onready var shield_indicator2 = $shield_status/shield2/active
onready var shield_indicator3 = $shield_status/shield3/active

var is_a_dialogue_active = false

onready var accept_button : Node = $mobile_controls/directions/rect/accept

onready var accept_button_dialogue : Node = $mobile_controls/directions/rect/accept_dialogue

func _ready():
	$health_guage.value = health


# warning-ignore:unused_argument
func _physics_process(delta):
	_handle_game_ui()
	
func _handle_game_ui():
	
	update_highscore_ui = mainScript.update_highscore
	$health_guage.value = health
	$highscore_counter.text = str(update_highscore_ui)
	get_parent().get_node("GameOver/score/new_score").text = str(update_highscore_ui)

	
	if shield_health <= 0 :
		get_parent().is_shield_on = false
		shield_indicator1.hide()
		$shield.hide()
		
		
	elif shield_health >= 30:
		get_parent().is_shield_on = true
		$shield.show()
		
	if shield_health == 30:
		shield_indicator1.show()
		shield_indicator2.hide()
		shield_indicator3.hide()
		
	elif shield_health == 60:
		shield_indicator1.show()
		shield_indicator2.show()
		shield_indicator3.hide()
	
	elif shield_health >= 90:
		shield_health = 90
		shield_indicator1.show()
		shield_indicator2.show()
		shield_indicator3.show()
	
	update_accept_ui_mobile()
	
func update_accept_ui_mobile():
	$Timer.start()
	_on_Timer_timeout()
	

func _on_Timer_timeout():
	
	if is_a_dialogue_active == true:
		accept_button.visible = false
		accept_button_dialogue.visible = true
	else:
		accept_button.visible = true
		accept_button_dialogue.visible = false
