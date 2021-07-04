extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_LaunchPad_body_entered(body):
	body.outside_velocity = Vector2(0, 2 * body.jump_speed).rotated(rotation)

	$AnimatedSprite.play("default", true)
	#$AnimatedSprite.set_frame(0)
