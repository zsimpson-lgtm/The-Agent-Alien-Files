extends CharacterBody2D
var speed: float = 250.0
var player 
var gravity = 980
@export var enemy_health: int = 1
var enemy
var spawn
@onready var spawner: PackedScene = preload("res://Scenes/Enemy.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent().get_node("Player")
	enemy = get_parent().get_node("Enemy")
	
			
func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	var player = get_tree().get_first_node_in_group("Player")
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity.x = direction.x * speed
	


	
	move_and_slide()



func _damage_player(body: Node2D) -> void:
	if body == player:
		player.take_damage()

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
		if body.is_in_group("Player") and body.anim_player.is_playing():
			take_damage()






	




func take_damage() -> void:
	enemy_health -= 1
	if enemy_health < 1:
		queue_free()
				
