extends Area2D

var d
#var d = position.x - $Position2D.position.x
var g # gravity
export (float) var launch_angle = 60
var launch_height = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	d = $Position2D.position.x
	g = get_parent().get("gravity")
	if gravity == null:
		push_error("Parent of the player doesn't have gravity. Please put in a Level2D node. Setting gravity to 1300")
		gravity = 1300

func _on_LaunchPad_body_entered(body):
	var velocity = Vector2.ZERO
	#body.outside_velocity = Vector2(0, -600).rotated(rotation)
	#velocity.y = -1 * 1/cos(launch_angle) * sqrt((g/2 * d * d) / (d * tan(launch_angle + launch_height)))
	#velocity.y = -300
	body.outside_velocity = velocity.rotated(deg2rad(launch_angle))
	$AnimatedSprite.play("default", true)
	#$AnimatedSprite.set_frame(0)
