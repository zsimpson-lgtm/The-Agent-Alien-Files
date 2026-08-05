extends CharacterBody2D

var speed: float = 250.0
var gravity = 980
@export var enemy_health: int = 1
var spawn
@onready var spawner: PackedScene = preload("res://Scenes/Enemy.tscn")
var attack_frames = [6, 7, 8]
var body
@onready var player = get_parent().get_node("Player")
@onready var enemy = get_parent().get_node("Enemy")
@onready var player_attack = player.get_node("AnimatedSprite2D")
var in_range: bool = false

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity.x = direction.x * speed

	move_and_slide()



func _on_area_2d_area_entered(body: Area2D) -> void:
	if body.is_in_group("Player") and player_attack.animation == "Attack" and player_attack.frame in attack_frames:
		take_damage()

func take_damage() -> void:
	enemy_health -= 1
	if enemy_health < 1:
		queue_free()
