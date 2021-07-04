extends Node2D


func _ready():
	pass
	
func _on_Level2D_game_restart():
	$RigidBody2D.position = $Respawn.position
	$RigidBody2D.rotation = 0
