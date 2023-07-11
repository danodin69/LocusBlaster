extends KinematicBody

var speed = rand_range(40,90)
# warning-ignore:unused_argument
func _physics_process(delta):
# warning-ignore:return_value_discarded
	move_and_slide(Vector3(0,0,speed))
	if transform.origin.z > 10:
		queue_free()

