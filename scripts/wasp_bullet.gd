"""
Dan: Future use(probably)
"""
extends KinematicBody

var velocity = Vector3()
var KillParticles = load("res://KillParticles.tscn")

onready var main = get_tree().current_scene
onready var explodeSound = $EnemyExplode



var timer = Timer.new()


func _ready():
	self.add_child(timer)
	timer.connect("timeout", self, "queue_free")
	timer.start()
	
	
	
# warning-ignore:unused_argument
func _physics_process(delta):
	timer.set_wait_time(0.009)
# warning-ignore:return_value_discarded
	move_and_slide(velocity)
	

#Destroy enemies on collison
func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		mainScript.update_highscore +=3
		print(mainScript.update_highscore)
		var particles = KillParticles.instance()
		main.add_child(particles)
		particles.transform.origin = transform.origin
		body.queue_free()
		explodeSound.play()
		visible = false
		$Area/CollisionShape.disabled = true
		
		
func _on_LightTimer_timeout():
	$OmniLight.visible = false



