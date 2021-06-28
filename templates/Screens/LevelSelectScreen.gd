extends Control

var test_thing

func _on_Button_pressed():
	get_tree().change_scene("res://templates/Screens/TitleScreen.tscn")
	print("test succes")
