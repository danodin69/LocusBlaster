class_name PlayerShip

extends KinematicBody

#This script is an modified version of master albert open source spaceship shooter, and thus the license on that project is applicable here  -> https://github.com/harambert/Godot-3D-Space-Shooter 


const MAX_SPEED = 30.0
#---
# 0.5 Min Acceleration, 0.75 - 0.84 Mid Acceleration, 0.9 - 1.0 Max Acceleration
# This controls the sensitivity , increase it beyond 1.0 and you have an overly fast ship, vice versa for beyond
# 0.5, This can be exported and used as values to help players adjust 'sensitivity'. 
# This Problem of sensitivity though is more prevalent for mobile 

const ACCELERATION = 0.84

const COOLDOWN = 7

var health : int = 100
var shield_health : int

var game_started : bool = false

var input_vector = Vector3()
var velocity = Vector3()
var cooldown = 0

var Bullet = load("res://scenes/npcs/Bullet.tscn")

onready var guns = [$Gun0, $Gun1]
onready var main = get_tree().get_root()


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

		_run_ship_controls(delta)

		


func _run_ship_controls(var delta):
	if Input.is_action_pressed("shoot") and cooldown <= 0|| Input.is_action_pressed("move_right") and cooldown <= 0|| Input.is_action_pressed("move_left") and cooldown <= 0|| Input.is_action_pressed("move_down") and cooldown <= 0 || Input.is_action_pressed("move_up") and cooldown <= 0:

		cooldown = COOLDOWN * delta
		for i in guns:
			var bullet = Bullet.instance()
			main.add_child(bullet)
			bullet.transform = i.global_transform
			bullet.velocity = bullet.transform.basis.z * -600

	if cooldown > 0:
		cooldown -= delta