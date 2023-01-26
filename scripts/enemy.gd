extends KinematicBody

var initial_low_speed = 20
var initial_high_speed = 50

var speed = rand_range(initial_low_speed, initial_high_speed)
onready var main = get_tree().current_scene
var KillParticles = load("res://scenes/particles/KillParticles.tscn")

# warning-ignore:unused_argument
func _physics_process(delta):
	difficulty_meter()
	

"""
Dan: I Tried to use a match statement for this, 
	 but gdscript is unable to , conditional statement is more suitable
	 check end of script for commented match method

	 Difficulty increases base on highscore, the game becomes a test of focus
	 the level highscore comparison numbers are skipped in other to simulate short rest periods and avoid
	 difficulty looking forced until extreme levels
"""
func difficulty_meter():
	
	var speed_easy = rand_range(30, 80)

	var speed_medium = rand_range(50, 150)
	
	var speed_hard = rand_range(70, 180)
	
	var speed_extreme = rand_range(90, 210)
	
	var level1 = mainScript.update_highscore > 110 && mainScript.update_highscore < 520
	var level2 = mainScript.update_highscore > 550 && mainScript.update_highscore < 850
	var level3 = mainScript.update_highscore > 900 && mainScript.update_highscore < 2000
	var level4 = mainScript.update_highscore > 2000 
	
	var score = mainScript.update_highscore
	
	
	if level1:
		print('level1?: '+ str(level1))
		move_and_slide(Vector3(0,0,speed_easy))
		if transform.origin.z > 10:
			queue_free()
	elif level2:
		print('level2?: '+ str(level2))
		move_and_slide(Vector3(0,0,speed_medium))
		if transform.origin.z > 10:
			queue_free()
	elif level3:
		print('level3?: '+ str(level3))
		move_and_slide(Vector3(0,0,speed_hard))
		if transform.origin.z > 10:
			queue_free()
	elif level4:
		print('level4?: '+ str(level4))
		move_and_slide(Vector3(0,0,speed_extreme))
		if transform.origin.z > 10:
			queue_free()
	else:
		move_and_slide(Vector3(0,0,speed))
		if transform.origin.z > 10:
			queue_free()
	
		
func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		print('enemy entered player')
		var particles = KillParticles.instance()
		particles.transform.origin = transform.origin
		main.add_child(particles)
		

#THIS DIDN'T WORK OUT :( wish it did, it is prettier!
#var levels = [level1, level2, level3, level4]
#match score:
#		level1: 
#			print('level1?: '+ levels[0])
#			move_and_slide(Vector3(0,0,speed_easy))
#			if transform.origin.z > 10:
#				queue_free()
#		level2:
#			move_and_slide(Vector3(0,0,speed_medium))
#			if transform.origin.z > 10:
#				queue_free()
#		level3:
#			move_and_slide(Vector3(0,0,speed_hard))
#			if transform.origin.z > 10:
#				queue_free()
#		level4:
#			move_and_slide(Vector3(0,0,speed_extreme))
#			if transform.origin.z > 10:
#				queue_free()
#		_:
#			move_and_slide(Vector3(0,0,speed))
#			if transform.origin.z > 10:
#				queue_free()
