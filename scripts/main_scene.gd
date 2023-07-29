extends Spatial

var isShieldOn : bool
var KillParticles : Resource = load("res://scenes/particles/KillParticles.tscn")
var power_up_particles : Resource = load('res://scenes/particles/power_ups.tscn')

onready var main = get_tree().get_root()


var is_chip_used : bool = false


# warning-ignore:unused_argument
func _process(delta):
	check_health()
	check_pause_input()
	change_music()
##



func _on_Guided_body_entered(body):
	if body.is_in_group('Enemies'):
		if !isShieldOn :
			$InGameHud.health -=10
			$pilot_hud/pilot_hud_anim.play("damage")
			$player/Camera/player.play("shake_camera")
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
			$pilot_hud/pilot_hud_anim.play("damage")
			var particles = KillParticles.instance()
			particles.transform.origin = transform.origin
			main.add_child(particles)
			$player/Camera/player.play("shake_camera")
			


		else:
			
			$InGameHud.shield_health -= 30
			
	if body.is_in_group('shield'):
		isShieldOn = true
		sound_system.sound_fx[0].play()
		$InGameHud.shield_health += 30
		$pilot_hud/pilot_hud_anim.play("shield")
		body.queue_free()
		var particles = power_up_particles.instance()
		particles.transform.origin = transform.origin
		main.add_child(particles)

	"""
	Dan: Little loophole here that i won't patch!
		 the repair gives extra hidden health even after
		 health is at 100% 
	"""
	if body.is_in_group('repair'):
		$pilot_hud/pilot_hud_anim.play("chips_health")
		sound_system.sound_fx[1].play()
		$InGameHud.health += 10
		body.queue_free()
		var particles = power_up_particles.instance()
		particles.transform.origin = transform.origin
		main.add_child(particles)
		
		
	if body.is_in_group('chip'):
		sound_system.sound_fx[2].play()
		mainScript.update_chips_count += 1
		$pilot_hud/pilot_hud_anim.play("chips_health")
		body.queue_free()
		var particles = power_up_particles.instance()
		particles.transform.origin = transform.origin
		main.add_child(particles)
		
func check_health():
	if $InGameHud.health <= 0 :
		destroy_all_enemies()
		$dialogue_system.continue_game_dialogue()
		get_tree().paused = true
		


func destroy_all_enemies():
	#Enemies Kill Themselves >:] 
	
	var enemies = get_tree().get_nodes_in_group("Enemies")
	
	for enemy in enemies:
		enemy.queue_free()
		
		var particles = KillParticles.instance()
		particles.transform.origin = transform.origin
		main.add_child(particles)

		

func restart_game():
	destroy_all_enemies()
	
	get_tree().paused = false
	
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Main.tscn")
	
	


func _on_Main_tree_exited():
	mainScript.update_highscore = 0


func _on_Main_tree_entered():
	
	sound_system.get_node("gameplay").play_random_song()
	
	if mainScript.is_game_restarted == true:
		get_tree().paused = false
		mainScript.is_game_restarted = false
		$player.game_started = true
		$InGameHud.show()
		$main_menu.queue_free()
		$pilot_hud.show()
		
	elif mainScript.on_main_menu_called == true:
		get_tree().paused = false
		mainScript.on_main_menu_called = false


func _on_gameplay_finished():
	sound_system.get_node("gameplay").play_random_song()

func change_music():
	if Input.is_action_just_pressed("music_knob"):
		sound_system.get_node("gameplay").play_random_song()


func pause():
	if $player.game_started ==true:
		get_tree().paused = true

func continue_game():
	get_tree().paused = false
	
func show_objective_dialogue():
	$dialogue_system.rank_objective_dialogue()

func show_promo_dialogue():
	$dialogue_system.rank_promotion_dialogue()

func show_game_over_screen():
	
	mainScript.update_death_count += 1
	
	$GameOver.game_over = true
	
	sound_system.music[1].play()
		
	$GameOver.show()
	$GameOver/score.show()
	$player.hide()
	$player.game_started =false
	get_tree().paused = true

	
func revive_player():
	if is_chip_used == true:
		
		mainScript.player_data["chips"] -= 1

		$InGameHud.health += 60
		$InGameHud.shield_health = 60
		
		$dialogue_system.close_continue_options_dialogue()
		$pilot_hud/pilot_hud_anim.play("chips_health")
		
		

	


