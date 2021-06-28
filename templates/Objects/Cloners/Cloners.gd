extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ClonerEnter_body_entered(body):
	#("cloner entered")
	#print(body)
	#print(body.get_parent())
	#print($ClonerEnter.position, $ClonerEnter.get_global_position())
	body.get_parent().spawn(body.get_parent().PLAYER, $ClonerExit.get_global_position())
