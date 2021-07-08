extends KinematicBody2D

func move_to(start, finish, delta):
	var dir = (finish - start).normalized()
	var move_amount = Vector2(move_toward(start.x, finish.x, dir.x * delta),move_toward(start.y, finish.y, dir.y * delta))
	move_and_collide(move_amount)

func _physics_process(delta):
	if $"..".move == 1:
		if not position == $"../Position2D".position:
			move_to(position, $"../Position2D".position, delta)
		else:
			$"..".move = 0
	elif $"..".move == 2:
		if not position == $"..".position:
			move_to(position, $"..".position, delta)
