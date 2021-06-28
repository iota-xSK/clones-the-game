extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LaunchPad_body_entered(body):
	body.outside_velocity = Vector2(0, 2 * body.jump_speed).rotated(rotation)

	$AnimatedSprite.play("default", true)
	#$AnimatedSprite.set_frame(0)
