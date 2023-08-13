extends Control


var game_paused : bool = false

var out_of_focus : bool = false
var pause_scene : Resource = load("res://Main.tscn")
var current_selector : int= 0


var tips : Array = [
	"Dodging Enemies takes less damage than getting hit", 
	"If You time it right your wings can destroy enemies without taking damage ",
	"you can keep collecting health packs, it gets stored even when full , makes you immortal for a while :) ", 
	"Your Focus and attention span Increases the more you play Locus Blaster",
	"If you're the first to beat the developer highscore you will get a price in real life"
	]

onready var selector1 : Node = $continue/selector
onready var selector2 : Node = $settings/selector
onready var selector3 : Node = $quit/selector
onready var mobile_control : Node = get_parent().get_node("InGameHud/mobile_controls/directions")
onready var mobile_in_game_control_shooter : Node = get_parent().get_node("InGameHud/mobile_controls/shooter")
onready var mobile_in_game_control_joystick : Node = get_parent().get_node("InGameHud/mobile_controls/virtual_joystick")
onready var mobile_pause_button : Node = get_parent().get_node("InGameHud/mobile_controls/pause")







func _ready():
	set_current_selection(0)
	is_game_paused(false)
# warning-ignore:unused_argument
func _process(delta):
	is_game_paused(game_paused)
	

func selection_handler(_current_selection):
	
	if _current_selection == 0:
		get_tree().paused = false
		game_paused = false
		$".".hide()
		get_parent().get_node("InGameHud/mobile_controls/music_changer").show()
		get_parent().toggle_pilot_controls(true)
		
	elif _current_selection == 1:
		
		$".".hide()
		
		get_parent().get_node("settings").is_settings_dialog_pause = true
	
		
		print("settings")
	elif _current_selection == 2:
		mainScript.on_main_menu_called = true
		mainScript.rank.kills_per_game = 0
		get_parent().restart_game()
		
		print("MENU")
		
func set_current_selection(_current_selection):
	selector1.hide()
	selector2.hide()
	selector3.hide()

	
	if _current_selection == 0:
		selector1.show()
	elif _current_selection == 1:
		selector2.show()
	elif _current_selection == 2:
		selector3.show()




	
func is_game_paused(var isPaused : bool):
	if isPaused == true:
		get_parent().get_node("InGameHud/mobile_controls/music_changer").hide()
		if out_of_focus == false:
			
			
			
			get_parent().toggle_pilot_controls(false)
			
			if Input.is_action_just_pressed("ui_right") and current_selector < 2:
				sound_system.sound_fx[4].play()
				current_selector += 1
				set_current_selection(current_selector)
				
			elif Input.is_action_just_pressed("ui_left") and current_selector > 0:
				current_selector -= 1
				sound_system.sound_fx[4].play()
				set_current_selection(current_selector)
				
			elif Input.is_action_just_pressed("ui_up"):
				sound_system.sound_fx[3].play()
				selection_handler(current_selector)

func suggest_tip():
	randomize()
	var tip = tips[randi()%tips.size()*1]
	$tips.text = tip
	
	
