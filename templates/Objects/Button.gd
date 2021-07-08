extends Area2D

var pressing_bodies = 0

signal pressed
signal released

func _ready():
	pass


func _on_Button_body_entered(body):
	pressing_bodies += 1
	if pressing_bodies > 0:
		$AnimatedSprite.frame = 1
		emit_signal("pressed")

func _on_Button_body_exited(body):
	pressing_bodies -= 1
	if pressing_bodies == 0:
		$AnimatedSprite.frame = 0
		emit_signal("released")
