extends Control
@onready var frame_1: TextureRect = $Frame1

@onready var color_rect: ColorRect = $ColorRect
var frame1_finished := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fadeIn()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if frame1_finished:
		if Input.is_anything_pressed():
			color_rect.modulate = Color(1,1,1,1)
			frame_1.hide()
			fadeIn()


func fadeIn():
	var tween = create_tween()
	tween.tween_property(color_rect , "modulate:a" , 0. , 3)
	tween.play()
	await tween.finished
	frame1_finished = true
