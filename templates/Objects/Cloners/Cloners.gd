extends Node2D

var clone_timeout = false 


func _ready():
	var framerate = 8
	var duration = $ClonerEnter/Timer.get_wait_time()
	var frame_count = $ClonerEnter/ProgresBar.get_sprite_frames().get_frame_count("charging")
	$ClonerEnter/ProgresBar.set_speed_scale(frame_count/(duration * framerate))
	
func _on_ClonerEnter_body_entered(body): # clones the player
	if not clone_timeout:
		body.get_parent().spawn(body.get_parent().PLAYER, $ClonerExit.get_global_position())
		$ClonerEnter/ProgresBar.set_frame(0)
		$ClonerEnter/Timer.start()
		$ClonerEnter/ProgresBar.play("charging")
		clone_timeout = true


func _on_Timer_timeout():
	clone_timeout = false


func _on_ProgresBar_animation_finished():
	$ClonerEnter/ProgresBar.set_frame($ClonerEnter/ProgresBar.get_sprite_frames().get_frame_count("charging"))
	$ClonerEnter/ProgresBar.stop()
