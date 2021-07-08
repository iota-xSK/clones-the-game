extends Node2D
export (float) var time = 2
var moving_vector =  Vector2.ZERO
export (int) var move = 0 # 0 means no moving, 1 means thowards the position2D, 2 means towards the starting point

func move_to_position():
	move = 1
func move_to_start():
	move = 2
