extends Button

@export var pause_menu: Sprite2D
@export var pause_menu_play: Button
@export var pause_menu_restart: Button
@export var pause_menu_menu: Button


## Hides the pause menu and its buttons when pressed, it also unpauses the game.
func _on_pause_menu_play_button_pressed() -> void:
	pause_menu.hide()
	pause_menu_play.hide()
	pause_menu_restart.hide()
	pause_menu_menu.hide()
	get_tree().paused = false
