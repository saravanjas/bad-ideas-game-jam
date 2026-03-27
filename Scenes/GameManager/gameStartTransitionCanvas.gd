extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var fadeOut = create_tween()
	fadeOut.tween_property(color_rect , "modulate:a" , 0.0 , 1.5)
	await fadeOut.finished
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
