extends Area2D
@onready var item_drop: Area2D = $".."

@onready var cardboard_pickup: AudioStreamPlayer2D = $"../CardboardPickup"
@onready var duct_tape_pickup: AudioStreamPlayer2D = $"../DuctTapePickup"
@onready var nail_pickup: AudioStreamPlayer2D = $"../NailPickup"


func collect():
	match item_drop.type:
		0:
			cardboard_pickup.pitch_scale = randf_range(0.8 , 1.2)
			cardboard_pickup.play()
			hideItem()
			GlobalVariables.inventory["Cardboard"] += 1
			await cardboard_pickup.finished
			item_drop.queue_free()
		1:
			duct_tape_pickup.pitch_scale = randf_range(0.7,1.1)
			duct_tape_pickup.play()
			hideItem()
			GlobalVariables.inventory["Tape"] += 1
			await duct_tape_pickup.finished
			item_drop.queue_free()
		2:
			nail_pickup.pitch_scale = randf_range(1,1.2)
			nail_pickup.play()
			hideItem()
			GlobalVariables.inventory["Screws"] += 1
			await nail_pickup.finished
			item_drop.queue_free()
func hideItem():
	item_drop.visible = false
