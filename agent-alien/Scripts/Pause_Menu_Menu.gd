extends Button

func _on_pressed() -> void:
	$"../../MainMenu".show()
	$"..".hide()
	get_tree().paused = true
