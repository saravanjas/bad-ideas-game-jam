extends Control
@onready var planet: AnimatedSprite2D = $Planet
@onready var  transitionBlackBlock: ColorRect = $ColorRect



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_quit_pressed() -> void:
	get_tree().quit()
	
func _on_play_button_pressed() -> void:
	transitionBlackBlock.visible = true
	for child in get_children():
		if not ( child is AnimatedSprite2D or child is Sprite2D):
			var tween = create_tween()
			tween.tween_property(child , "modulate:a" , 0 , 1)
			tween.play()
	await get_tree().create_timer(1.25).timeout
	planet.play("default")
	await get_tree().create_timer(2).timeout
	var screenTransition = create_tween()
	screenTransition.tween_property( transitionBlackBlock , "modulate:a" , 1 , 1.5)
	await screenTransition.finished
	get_tree().change_scene_to_file("res://game.tscn")


func _on_options_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/options.tscn")
