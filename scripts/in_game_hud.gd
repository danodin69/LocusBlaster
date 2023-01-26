extends Control

var update_highscore_ui : int
var health : int = 100

var shield_health : int

onready var main = get_tree().current_scene
var pause_scene = load("res://scenes/ui/pause_HUD.tscn")

onready var shield_indicator1 = $shield_status/shield1/active
onready var shield_indicator2 = $shield_status/shield2/active
onready var shield_indicator3 = $shield_status/shield3/active


func _ready():
	$health_guage.value = health


# warning-ignore:unused_argument
func _physics_process(delta):
	update_highscore_ui = mainScript.update_highscore
	$health_guage.value = health
	$highscore_counter.text = str(update_highscore_ui)
	get_parent().get_node("GameOver/score/new_score").text = str(update_highscore_ui)
	#print('shield Health: '  + str(shield_health))
	
	if shield_health <= 0 :
		get_parent().isShieldOn = false
		shield_indicator1.hide()
		$shield.hide()
		
		
	elif shield_health >= 30:
		get_parent().isShieldOn = true
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
