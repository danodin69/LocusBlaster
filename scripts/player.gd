extends KinematicBody


var game_started : bool = false
const MAXSPEED = 60
const ACCELERATION = 1
var inputVector = Vector3()
var velocity = Vector3()
var cooldown = 0
const COOLDOWN = 8

onready var guns = [$Gun0, $Gun1]
onready var main = get_tree().current_scene
var Bullet = load("res://scenes/npcs/Bullet.tscn")

onready var mobile_in_game_control_shooter = get_parent().get_node("InGameHud/mobile_controls/shooter")
onready var mobile_in_game_control_joystick = get_parent().get_node("InGameHud/mobile_controls/Virtual joystick")
onready var mobile_pause_button = get_parent().get_node("InGameHud/mobile_controls/pause")
onready var mobile_ui_controls = get_parent().get_node("InGameHud/mobile_controls/directions")

func _physics_process(delta):
	
	is_game_started(game_started, delta)

func is_game_started(var is_started : bool, var delta):
	if is_started == true:
		mobile_in_game_control_joystick.show()
		mobile_in_game_control_shooter.show()
		mobile_ui_controls.hide()
		mobile_pause_button.show()
		
		inputVector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		inputVector.y = Input.get_action_strength("move_up") - Input.get_action_strength("move_down")
		inputVector = inputVector.normalized()
		velocity.x = move_toward(velocity.x, inputVector.x * MAXSPEED, ACCELERATION)
		velocity.y = move_toward(velocity.y, inputVector.y * MAXSPEED, ACCELERATION)
		rotation_degrees.z = velocity.x * -2
		rotation_degrees.x = velocity.y / 2
		rotation_degrees.y = -velocity.x / 2
# warning-ignore:return_value_discarded
		move_and_slide(velocity)
		transform.origin.x = clamp(transform.origin.x, -35, 35)
		transform.origin.y = clamp(transform.origin.y, -25, 25)

		#shooting
		if Input.is_action_pressed("shoot") and cooldown <= 0:
			cooldown = COOLDOWN * delta
			for i in guns:
				var bullet = Bullet.instance()
				main.add_child(bullet)
				bullet.transform = i.global_transform
				bullet.velocity = bullet.transform.basis.z * -600
				
		#cooldown
		if cooldown > 0:
			cooldown -= delta


