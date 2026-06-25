extends CharacterBody2D
var speed: float = 250.0
var player
var gravity = -980
var health: int = 10
var enemy
@export var health_ui: ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent().get_node("Player")
	enemy = get_parent().get_node("Enemy")
	health_ui.max_value = health
	health_ui.value = health
	pass	
			
func _process(delta: float) -> void:
	if not is_on_floor():
		gravity = 980
		velocity.y += gravity * delta
		
		if player:
			var direction = (player.global_position - global_position).normalized()
			velocity = direction * speed
		else:
			velocity = Vector2.ZERO
	
	move_and_slide()



func _damage_player(body: Node2D) -> void:
	if body == player:
		player.take_damage()

func take_damage() -> void:
	if health > 1:
		health -= 1
		health_ui.value = health
	else:
		get_tree().call_deferred("reload_current_scene")

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
		if body.is_in_group("Player"):
			enemy.take_damage()
