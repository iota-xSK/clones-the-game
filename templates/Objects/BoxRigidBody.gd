extends RigidBody2D

var gravity
var velocity = Vector2(0, 0)
var player_nearby = false

func _ready():
	gravity = get_parent().get_parent().get("gravity")
	if gravity == null:
		push_error("Parent of a box doesn't have gravity. Please put it in a Level2D node. Setting gravity to 1300")
		gravity = 1300
	
func _integrate_forces(state):
	apply_central_impulse(Vector2(0, mass * gravity * state.step))
	if state.linear_velocity.y == 0:
		print("it is zero")
	print(state.linear_velocity.y)
	
	
