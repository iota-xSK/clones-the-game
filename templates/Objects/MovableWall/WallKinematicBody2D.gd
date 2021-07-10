extends KinematicBody2D
var start_position = transform.origin
export (bool) var open = false

func moving_to_vector(point):
	return(point - position)

func _physics_process(delta):
	var velocity
	if open:
		velocity = moving_to_vector($"../Position2D".position)
	else:
		velocity = moving_to_vector(start_position)
	var collision = move_and_collide(velocity * delta * $".." .speed)
	if collision:
		if collision.collider.is_in_group("player_group") and collision.normal.y != 0:
			#crushes the clone
			collision.collider.call_deferred("queue_free")
