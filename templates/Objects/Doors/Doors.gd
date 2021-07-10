extends Area2D

export (int, 1, 16) var clones_needed = 3

var indicators = []
var off_texture = load("res://Art/world/Doors/Indicator/indicator_off.png")
var on_texture = load("res://Art/world/Doors/Indicator/indicator_on.png")
var clone_array = []
var play_clone_animation = false
var clone_to_remove = 0

signal finished_level

func _ready():
	for i in clones_needed:
		var indicator_object = load("res://templates/Objects/Doors/Indicator.tscn").instance()
		$GridContainer.add_child(indicator_object)
		indicator_object.texture = off_texture
		indicators.append(indicator_object)


func _on_Doors_body_entered(body):
	if body.is_in_group("player_group"):
		clone_array.append(body)
		if len(clone_array) <= clones_needed:
			indicators[len(clone_array) - 1].texture = on_texture
		if len(clone_array) >= clones_needed:
			yield(get_tree().create_timer(0.5), "timeout")
			if len(clone_array) >= clones_needed:
				for clone in get_tree().get_nodes_in_group("player_group"):
					clone.movement = false
					clone.velocity = Vector2.ZERO
					clone.set_collision_mask(0b00000000000000000000)
					#clone.get_node("CollisionShape2D").disabled = true
				$Door.play()
 
func _on_Doors_body_exited(body):
	if body.is_in_group("player_group"):
		if len(clone_array) - 1 < clones_needed:
			indicators[len(clone_array) - 1].texture = off_texture
		clone_array.erase(body)
		
func move_clone(clone):
	clone.outside_velocity = $Door.get_global_transform().origin - clone.get_global_transform().origin

func _on_Door_animation_finished():
	play_clone_animation = true

func _physics_process(delta):
	if play_clone_animation and clone_array:
		move_clone(clone_array[clone_to_remove])
		if clone_array[0].get_global_transform().origin.distance_to($Door.get_global_transform().origin) < 4:
			clone_array[0].call_deferred("queue_free")
	elif play_clone_animation and not clone_array:
		emit_signal("finished level")
#	print(clone_array, clone_to_remove)
#	if clone_array and len(clone_array) > clone_to_remove:
#		print("passed")
#		if play_clone_animation:
#			move_clone(clone_array[clone_to_remove])
#		if clone_array[clone_to_remove].get_global_transform().origin.distance_to($Door.get_global_transform().origin) < 4:
#			clone_array[clone_to_remove].call_deferred("queue_free")
#			clone_to_remove += 1
	pass
