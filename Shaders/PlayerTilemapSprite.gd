extends Sprite2D


var pozicijamisa : Vector2 
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	visible = GlobalVariables.buildModeSetupFinished
	for child in $"..".get_children():
		child.visible = GlobalVariables.buildModeSetupFinished
	pozicijamisa = get_viewport().get_mouse_position() / get_viewport_rect().size
	material.set_shader_parameter('poz' , pozicijamisa )
