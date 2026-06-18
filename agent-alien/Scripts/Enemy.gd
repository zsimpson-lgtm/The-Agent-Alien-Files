extends CharacterBody2D
var speed: float = 250.0
var player
var gravity = 980


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent().get_node("Player")
	pass	
			
func _process(delta: float) -> void:
	if not is_on_floor():
		gravity = 980
		velocity.y += gravity * delta
	#else:
		#look_at(player.global_position)	
		#velocity = Vector2(1, 0).rotated(rotation) * speed
	#
	move_and_slide()

func _flip():
	$Sprite2D.flip_h
	

func _damage_player(body: Node2D) -> void:
	if body == player:
		player.take_damage()
