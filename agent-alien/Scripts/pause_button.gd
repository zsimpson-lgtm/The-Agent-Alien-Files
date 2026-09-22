extends TextureButton

@export var pause_menu: Sprite2D
@export var pause_menu_play: Button
@export var pause_menu_restart: Button
@export var pause_menu_menu: Button

# Shows the pause menu and its buttons when pressed, it also pauses the game.
func _on_pressed() -> void:
	pause_menu.show()
	pause_menu_play.show()
	pause_menu_restart.show()
	pause_menu_menu.show()
	get_tree().paused = true
