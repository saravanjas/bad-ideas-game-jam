extends Button

@onready var box_open: AnimatedSprite2D = $BoxOpen
@onready var quit_button: Sprite2D = $QuitButton
@onready var quit_button_outline: Sprite2D = $QuitButtonOutline

@export var button_function_texture : Texture2D
@export var button_function_outline_texture : Texture2D
@onready var box_placement_sfx: AudioStreamPlayer = $"../../boxPlacementSFX"

func _ready() -> void:
	quit_button.texture = button_function_texture
	quit_button_outline.texture = button_function_outline_texture

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_mouse_entered() -> void:
	box_placement_sfx.play()
	print("yea")
	box_open.play("default")
	quit_button.scale = Vector2(1.,1.)
	quit_button.modulate = Color.RED


func _on_mouse_exited() -> void:
	box_open.play_backwards()
	quit_button.z_index = 0
	quit_button.scale = Vector2(1,1)
	quit_button.modulate = Color.WHITE
