extends Button

@onready var box_open: AnimatedSprite2D = $BoxOpen
@onready var play_button: Sprite2D = $PlayButton
@onready var play_button_outline: Sprite2D = $PlayButtonOutline

@export var button_function_texture : Texture2D
@export var button_function_outline_texture : Texture2D

func _ready() -> void:
	play_button.texture = button_function_texture
	play_button_outline.texture = button_function_outline_texture

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func mouse_entered() -> void:
	print("yea")
	box_open.play("default")
	play_button.scale = Vector2(1.,1.)
	play_button.modulate = Color.YELLOW
	

func mouse_exited() -> void:
	box_open.play_backwards()
	play_button.z_index = 0
	play_button.scale = Vector2(1,1)
	play_button.modulate = Color.WHITE
