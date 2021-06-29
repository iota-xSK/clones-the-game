extends KinematicBody2D

var run_speed = 130
var acceleration = 0.9
var jump_speed = -300
var gravity = 1300
var friction = 0.5
var land_speed = 600
var land_acceleration = 0.9
var land = false

var velocity = Vector2()
var jumping = false

var floor_too_far = true
var jump_when_down = false

var outside_velocity = Vector2()

signal on_screen_exited


func _init():
	add_to_group("player_group")
	

func _physics_process(delta):
	var right = Input.is_action_pressed("move_right")
	var left = Input.is_action_pressed("move_left")
	var jump = Input.is_action_pressed("move_jump")
	var land_input = Input.is_action_just_pressed("move_down")
	velocity.y += gravity * delta
	if jump:
		if is_on_floor():
			velocity.y = jump_speed
		else:
			floor_too_far = false
			jump_when_down = true
			$Timer.start()
	if land_input and (not land):
		land = true
	if land:
		velocity.y = lerp(velocity.y, land_speed, land_acceleration)
		#velocity.y = land_speed
	if is_on_floor():
		land = false
		
	if (not floor_too_far) and jump_when_down and is_on_floor():
		velocity.y = jump_speed
		jump_when_down = false
	#print(velocity.y)
	if right:
		velocity.x += lerp(velocity.x, run_speed, acceleration)
		#velocity.x = clamp(velocity.x + acceleration * delta, -run_speed, run_speed)
	if left:
		velocity.x += lerp(velocity.x, -run_speed, acceleration)
		#velocity.x = clamp(velocity.x - acceleration * delta, -run_speed, run_speed)
	velocity.x = lerp(velocity.x, 0, friction)
	velocity += outside_velocity
	velocity = move_and_slide(velocity, Vector2(0, -1))
	outside_velocity = Vector2(0, 0)


func _on_Timer_timeout():
	floor_too_far = true

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	#print("freed")
	emit_signal("on_screen_exited")

