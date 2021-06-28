extends Button

var level_path
var test_thing = ""

func _on_LevelButton_pressed():
	get_tree().change_scene(level_path)
	print(test_thing)
