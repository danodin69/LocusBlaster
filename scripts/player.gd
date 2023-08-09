class_name PlayerShip

extends KinematicBody


var game_started : bool = false
const MAX_SPEED = 30
const ACCELERATION = 1
var input_vector = Vector3()
var velocity = Vector3()
var cooldown = 0
const COOLDOWN = 7

onready var guns = [$Gun0, $Gun1]
onready var main = get_tree().get_root()
var Bullet = load("res://scenes/npcs/Bullet.tscn")

func _physics_process(delta):
	is_game_started(game_started, delta)

func is_game_started(var is_started : bool, var delta):
	if is_started == true:
		
		input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		input_vector.y = Input.get_action_strength("move_up") - Input.get_action_strength("move_down")
		input_vector = input_vector.normalized()
		velocity.x = move_toward(velocity.x, input_vector.x * MAX_SPEED, ACCELERATION)
		velocity.y = move_toward(velocity.y, input_vector.y * MAX_SPEED, ACCELERATION)
		rotation_degrees.z = velocity.x * -2
		rotation_degrees.x = velocity.y / 2
		rotation_degrees.y = -velocity.x / 2
# warning-ignore:return_value_discarded
		move_and_slide(velocity)
		transform.origin.x = clamp(transform.origin.x, -30, 30)
		transform.origin.y = clamp(transform.origin.y, -25, 25)

		if Input.is_action_pressed("shoot") and cooldown <= 0:

			cooldown = COOLDOWN * delta
			for i in guns:
				var bullet = Bullet.instance()
				main.add_child(bullet)
				bullet.transform = i.global_transform
				bullet.velocity = bullet.transform.basis.z * -600

		if cooldown > 0:
			cooldown -= delta


