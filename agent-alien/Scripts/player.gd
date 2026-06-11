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


#func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
		#if body.is_in_group("Enemy"):
			#queue_free()
	
