extends Button

@onready var enemy = get_parent().get_node("enemy")
@onready var player = $"../../../Player"
@onready var score_label: Label = $"../../score_label"
@export var health_ui: TextureProgressBar
func _on_pressed() -> void:
	player.score = 0
	score_label.text = "Score: " + str(player.score)

	$"../../../Player".position = Vector2(-100, 34)
	$"../../../Player".health = 100
	player.health_ui.max_value = player.health
	player.health_ui.value = player.health
	get_tree().paused=false
	$"..".hide()
	for enemy in get_tree().get_nodes_in_group("enemy"):
		enemy.queue_free()
		
