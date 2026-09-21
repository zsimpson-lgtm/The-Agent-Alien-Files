extends CharacterBody2D

@onready var spawner: PackedScene = preload("res://Scenes/Enemy.tscn")
@onready var enemy = get_parent().get_node("enemy")
@onready var player = get_tree().get_first_node_in_group("player")
@onready var attack_area: Area2D = player.get_node("Node2D/Area2D2")
@onready var player_attack: AnimatedSprite2D = player.get_node("AnimatedSprite2D")
var attack_frames 
var speed: float = 250.0
var gravity = 980
var spawn
const attacking_frames = [1,2,3]
const attack_animation = "Attack"
const player_group = "player"
const kill_score = 1
func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity.x = direction.x * speed

	move_and_slide()

func _process(_delta):
	if player_attack.animation == attack_animation and player_attack.frame in attacking_frames:
		attack_area.monitoring = true 
	else:
		attack_area.monitoring = false
# This checks if the player's attack animation is at the correct visually
# Representative frames to deal damage to the enemy.
func _on_area_2d_area_entered(area: Area2D) -> void:
	# It first checks if the erea it entered is in the player group
	# If not, the function returns and stops running.
	if not area.is_in_group(player_group):
		return
	# Then it checks if the animation playing 
	# Is the player's attacking animation
	# If not, the function returns and stops running.
	if player_attack.animation != attack_animation:
		return
	# Finally, the for loop checks each attack frame to see if it matches
	# The player's current animation frame. 
	# If it matches, the enemy takes damage.
	for frame in attacking_frames:
		if player_attack.frame == frame:
			take_damage()
			break


func take_damage() -> void:
	player.add_score(kill_score)
	queue_free()
	
	
