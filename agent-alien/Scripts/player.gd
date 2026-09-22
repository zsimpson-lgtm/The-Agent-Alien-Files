class_name Player
extends CharacterBody2D

const score_label_prefix := "Score: "
const SPEED: int = 400
const JUMP_VELOCITY: int = -400
const GRAVITY: int = 980
const ENEMY_DAMAGE: int = 10
const PLAYER_MAX_HEALTH: int = 100
@export var player_health_ui: TextureProgressBar
@export var regen_amount: int = 10
@export var animation_player: AnimatedSprite2D
@export var score_lavel: Label
var player 
var touching_enemy
var player_attack
var can_attack: bool = true
var is_attacking
var score: int = 0
var player_current_health: int = 100
@onready var anim_player: AnimatedSprite2D = $Node2D/AnimatedSprite2D
@onready var score_label: Label = $"../CanvasLayer2/score_label"

func _ready() -> void:
	player_health_ui.max_value = PLAYER_MAX_HEALTH
	player_health_ui.value = player_current_health
	player = get_parent().get_node("Player")
	get_tree().paused = true

func _process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	if Input.is_action_pressed("jump") and is_on_floor() :
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("left", "right")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if Input.is_action_just_pressed("attack") and can_attack:
		is_attacking = true
		can_attack = false
		$AnimatedSprite2D.play("Attack")
		$Attack_Timer.start()

	elif not is_attacking:
		if Input.is_action_pressed("left"):
			$AnimatedSprite2D.play("Walk")
			$Node2D.position.x = -130
			$AnimatedSprite2D.scale.x = -3.5

		elif Input.is_action_pressed("right"):
			$AnimatedSprite2D.play("Walk")
			$Node2D.position.x = 190
			$AnimatedSprite2D.scale.x = 3.5
			

		else:
			$AnimatedSprite2D.play("Idle")

	move_and_slide()

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("enemy"):
		$Damage_Timer.start()

func _on_play_pressed() -> void:
	get_tree().paused = false

func _on_regen_timer_timeout() -> void:

	if player_current_health < PLAYER_MAX_HEALTH:
		player_health_ui.value += regen_amount

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		$Damage_Timer.stop()			

func _on_damage_timer_timeout() -> void:
	take_damage()

func take_damage() -> void:
	if player_current_health > 1:
		player_current_health -= ENEMY_DAMAGE
		player_health_ui.value = player_current_health
	else:
		get_tree().call_deferred("reload_current_scene")

func _on_attack_timer_timeout() -> void:
	can_attack = true
	is_attacking = false

# Increases score and updates the score label after killing an enemy 
func add_score(amount: int) -> void:
	score += amount
	score_label.text = score_label_prefix + str(score)
