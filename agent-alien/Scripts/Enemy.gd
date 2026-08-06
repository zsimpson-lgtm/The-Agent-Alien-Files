extends CharacterBody2D

var speed: float = 250.0
var gravity = 980
@export var enemy_health: int = 1
var spawn
@onready var spawner: PackedScene = preload("res://Scenes/Enemy.tscn")
var attack_frames 
var body
@onready var player = get_parent().get_node("Player")
@onready var enemy = get_parent().get_node("Enemy")
@onready var player_attack = player.get_node("AnimatedSprite2D")
var in_range: bool = false
@onready var attack_area = player.get_node("Area2D2")

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity.x = direction.x * speed

	move_and_slide()

func _process(_delta):
	if player_attack.animation == "Attack" and player_attack.frame == 1:
		attack_area.monitoring = player_attack.frame in [1, 2, 3]
	else:
		attack_area.monitoring = false


func _on_area_2d_area_entered(body: Area2D) -> void:
	if body.is_in_group("Player") and player_attack.animation == "Attack":
		take_damage()

func take_damage() -> void:
	enemy_health -= 1
	if enemy_health < 1:
		queue_free()
