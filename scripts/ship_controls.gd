"""
Dan: Future use(probably)
"""

extends KinematicBody


const MAXIMUM_SPEED : int = 36
const ACCELERATION : float = 0.90
var cooldown_timer : int = 0
const COOLDOWN : int = 6
var vectorInput = Vector3()
var velocity = Vector3()

onready var shooter = [$shooter_1, $shooter_2]
onready var model_export = get_tree().current_scene
var bullet = load("res://scenes/bullet.tscn")

func _physics_process(delta):
	vectorInput.x = Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right")
	vectorInput.y = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	
	vectorInput = vectorInput.normalized()
	
	
	velocity.x = move_toward(velocity.x, vectorInput.x * MAXIMUM_SPEED, ACCELERATION)
	velocity.y = move_toward(velocity.y, vectorInput.y * MAXIMUM_SPEED, ACCELERATION)
	
	rotation_degrees.z = velocity.x * -2
	rotation_degrees.y = velocity.y / 2
	rotation_degrees.x = -velocity.y / 2
	
	move_and_slide(velocity)
	
	transform.origin.x  = clamp(transform.origin.x, -15, 15)
	transform.origin.y  = clamp(transform.origin.y, -10, 10)
	
	if Input.is_action_pressed("ui_accept") and cooldown_timer <= 0: 
		
		cooldown_timer = COOLDOWN * delta
		for s in shooter:
			var new_bullet = bullet.instance()
			model_export.add_child(new_bullet)
			new_bullet.transform = s.global_transform
			new_bullet.velocity = new_bullet.transform.basis.z * -600
			
			
	if cooldown_timer > 0 :
		cooldown_timer -= delta
	
			
	
