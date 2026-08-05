extends CharacterBody2D

@onready var spawner: PackedScene = preload("res://Scenes/Enemy.tscn")
var spawn
var speed: int = 250.0
@export var enemy_health: int = 2

func _on_timer_2_timeout() -> void:
	spawn = spawner.instantiate()
	spawn.position = Vector2(190, -155.0)
	get_parent().add_child(spawn)

	move_and_slide()
