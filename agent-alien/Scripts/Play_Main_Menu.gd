extends Button

const STARTING_SCORE: int = 0
const SCORE_LABEL_PREFIX: String = "Score: "

@export var main_menu: Sprite2D
@export var score_label: Label 
@export var player: Player


## Starts the game when the play button is pressed.
## Shows score, setting it to the starting score of 0.
## Hides main menu and unpauses the game.
func _on_main_menu_play_button_pressed() -> void:
	main_menu.hide()
	score_label.show()
	score_label.text = SCORE_LABEL_PREFIX + str(STARTING_SCORE) 
	get_tree().paused = false
