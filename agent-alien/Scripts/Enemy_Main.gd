extends Node2D

@onready var spawner: PackedScene = preload("res://Scenes/Enemy.tscn")
var spawn
var speed: int = 250.0 
@export var enemy_health: int = 2
@onready var camera: Camera2D = $"../Player/Camera2D"



func _on_spawn_timer_timeout() -> void:
	var camera_size = get_viewport_rect().size
	var camera_position = camera.global_position
	var left_bounds = camera_position.x - camera_size.x / 2
	var right_bounds = camera_position.x + camera_size.x / 2
	var random_x = randf_range(left_bounds, right_bounds)
	var enemy = spawner.instantiate()
	add_child(enemy)
	enemy.global_position = Vector2(random_x, -15)
