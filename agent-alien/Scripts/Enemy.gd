extends CharacterBody2D
var speed: float = 250.0
var player



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent().get_node("Player")
	pass	
			
func _process(delta: float) -> void:
	look_at(player.global_position)
	velocity = Vector2(1, 0).rotated(rotation) * speed

	move_and_slide()
	
func _damage_player(body: Node2D) -> void:
	if body == player:
		player.take_damage()
