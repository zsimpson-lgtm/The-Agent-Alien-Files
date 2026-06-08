extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0
var collided_body
var score: int = 0
var gravity: = 980

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if not is_on_floorand not .is_colliding():
		gravity = 980
		velocity.y += gravity * delta
		
	if Input.is_action_pressed("jump") and is_on_floor() :
		velocity.y = JUMP_VELOCITY
	
	var direction : = Input.get_axis("left", "right")
	velocity.x = direction * SPEED

	move_and_slide()
	pass
