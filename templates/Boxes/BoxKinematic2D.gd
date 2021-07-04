extends KinematicBody2D
var gravity
var velocity = Vector2.ZERO
var outside_velocity = Vector2.ZERO
export (float) var mass = 1
var player_interact = false
var player
var friction = 0.1

func _ready():
	gravity = get_parent().get("gravity")
	if gravity == null:
		push_error("Parent of the player doesn't have gravity. Please put in a Level2D node. Setting gravity to 1300")
		gravity = 1300
	print("the velocity is", velocity)


func _physics_process(delta):
	if player_interact == true and is_instance_valid(player):
		velocity = player.velocity
		print("interaction with player", velocity)
	else:
		velocity.y += gravity * delta

	if is_on_floor():
		velocity.x = lerp(velocity.x, 0.0, friction)
#	if velocity.y != 21.666668:
#		print(velocity.y)
	velocity += outside_velocity
	velocity = move_and_slide(velocity, Vector2.UP)
