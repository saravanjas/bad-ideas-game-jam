extends Area2D

var target : Area2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if target != null:
		global_position = global_position.move_toward(target.global_position , 500 * delta)


func collection_area_entered(area: Area2D) -> void:
	if area.has_method("set_target"):
		target = area.set_target()
