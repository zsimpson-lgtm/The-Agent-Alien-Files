extends Label
var Score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func take_damage() -> void:
	Score += 1
	text = "Score: %s" % Score
