extends KinematicBody



var velocity = Vector3()
var timer = Timer.new()


onready var main = get_tree().get_root()



# """
# Dan: When one bullet spawns this code runs all over again 
# 	 Then it destroys itself in 2 millisecond, as long as the bullet spawns
# 	 The reason is because without the timer, the game lags when bullets are
# 	 contantly spawned even when destroyed after collision
# """

func _ready():
	sound_system.sound_fx[7].play()
	self.add_child(timer)
	timer.connect("timeout", self, "queue_free")
	timer.start()
	
	
	

func _physics_process(_delta):
	timer.set_wait_time(0.009)

# warning-ignore:return_value_discarded
	move_and_slide(velocity)
	

#Destroy bullet on collison

func _on_Area_body_entered(body):
	if body.is_in_group("Enemies"):
		visible = false
		$Area/CollisionShape.disabled = true
		
			
func _on_LightTimer_timeout():
	$OmniLight.visible = false



