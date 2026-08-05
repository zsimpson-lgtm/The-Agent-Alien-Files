extends TextureButton

func _ready() -> void:
	get_node("Node2D/CanvasLayer2/Pause Menu")
	print("node")

func _process(delta: float) -> void:
	pass

func _on_pressed() -> void:
	$"../PauseMenu".show()
	$"../PauseMenu/PlayPauseMenu".show()
	$"../PauseMenu/Restart".show()
	$"../PauseMenu/Menu".show()
	get_tree().paused=true
