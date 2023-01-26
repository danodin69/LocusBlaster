extends KinematicBody


var timer = Timer.new()
var velocity = Vector3()


"""
when one bullet spawns this code runs all over again 
Then it destroys itself in 2 millisecond, as long as the bullet spawns
The reason is because without the timer, the game lags when bullets are
contantly spawned
"""

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
	if body.is_in_group("enemies"):
		body.queue_free()
		
