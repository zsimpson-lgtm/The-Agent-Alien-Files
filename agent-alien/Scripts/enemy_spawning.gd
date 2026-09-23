extends Node2D

const HALF: int = 2
const LOWER_BOUNDS: int = 35
const UPPER_BOUNDS: int = 100

@export var camera: Camera2D
@onready var spawner: PackedScene = preload("res://Scenes/Enemy.tscn")


## Spawns enemies and decides their spawn location 
func _on_spawn_timer_timeout() -> void:
	var camera_size = get_viewport_rect().size
	var camera_position = camera.global_position
	var left_bounds = camera_position.x - camera_size.x / HALF
	var right_bounds = camera_position.x + camera_size.x / HALF
	var random_x = randf_range(left_bounds, right_bounds)
	var random_y = randf_range(LOWER_BOUNDS, UPPER_BOUNDS)
	var enemy = spawner.instantiate()
	
	add_child(enemy)
	enemy.global_position = Vector2(random_x, random_y)
