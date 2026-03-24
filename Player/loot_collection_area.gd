extends Area2D


func area_entered(area: Area2D) -> void:
	area.collect()
