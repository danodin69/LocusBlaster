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


onready var joy_stick : Node = $mobile_controls/virtual_joystick
onready var shooter_hud : Node = $mobile_controls/shooter

func _ready():
	$health_guage.value = health

	invert_mobile_controls(mainScript.inverted_controls)
# warning-ignore:unused_argument
func _physics_process(delta):
	_handle_game_ui()
	
func _handle_game_ui():
	
	update_highscore_ui = mainScript.update_highscore
	$health_guage.value = health
	$highscore_counter.text = str(update_highscore_ui)
	$enemy_killed_counter.text = str(mainScript.rank.kills_per_game)
	get_parent().get_node("GameOver/score/new_score").text = str(update_highscore_ui)
	
	if mainScript.animate_highscore_counter == true:
		$hud_anim.play("high_score_added")
		mainScript.animate_highscore_counter = false
	
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
		
		
func invert_mobile_controls(var is_inverted : bool = false):
	
	if is_inverted == true :
		joy_stick.set_position(Vector2(-120, 0),true)
		shooter_hud.set_position(Vector2(1100,0),true)
	else:
		joy_stick.set_position(Vector2(1120, -8), true)
		shooter_hud.set_position(Vector2(0,0),true)

#Analogue

#-3 left
#1289 right

#shooter
#1370.416 right
#O left :?
