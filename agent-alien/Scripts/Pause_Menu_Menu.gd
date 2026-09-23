extends Button


## When pressed, restarts the game.
func _on_pause_menu_main_menu_button_pressed() -> void:
	get_tree().reload_current_scene()
