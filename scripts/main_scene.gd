extends Spatial

var isShieldOn : bool
var KillParticles : Resource = load("res://scenes/particles/KillParticles.tscn")
var power_up_particles : Resource = load('res://scenes/particles/power_ups.tscn')
onready var main = get_tree().current_scene



# warning-ignore:unused_argument
func _process(delta):
	check_health()
	check_pause_input()
	change_music()


func _on_Guided_body_entered(body):
	if body.is_in_group('Enemies'):
		if !isShieldOn :
			$InGameHud.health -=10
			print($InGameHud.health)
		else:
			$InGameHud.shield_health -= 30

func check_pause_input():
	if Input.is_action_just_pressed("pause"):
		if $player.game_started ==true:
			get_tree().paused = true
			$pause_HUD.game_paused = true
			$pause_HUD.show()
			
			
func _on_ShipHealth_body_entered(body):
	
	if body.is_in_group('Enemies'):
		if !isShieldOn :
			$InGameHud.health -=25
			var particles = KillParticles.instance()
			particles.transform.origin = transform.origin
			main.add_child(particles)

		else:
			$InGameHud.shield_health -= 30
			
	if body.is_in_group('shield'):
		isShieldOn = true
		$sounds/shield_powerup.play()
		$InGameHud.shield_health += 30
		var particles = power_up_particles.instance()
		particles.transform.origin = transform.origin
		main.add_child(particles)
		
		print('SHIELD POWER UP COLLECTED')
	"""
	Dan: Little loophole here that i won't patch!
		 the repair gives extra hidden health even after
		 health is at 100% 
	"""
	if body.is_in_group('repair'):
		
		$sounds/health_powerup.play()
		$InGameHud.health += 10
		
		var particles = power_up_particles.instance()
		particles.transform.origin = transform.origin
		main.add_child(particles)
		
		print('HEALTH POWER UP COLLECTED')
		
		
func check_health():
	if $InGameHud.health <= 0 :
		mainScript.deaths += 1
		mainScript.save_data()
		$GameOver.game_over = true
		$GameOver.show()
		$GameOver/score.show()
		$player.hide()
		$player.game_started =false
		$sounds/game_over.play()
		get_tree().paused = true
		
func restart_game():
	get_tree().paused = false
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Main.tscn")
	
	


func _on_Main_tree_exited():
	mainScript.update_highscore = 0


func _on_Main_tree_entered():
	if mainScript.is_game_restarted == true:
		get_tree().paused = false
		mainScript.is_game_restarted = false
		$player.game_started = true
		$InGameHud.show()
		$main_menu.queue_free()
		$InGameHud/pilot_hud/CanvasLayer.show()
		
	elif mainScript.on_main_menu_called == true:
		get_tree().paused = false
		mainScript.on_main_menu_called = false


func _on_gameplay_finished():
	$sounds/gameplay.play_random_song()

func change_music():
	if Input.is_action_just_pressed("music_knob"):
		$sounds/gameplay.play_random_song()
