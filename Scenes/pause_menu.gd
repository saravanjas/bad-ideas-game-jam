extends Control

@onready var main_container = $MainContainer
@onready var options_container = $OptionsContainer

func _ready():
	hide()
	main_container.show()
	options_container.hide()

func _input(event):
	if event.is_action_pressed("Escape"): 
		toggle_pause()

func toggle_pause():
	var new_pause_state = !get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state
	
	if not new_pause_state:
		main_container.show()
		options_container.hide()

func _on_resume_pressed() -> void:
	toggle_pause()

func _on_options_pressed() -> void:
	main_container.hide()
	options_container.show()

func _on_back_pressed() -> void:
	options_container.hide()
	main_container.show()

func _on_quit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
