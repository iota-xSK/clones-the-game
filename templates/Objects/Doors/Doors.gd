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
			yield(get_tree().create_timer(1.0), "timeout")
			print("won")
func _on_Doors_body_exited(body):
	if body.is_in_group("player_group"):
		if len(clone_array) - 1 < clones_needed:
			indicators[len(clone_array) - 1].texture = off_texture
		clone_array.erase(body)
		
func move_clone(clone):
	clone.outside_velocity = $Door.get_global_transform().origin - clone.get_global_transform().origin

func _on_Door_animation_finished():
	pass
#	print("animation finished")
#	play_clone_animation = true

func _physics_process(delta):
#	if clone_array and len(clone_array) > clone_to_remove:
#		if play_clone_animation:
#			move_clone(clone_array[clone_to_remove])
#		if clone_array[clone_to_remove].get_global_transform().origin.distance_to($Door.get_global_transform().origin) < 4:
#			clone_array[clone_to_remove].call_deferred("queue_free")
#			clone_to_remove += 1
	pass
