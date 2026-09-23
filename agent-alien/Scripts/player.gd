class_name Player
extends CharacterBody2D

const score_label_prefix: String = "Score: "
const SPEED: int = 400
const JUMP_VELOCITY: int = -400
const GRAVITY: int = 980
const ENEMY_DAMAGE: int = 10
const PLAYER_MAX_HEALTH: int = 100
const ENEMY_GROUP: String = "enemy"
const WALK: String = "walk"
const ATTACK: String = "attack"
const IDLE: String = "idle"
const PLAYER_NODE: String = "Player"
const ATTACK_REGION_LEFT_X: int = -130
const ATTACK_REGION_RIGHT_X: int = 190
const PLAYER_LEFT_SCALE: float = -3.5
const PLAYER_RIGHT_SCALE: float = 3.5

@export var player_health_ui: TextureProgressBar
@export var regeneration_amount: int = 10
@export var player_animation: AnimatedSprite2D
@export var score_label: Label
@export var damage_timer: Timer
@export var player_attack_region: Node2D
@export var attack_timer: Timer

var player: CharacterBody2D
var can_attack: bool = true
var is_attacking: bool = false
var score: int = 0
var player_current_health: int


## Assigns player variable, pauses game and sets the player health to 
## Maximum on start, setting attack region to not be at node, but at right.
func _ready() -> void:
	player = get_parent().get_node(PLAYER_NODE)
	get_tree().paused = true
	player_current_health = PLAYER_MAX_HEALTH
	player_attack_region.position.x = ATTACK_REGION_RIGHT_X


## Handles gravity, movement, jumping, attacking, and animations.
func _process(delta: float) -> void:
	# Applies gravity when player is off the ground
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Causes the player to jump when the jump key (space) is pressed.
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Assigns direction based on left/right inputs (a and d respectively).
	var direction := Input.get_axis("left", "right")
	
	# Sets horizontal velocity if direction is assigned.
	if direction:
		velocity.x = direction * SPEED
	# Otherwise, set horizontal velocity to 0.
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# If the player attacks, signal an attack is taking place, not allowing
	# The player to attack again until the triggered attack timer ends,
	# It plays the attack animation.
	if Input.is_action_just_pressed("attack") and can_attack:
		is_attacking = true
		can_attack = false
		player_animation.play(ATTACK)
		attack_timer.start()

	# If the player isn't attacking, allow the player to move, it plays
	# The walking animation, as well as move the player's attack region 
	# And flip the animation sprite based on the direction the player
	# Wants to move indicated by input of the respective movement keys 
	# If the player chooses not to move, and doesn't input
	# Movement keys, it plays the idle animation.
	elif not is_attacking:
		if Input.is_action_pressed("left"):
			player_animation.play(WALK)
			player_attack_region.position.x = ATTACK_REGION_LEFT_X
			player_animation.scale.x = PLAYER_LEFT_SCALE

		elif Input.is_action_pressed("right"):
			player_animation.play(WALK)
			player_attack_region.position.x = ATTACK_REGION_RIGHT_X
			player_animation.scale.x = PLAYER_RIGHT_SCALE
		else:
			player_animation.play(IDLE)

	move_and_slide()


## Starts the damaging timer when a enemy enters the player's proximity.
## And causes the player to take damage.
func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group(ENEMY_GROUP):
		take_damage()
		damage_timer.start()


## Stops the damaging timer when enemies exit the player'r proximity.
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group(ENEMY_GROUP):
		damage_timer.stop()


## Causes the player to take damage when the timer ends.
func _on_damage_timer_timeout() -> void:
	take_damage()


## Causes the enemy to lose health when they take damage, and die when their 
## Health reaches less than 1.
func take_damage() -> void:
	if player_current_health > 1:
		player_current_health -= ENEMY_DAMAGE
		player_health_ui.value = player_current_health
	else:
		get_tree().call_deferred("reload_current_scene")


## Controls attack cooldown, after timer ends it allows the player to attack
## Again and signals that they aren't attacking anymore.
func _on_attack_timer_timeout() -> void:
	can_attack = true
	is_attacking = false


## Increases score and updates the score label after killing an enemy 
func add_score(amount: int) -> void:
	score += amount
	score_label.text = score_label_prefix + str(score)


## Regenerates a portion of the player's health when the timer ends,
## If the enemy damage timer isn't ongoing signaling attacks are occuring.
func _on_regeneration_timer_timeout() -> void:
	if player_current_health < PLAYER_MAX_HEALTH and not damage_timer.time_left:
		player_health_ui.value += regeneration_amount
