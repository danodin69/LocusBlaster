extends Control


var update_highscore_ui : int

var player_ship = PlayerShip.new()

var health : int = player_ship.health

var shield_health : int = player_ship.shield_health


var is_a_dialogue_active : bool = false


onready var main : Node = get_tree().current_scene

onready var shield_indicator1 : Node = $shield_status/shield1/active
onready var shield_indicator2 : Node = $shield_status/shield2/active
onready var shield_indicator3 : Node = $shield_status/shield3/active


onready var accept_button : Node = $mobile_controls/directions/rect/accept

onready var accept_button_dialogue : Node = $mobile_controls/directions/rect/accept_dialogue

onready var health_guage : Node = $health_guage
onready var high_score_counter : Node = $highscore_counter
onready var destroyed_enemies_counter : Node = $enemy_killed_counter

onready var update_gameOver_score : Node = get_parent().get_node("GameOver/score/new_score")


onready var joy_stick : Node = $mobile_controls/virtual_joystick
onready var shooter_hud : Node = $mobile_controls/shooter

func _ready():
	
	$health_guage.value = health

	invert_mobile_controls(mainScript.inverted_controls)


func _process(_delta):
	#Elegant :)
	_handle_game_ui()
	


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

func update_accept_ui_mobile():
	$Timer.start()
	_on_Timer_timeout()


func _handle_game_ui():
	
	update_highscore_ui = mainScript.update_highscore
	health_guage.value = health
	high_score_counter.text = str(update_highscore_ui)
	destroyed_enemies_counter.text = str(mainScript.rank.kills_per_game)

	update_gameOver_score.text = str(update_highscore_ui)
	
	if mainScript.animate_highscore_counter == true:
		$hud_anim.play("high_score_added")
		mainScript.animate_highscore_counter = false
	
	if get_parent().is_shield_on == true:
		$shield.show()

	match shield_health:
		0:
			get_parent().is_shield_on = false
			shield_indicator1.hide()
			$shield.hide()
		
		30:
			get_parent().is_shield_on = true
			shield_indicator1.show()
			shield_indicator2.hide()
			shield_indicator3.hide()
			$shield.show()
		60:
			shield_indicator1.show()
			shield_indicator2.show()
			shield_indicator3.hide()
		90:
			shield_indicator1.show()
			shield_indicator2.show()
			shield_indicator3.show()
	
	update_accept_ui_mobile()
	

	

func _on_Timer_timeout():
	
	if is_a_dialogue_active == true:
		accept_button.visible = false
		accept_button_dialogue.visible = true
	else:
		accept_button.visible = true
		accept_button_dialogue.visible = false
		
		



