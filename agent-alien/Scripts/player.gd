extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0
var collided_body
var score: int = 0
var gravity: = 980
var health: int = 10
var player = CharacterBody2D
@export var health_ui: TextureProgressBar
func _ready() -> void:
	health_ui.max_value = health
	health_ui.value = health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	

	
	if not is_on_floor():
		gravity = 980
		velocity.y += gravity * delta
		
	if Input.is_action_pressed("jump") and is_on_floor() :
		velocity.y = JUMP_VELOCITY
	
	var direction : = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


	pass

	move_and_slide()


	
	
	pass # Replace with function body.
	
func take_damage() -> void:
	if health > 1:
		health -= 1
		health_ui.value = health
	else:
		get_tree().call_deferred("reload_current_scene")

#func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
		#if body.is_in_group("Enemy"):
			#player.take_damage
	
