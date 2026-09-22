extends Button

const PLAYER_MAX_HEALTH: int = 100
const PLAYER_SPAWN_X: int = -100
const PLAYER_SPAWN_Y: int = 34
const ENEMY_GROUP: String = "enemy"
const STARTING_SCORE: int = 0
const SCORE_LABEL_PREFIX: String = "Score: "
@export var player: Player
@export var score_label: Label 
@export var player_health_ui: TextureProgressBar
@export var pause_menu: Sprite2D

# Controls resetting of player health, location and score values.
# It kills all enemies, without giving score.
# This effectively resets the game without having to return to main menu.
func _on_pressed() -> void:
	player.score = STARTING_SCORE
	score_label.text = SCORE_LABEL_PREFIX + str(player.score) 
	player.position = Vector2(PLAYER_SPAWN_X, PLAYER_SPAWN_Y)
	player.player_current_health = PLAYER_MAX_HEALTH  
	player.player_health_ui.value = player.player_current_health
	get_tree().paused = false
	pause_menu.hide()

	for alive_enemy in get_tree().get_nodes_in_group(ENEMY_GROUP):
		alive_enemy.queue_free()
