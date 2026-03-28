extends Button

@onready var box_open: AnimatedSprite2D = $BoxOpen
@onready var options_button: Sprite2D = $OptionsButton
@onready var options_button_outline: Sprite2D = $OptionsButtonOutline

@export var button_function_texture : Texture2D
@export var button_function_outline_texture : Texture2D

func _ready() -> void:
	options_button.texture = button_function_texture
	options_button_outline.texture = button_function_outline_texture

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_mouse_entered() -> void:
	print("yea")
	box_open.play("default")
	options_button.scale = Vector2(1.,1.)
	options_button.modulate = Color.YELLOW


func _on_mouse_exited() -> void:
	box_open.play_backwards()
	options_button.z_index = 0
	options_button.scale = Vector2(1,1)
	options_button.modulate = Color.WHITE
