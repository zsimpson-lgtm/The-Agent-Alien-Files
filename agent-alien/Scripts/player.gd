extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -400.0
var gravity: = 980
var health: int = 100
var player 
var touching_enemy
var player_attack
var can_attack: bool = true
var is_attacking
@export var health_ui: TextureProgressBar
@export var regen_amount: int = 5
@onready var anim_player: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	health_ui.max_value = health
	health_ui.value = health
	player = get_parent().get_node("Player")
	get_tree().paused = true

func _process(delta: float) -> void:
	if not is_on_floor():
		gravity = 980
		velocity.y += gravity * delta

	if Input.is_action_pressed("jump") and is_on_floor() :
		velocity.y = JUMP_VELOCITY

	var direction : = Input.get_axis("left", "right")

	if Input.is_action_pressed("left"):
		$Node2D.scale.x = -1
	else:
		$Node2D.scale.x = 1

	if Input.is_action_pressed("attack") and $Attack_Timer.is_stopped():
		$Node2D/AnimatedSprite2D.play("Attack")
		$Attack_Timer.start()
		velocity.x = 0


	elif direction:
		velocity.x = direction * SPEED
		$Node2D/AnimatedSprite2D.play("Walk")

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$Node2D/AnimatedSprite2D.play("Idle")
	
	

	move_and_slide()

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	var enemy = get_tree().get_first_node_in_group("Enemy")
	if body.is_in_group("Enemy"):
		$Damage_Timer.start()

func _on_play_pressed() -> void:
	get_tree().paused = false

func _on_regen_timer_timeout() -> void:
	if health < 100:
		health_ui.value += regen_amount

func _on_area_2d_2_area_entered(area: Area2D) -> void:
	var enemy = get_tree().get_first_node_in_group("Enemy")

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		$Damage_Timer.stop()			

func _on_damage_timer_timeout() -> void:
	take_damage()

func take_damage() -> void:
	if health > 1:
		health -= 5
		health_ui.value = health
		print("hi")
	else:
		get_tree().call_deferred("reload_current_scene")

#func _on_attack_timer_timeout() -> void:
	#can_attack = true
	#is_attacking = false
