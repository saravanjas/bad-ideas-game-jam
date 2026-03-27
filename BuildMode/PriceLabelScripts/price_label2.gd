extends Label


@onready var parentTexture : Sprite2D = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if int(self.text) == 0:
		parentTexture.modulate = Color(0,0,0,0.2)
	else:
		parentTexture.self_modulate = Color.WHITE
	if GlobalVariables.inventory["Tape"] < int(text):
		self_modulate = Color.DARK_RED
	else:
		self_modulate = Color.WHITE
