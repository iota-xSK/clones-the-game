extends KinematicBody2D
var gravity
var velocity = Vector2.ZERO
var outside_velocity = Vector2.ZERO
export (float) var mass = 1
var player_interact = false
var player
var friction = 0.3

func _ready():
	gravity = get_parent().get("gravity")
	if gravity == null:
		push_error("Parent of the player doesn't have gravity. Please put in a Level2D node. Setting gravity to 1300")
		gravity = 1300
func push():
	for i in get_slide_count():
		var colision = get_slide_collision(i)
		var collider = colision.collider
		if collider.is_in_group("physics_bodies") and colision.normal.y == 0:
			velocity.x = velocity.x/2
			collider.velocity.x = velocity.x


func _physics_process(delta):
#	if player_interact == true and is_instance_valid(player):
#		velocity = player.velocity
#		print("interaction with player", velocity)
##		move_and_collide(-(player.get_global_position() -
##		 self.get_global_position()) * delta)
#		move_and_collide(player.current_velocity * delta)
#	else:
#		if is_on_floor():
#			velocity.x = lerp(velocity.x, 0.0, friction)
#		velocity += outside_velocity
#	velocity.y += gravity * delta
#	move_and_collide(velocity*delta)
#	#velocity = move_and_slide(velocity, Vector2.UP)
	if is_on_floor():
		velocity.x = lerp(velocity.x, 0.0, friction)
		velocity.y = 0
	else:
		velocity.y += gravity * delta
	velocity += outside_velocity
	velocity.y += gravity * delta
#	for i in get_slide_count():
#		var collision = get_slide_collision(i)
#		print(collision)
	move_and_slide(velocity, Vector2.UP, false, 4, 0.78, true)
	push()
#	print(get_slide_count())
