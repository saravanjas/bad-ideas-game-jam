extends Control

@onready var main_container = $MainContainer
@onready var options_container = $OptionsContainer

@onready var master_slider = $OptionsContainer/buttons/master
@onready var music_slider = $OptionsContainer/buttons/music
@onready var sfx_slider = $OptionsContainer/buttons/sfx

@onready var master_icon = $OptionsContainer/buttons/master/master_icon
@onready var music_icon = $OptionsContainer/buttons/music/music_icon
@onready var sfx_icon = $OptionsContainer/buttons/sfx/sfx_icon

func _ready():
	hide()
	main_container.show()
	options_container.hide()
	
	master_slider.value = GlobalAudio.get_volume(GlobalAudio.master_bus_id)
	music_slider.value = GlobalAudio.get_volume(GlobalAudio.music_bus_id)
	sfx_slider.value = GlobalAudio.get_volume(GlobalAudio.sfx_bus_id)
	
	update_all_icons()

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

func update_all_icons():
	master_icon.frame = GlobalAudio.get_volume_frame(master_slider.value)
	music_icon.frame = GlobalAudio.get_volume_frame(music_slider.value)
	sfx_icon.frame = GlobalAudio.get_volume_frame(sfx_slider.value)

func _on_master_value_changed(value: float) -> void:
	GlobalAudio.set_volume(GlobalAudio.master_bus_id, value)
	master_icon.frame = GlobalAudio.get_volume_frame(value)

func _on_music_value_changed(value: float) -> void:
	GlobalAudio.set_volume(GlobalAudio.music_bus_id, value)
	music_icon.frame = GlobalAudio.get_volume_frame(value)

func _on_sfx_value_changed(value: float) -> void:
	GlobalAudio.set_volume(GlobalAudio.sfx_bus_id, value)
	sfx_icon.frame = GlobalAudio.get_volume_frame(value)
