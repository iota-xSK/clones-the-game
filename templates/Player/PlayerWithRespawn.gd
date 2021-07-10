extends Node2D

const PLAYER = preload("res://templates/Player/Player.tscn")
var safe_to_respawn = true

# Called when the node enters the scene tree for the first time.
func _ready():
	respawn() # Not to sound like a valve dev, but I know it sound pointless, but it fixes a bug. DO NOT TOUCH!
	#					 the bug is that the first time when the player spawns, it doesn't auto-respawn them. it throws an erros: E 0:00:01.322   emit_signal: Error calling method from signal 'screen_exited': 'Node2D(PlayerWithRespawn.gd)::_on_VisibilityNotifier2D_screen_exited': Method not found..
	#						<C++ Source>  core/object.cpp:1257 @ emit_signal()


func on_Player_screen_exited():
#	print("respawner got message, waiting...")
	yield(get_tree().create_timer(1.0), "timeout")
	#if len(get_tree().get_nodes_in_group("player_group")) == 0 and safe_to_respawn == true:
	#	safe_to_respawn = false
	#	respawn()
	yield(get_tree().create_timer(1.0), "timeout")
	safe_to_respawn = true


func spawn(player_scene, location):
	var player_instance = player_scene.instance()
	call_deferred("add_child", player_instance)
	player_instance.call_deferred("set_global_position", location)
	player_instance.connect("on_screen_exited", self, "on_Player_screen_exited")
	
func respawn():
	for child in get_children():
		if child.is_in_group("player_group"):
			#child.queue_free()
			child.call_deferred("queue_free")
	spawn(PLAYER, $Position2D.get_global_position())
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	#("trying to respawn...")
	respawn()
