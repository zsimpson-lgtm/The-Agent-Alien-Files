extends CharacterBody2D

const ATTACKING_FRAMES: Array[int] = [1, 2, 3]
const ATTACK_ANIMATION: String = "attack"
const PLAYER_GROUP: String = "player"
const KILL_SCORE: int = 1
const SPEED: float = 250.0
const GRAVITY: int = 9800

@onready var player = get_tree().get_first_node_in_group("player")
@onready var attack_area: Area2D = player.get_node("AttackComponents/AttackArea")
@onready var player_attack: AnimatedSprite2D = player.get_node("PlayerAnimation")


## Sets the pathing of the enemy to follow the player, setting gravity
## And horizontal velocity.
func _physics_process(delta: float) -> void:
	velocity.y = GRAVITY * delta
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity.x = direction.x * SPEED

	move_and_slide()


## Turns on the ability for the game to pick up enenies getting hit
## By the player providing that they are entering the player's proximity at
## The correct player animation frame.
func _process(_delta):
	if player_attack.animation == ATTACK_ANIMATION and player_attack.frame in ATTACKING_FRAMES:
		attack_area.monitoring = true 
	else:
		attack_area.monitoring = false


## This checks if the player's attack animation is at the correct visually
## Representative frames to kill the enemy.
func _on_area_2d_area_entered(area: Area2D) -> void:
	# It first checks if the erea it entered is in the player group
	# If not, the function returns and stops running.
	if not area.is_in_group(PLAYER_GROUP):
		return

	# Then it checks if the animation playing 
	# Is the player's attacking animation
	# If not, the function returns and stops running.
	if player_attack.animation != ATTACK_ANIMATION:
		return

	# Finally, the for loop checks each attack frame to see if it matches
	# The player's current animation frame. 
	# If it matches, the enemy dies.
	for frame in ATTACKING_FRAMES:
		if player_attack.frame == frame:
			enemy_die()
			break


## Controls what happens after an enemy die
func enemy_die() -> void:
	player.add_score(KILL_SCORE) # Adds kill score.
	queue_free() # Removes enemy.
