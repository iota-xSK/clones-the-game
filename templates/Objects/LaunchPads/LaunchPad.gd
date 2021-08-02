extends Area2D

var d
var g # gravity
var a
var initial_v
var launch_angle
var h_max
export (float) var t = 1
var body_inside = false


func _ready():
	d = abs(get_global_transform().origin.x - $EndPosition.get_global_transform().origin.x)
	h_max = get_global_transform().origin.y - $AnglePosition.get_global_transform().origin.y
	g = get_parent().get("gravity")
	a = -1 * g
	if gravity == null:
		push_error("Parent of the player doesn't have gravity. Please put in a Level2D node. Setting gravity to 1300")
		gravity = 1300

func _on_LaunchPad_body_entered(body):
	$AnimatedSprite.play("default", true)
	d = abs(body.get_global_transform().origin.x - $EndPosition.get_global_transform().origin.x)
	h_max = body.get_global_transform().origin.y - $AnglePosition.get_global_transform().origin.y
	var c = Vector2(body.get_global_transform().origin.x + d, body.get_global_transform().origin.y)
	
	initial_v = Vector2()
	initial_v.y = -sqrt(h_max * 2 * g)
	initial_v.x = (-d * g / initial_v.y) / 2
	print(initial_v)
	body.velocity = initial_v
	body_inside = body

func _physics_process(delta):
	if body_inside:
		body_inside.snap = 0
		body_inside.outside_velocity = initial_v
		body_inside = false
