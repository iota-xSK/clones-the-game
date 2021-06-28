extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const PLAYER = preload("res://templates/Player/Player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func spawn(player_scene, location):
	var player_instance = player_scene.instance()
	add_child(player_instance)
	player_instance.set_global_position(location)
func respawn():
	for child in get_children():
		if child.is_in_group("player_group"):
			child.queue_free()
	spawn(PLAYER, $Position2D.get_global_position())
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	#("trying to respawn...")
	respawn()
