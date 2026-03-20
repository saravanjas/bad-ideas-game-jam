extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_tree().current_scene.find_children("Projectiles", "Node", true):
		GlobalVariables.projectilesNode = child
		break


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
