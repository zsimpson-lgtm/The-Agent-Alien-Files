extends Node2D

@onready var spawner: PackedScene = preload("res://Scenes/Enemy.tscn")
var spawn
var speed: int = 250.0
@export var enemy_health: int = 2



func _on_spawn_timer_timeout() -> void:
	var screen_width = get_viewport_rect().size.x
	var random_x = randf_range(screen_width * 0.05, screen_width * 0.95)	
	spawn = spawner.instantiate()
	spawn.global_position = Vector2(random_x, -15)
	add_child(spawn)
