extends Area2D

var pressing_bodies = 0
var pressed = false

signal pressed
signal released

func _ready():
	pass


func _on_Button_body_entered(body):
	pressing_bodies += 1
	if pressing_bodies > 0:
		$AnimatedSprite.frame = 1
		emit_signal("pressed")
		pressed = true

func _on_Button_body_exited(body):
	pressing_bodies -= 1
	if pressing_bodies == 0:
		$AnimatedSprite.frame = 0
		emit_signal("released")
		pressed = false
