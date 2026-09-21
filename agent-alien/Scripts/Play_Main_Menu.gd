extends Button

func _on_pressed() -> void:	
	$"..".hide()
	get_tree().paused = false
	$"../../score_label".show()
	
