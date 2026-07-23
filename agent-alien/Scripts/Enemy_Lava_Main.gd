extends CharacterBody2D

@onready var spawner: PackedScene = preload("res://Scenes/Lava.tscn")
var spawn
var speed = 250.0
@export var enemy_health: int = 2
var gravity = 980
var player
var move_direction: Vector2 = Vector2.ZERO
var direction = [Vector2.LEFT, Vector2.RIGHT].pick_random()

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	var player = get_tree().get_first_node_in_group("Player")
	if player:
		position += direction * speed * delta
func choose_random_direction() -> void:
	if randf() < 0.5:
		direction = Vector2.LEFT
	else:
		direction = Vector2.RIGHT

	move_and_slide()


func _on_timer_2_timeout() -> void:
	choose_random_direction()
