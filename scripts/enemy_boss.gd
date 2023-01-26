"""
Dan: Future use(probably)
"""
extends KinematicBody

var bullet = load('res://Bullet_enemy.tscn')

var position = get_position_in_parent()

onready var player = get_parent().get_node("player")
onready var shooter = [$shooter1, $shooter2]

var min_velocity = Vector2(-150, -150)
var max_velocity = Vector2(150, 150)


var shooting_interval = 0

var shooting_timer = Timer.new()

func _ready():
	self.add_child(shooting_timer)
	shooting_timer.wait_time = shooting_interval
	shooting_timer.connect("timeout", self, "_shoot")
	shooting_timer.start()

func _shoot():
	
	var direction = (player.get_position_in_parent() - position)
	
	
	var projectile = bullet.instance()
	for i in shooter:
		get_parent().add_child(projectile)
		projectile.transform = i.global_transform
		projectile.velocity = projectile.transform.basis.z * 600
	
	shooting_timer.start()

func _physics_process(delta):
	var velocity = Vector3(rand_range(min_velocity.x, max_velocity.x), rand_range(min_velocity.y, max_velocity.y), 0)
	
	transform.origin.x = clamp(transform.origin.x, -45, 45)
	transform.origin.y = clamp(transform.origin.y, -30, 30)
	
	move_and_collide(velocity * delta)
