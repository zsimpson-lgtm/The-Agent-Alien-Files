extends Button

func _on_pressed() -> void:
	get_tree().paused=false
	$"..".hide()
	$"../PlayPauseMenu".hide()
	$"../Restart".hide()
	$"../Menu".hide()
