extends CharacterBody2D
var speed: float = 250.0
var player: CharacterBody2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for node in get_tree().get_nodes_in_group("player"):
		player = node
		
func _process(delta: float) -> void:
	look_at(player.global_position)
	velocity = Vector2(1, 0).rotated(rotation) * speed




	move_and_slide()
