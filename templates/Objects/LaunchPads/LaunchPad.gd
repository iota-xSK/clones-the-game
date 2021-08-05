extends Area2D

var d
var g # gravity
var a
var initial_v
var launch_angle
var h_max
export (float) var t = 1
var body_inside = false
var h_final

func _ready():
	d = $EndPosition.get_global_transform().origin.x - get_global_transform().origin.x
	h_max = get_global_transform().origin.y - $AnglePosition.get_global_transform().origin.y
	h_final = get_global_transform().origin.y - $EndPosition.get_global_transform().origin.y
	g = get_parent().get("gravity")
	if g == null:
		push_error("Parent of the player doesn't have gravity. Please put in a Level2D node. Setting gravity to 1300")
		g = 1300
	a = -1 * g
	if gravity == null:
		push_error("Parent of the player doesn't have gravity. Please put in a Level2D node. Setting gravity to 1300")
		gravity = 1300

func _draw():
	draw_line(Vector2.ZERO, Vector2(d, 0), Color.blue)


func _on_LaunchPad_body_entered(body):
	$AnimatedSprite.play("default", true)
	d = $EndPosition.get_global_transform().origin.x - body.get_global_transform().origin.x
	h_max = body.get_global_transform().origin.y - $AnglePosition.get_global_transform().origin.y
	h_final = body.get_global_transform().origin.y - $EndPosition.get_global_transform().origin.y
	initial_v.y = sqrt(h_max * 2 * g)
	
	var time_1 = initial_v.y/g
	var v_2 = g * time_1
	var time_2 = sqrt((abs(2*h_final))/(g))
	if h_final > 0:
		time_2 = -time_2
	var v_f = g * (time_1 + time_2)

	initial_v = Vector2()
	initial_v.y = -sqrt(h_max * 2 * g)
	print("times: ", time_1, " ", time_2)
	print(time_1 + time_2)
	print(h_max)
	print(h_final)
	initial_v.x = d/(2 * time_1 + time_2)
	print(initial_v)
	body.velocity = initial_v
	body_inside = body


func _physics_process(delta):
	if body_inside:
		body_inside.snap = 0
		body_inside.outside_velocity = initial_v
		body_inside = false
