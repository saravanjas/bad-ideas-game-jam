extends Sprite2D

var mouse_pos : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if visible:
		mouse_pos = get_viewport().get_mouse_position() / get_viewport_rect().size
		material.set_shader_parameter('poz' , mouse_pos)
