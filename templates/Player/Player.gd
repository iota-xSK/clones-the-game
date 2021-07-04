extends KinematicBody2D

export (int) var speed = 130
export (int) var jump_speed = -300
export (float, 0, 1.0) var friction = 0.6
export (float, 0, 1.0) var acceleration = 0.9
export (int) var mass = 1
#export (int, 0, 200) var push = 30
var push = 40
var outside_velocity = Vector2(0, 0)
var gravity
var velocity = Vector2.ZERO

var movable_bodies = []

signal on_screen_exited

func _init():
	add_to_group("player_group")

func _ready():
	gravity = get_parent().get_parent().get("gravity")
	if gravity == null:
		push_error("Parent of the player doesn't have gravity. Please put in a Level2D node. Setting gravity to 1300")
		gravity = 1300

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	emit_signal("on_screen_exited")

func get_input():
	var dir = 0
	if Input.is_action_pressed("move_right"):
		dir += 1
	if Input.is_action_pressed("move_left"):
		dir -= 1
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)	


func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity += outside_velocity
	velocity = move_and_slide(velocity, Vector2.UP, false, 4, PI/4, false)
#	velocity = move_and_slide(velocity, Vector2.UP, false, 4, PI/4, true)
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("bodies"):
			collision.collider.apply_central_impulse(Vector2(-collision.normal.x * push, 0))

	outside_velocity = Vector2(0, 0)
	if Input.is_action_just_pressed("move_jump"):
		if is_on_floor():
			velocity.y = jump_speed
	if Input.is_action_just_pressed("interact"):
		for body in movable_bodies:
			body.player_interact = not body.player_interact
			print("body.player_interact: ", body.player_interact)
			print(movable_bodies)

func _on_Area2D_body_entered(body):
	movable_bodies.append(body)
	body.player = self
	print(movable_bodies)

func _on_Area2D_body_exited(body):
	movable_bodies.erase(body)
	body.player_interact = false
	print(movable_bodies)
	
