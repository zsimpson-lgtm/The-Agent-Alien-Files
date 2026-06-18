extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("Node2D/CanvasLayer2/Pause Menu")
	print("node")
	

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	$"../PauseMenu".show()
	$"../PauseMenu/PlayPauseMenu".show()
	$"../PauseMenu/Restart".show()
	$"../PauseMenu/Menu".show()
	get_tree().paused=true
