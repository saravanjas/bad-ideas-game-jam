extends CanvasLayer

var shown : bool = false
var mouse_pos : Vector2

@onready var sprite_2d: Sprite2D = $Control/AnimatedSprite2D/Sprite2D

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("build mode"):
		show_ui()
func show_ui():
	if !shown:
		shown = true
		var tween = create_tween()
		tween.tween_property($Control/ColorRect , "modulate:a" , 0.5 , 1)
		tween.play()
		await tween.finished
		$Control/AnimatedSprite2D.visible = true
		$Control/AnimatedSprite2D.play("default")
	else:
		$Control/AnimatedSprite2D.visible = false
		shown = false
		var tween = create_tween()
		tween.tween_property($Control/ColorRect , "modulate:a" , 0. , 0.25)
		tween.play()
		await tween.finished
