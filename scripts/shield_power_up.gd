extends KinematicBody

var speed = rand_range(40,90)

func _physics_process(_delta):
# warning-ignore:return_value_discarded
	move_and_slide(Vector3(0,0,speed))
	if transform.origin.z > 10:
		queue_free()

