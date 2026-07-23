extends Node2D
var speed: float = 250.0
var player 
var gravity = 980
@export var enemy_health: int = 1
var enemy
var spawn
var drip
@onready var spawner: PackedScene = preload("res://Scenes/Lava.tscn")



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	


func _on_timer_timeout() -> void:
	spawn = spawner.instantiate()
	var drip = get_tree().get_first_node_in_group("Lava")
	if drip:
		spawn.position = drip.global_position
	get_parent().add_child(spawn)
		
