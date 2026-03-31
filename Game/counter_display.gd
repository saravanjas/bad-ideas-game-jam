extends Sprite2D

var local_count = -1 

func _process(_delta):
	var current_global_count = GlobalVariables.anntenaeDestroyed
	
	if current_global_count != local_count:
		local_count = clamp(current_global_count, 0, 4)
		frame = local_count
