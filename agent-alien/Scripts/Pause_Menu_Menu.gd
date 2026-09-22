extends Button

const SCORE_LABEL_PREFIX: String = "Score: "
const STARTING_SCORE: int = 0
@export var main_menu: Sprite2D
@export var pause_menu: Sprite2D
@export var score_label: Label
@export var player: Player

# When pressed, it hides shows the main menu screen and its respective buttons.
# It also resets the score and pauses the game.
func _on_pressed() -> void:
	main_menu.show()
	pause_menu.hide()
	score_label.hide()
	get_tree().paused = true
	player.score = STARTING_SCORE
	score_label.text = SCORE_LABEL_PREFIX + str(player.score) 
