extends KinematicBody2D

export (int) var speed = 130
export (int) var jump_speed = -300
export (float, 0, 1.0) var friction = 0.6
export (float, 0, 1.0) var acceleration = 0.9
#export (int, 0, 200) var push = 30
var push = 30
var outside_velocity = Vector2(0, 0)
var gravity

var velocity = Vector2.ZERO


#export (int, 0, 200) var push = 100
#var run_speed = 130
#var acceleration = 0.9
#var jump_speed = -300
#var gravity = 1300
#var friction = 0.5
#var land_speed = 600
#var land_acceleration = 0.9
#var land = false
#
#var velocity = Vector2()
#var jumping = false
#
#var floor_too_far = true
#var jump_when_down = false
#
#var outside_velocity = Vector2()
#
signal on_screen_exited

func _init():
	add_to_group("player_group")

func _ready():
	gravity = get_parent().get_parent().get("gravity")
	if gravity == null:
		push_error("Parent of the player doesn't have gravity. Please put in a Level2D node. Setting gravity to 1300")
		gravity = 1300
#func _physics_process(delta):
#	var right = Input.is_action_pressed("move_right")
#	var left = Input.is_action_pressed("move_left")
#	var jump = Input.is_action_just_pressed("move_jump")
#	var land_input = Input.is_action_just_pressed("move_down")
#
#
#	#velocity.y += gravity
#
#
#	velocity.y += gravity * delta
#	if jump:
#		if is_on_floor():
#			velocity.y = jump_speed
#		else:
#			floor_too_far = false
#			jump_when_down = true
#			$Timer.start()
#	if land_input and (not land):
#		land = true
#	if land:
#		velocity.y = lerp(velocity.y, land_speed, land_acceleration)
#		#velocity.y = land_speed
#	if is_on_floor():
#		land = false
#
#	if (not floor_too_far) and jump_when_down and is_on_floor():
#		velocity.y = jump_speed
#		jump_when_down = false
#	#print(velocity.y)
#	if right:
#		velocity.x += lerp(velocity.x, run_speed, acceleration)
#		#velocity.x = clamp(velocity.x + acceleration * delta, -run_speed, run_speed)
#	if left:
#		velocity.x += lerp(velocity.x, -run_speed, acceleration)
#		#velocity.x = clamp(velocity.x - acceleration * delta, -run_speed, run_speed)
#	velocity.x = lerp(velocity.x, 0, friction)
#	velocity += outside_velocity
#	velocity = move_and_slide(velocity, Vector2(0, -1), false, 4, PI/4, false)
#
#	for index in get_slide_count():
#		var collision = get_slide_collision(index)
#		if collision.collider.is_in_group("bodies"):
#			collision.collider.apply_central_impulse(-collision.normal * push)
#	outside_velocity = Vector2(0, 0)
#
#
#func _on_Timer_timeout():
#	floor_too_far = true
#


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
	
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("bodies"):
			collision.collider.apply_central_impulse(-collision.normal * push)
				
	outside_velocity = Vector2(0, 0)
	if Input.is_action_just_pressed("move_jump"):
		if is_on_floor():
			velocity.y = jump_speed
