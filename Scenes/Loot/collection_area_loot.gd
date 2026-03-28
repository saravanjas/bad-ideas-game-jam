extends Area2D
@onready var item_drop: Area2D = $".."


func collect():
	match item_drop.type:
		0:
			GlobalVariables.inventory["Cardboard"] += 1
			item_drop.queue_free()
		1:
			GlobalVariables.inventory["Tape"] += 1
			item_drop.queue_free()
		2:
			GlobalVariables.inventory["Screws"] += 1
			item_drop.queue_free()
