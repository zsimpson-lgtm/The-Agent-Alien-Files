extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -400.0
var collided_body
var score: int = 0
var gravity: = 980
var health: int = 100
var player 
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
		$AnimatedSprite2D.flip_h = true

	else:
		$AnimatedSprite2D.flip_h = false

	if Input.is_action_pressed("attack"):
		$AnimatedSprite2D.play("Attack")

	elif direction and Input.is_action_pressed("walk"):
		velocity.x = direction * SPEED
		$AnimatedSprite2D.play("Walk")

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func take_damage() -> void:
	if health > 1:
		health -= 5
		health_ui.value = health

	else:
		get_tree().call_deferred("reload_current_scene")

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
		if body.is_in_group("Enemy"):
			take_damage()

func _on_play_pressed() -> void:
	get_tree().paused = false

func _on_regen_timer_timeout() -> void:
	if health < 100:
		health_ui.value += regen_amount


func _on_area_2d_2_area_entered(area: Area2D) -> void:
	var enemy = get_tree().get_first_node_in_group("Enemy")
