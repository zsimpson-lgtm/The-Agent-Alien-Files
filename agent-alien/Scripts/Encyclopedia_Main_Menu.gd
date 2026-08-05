extends TextureButton

func _on_pressed() -> void:
	$"../../MainMenu".show()
	$"..".hide()
