extends Control

func _ready() -> void:
	$buttons/master.value = GlobalAudio.get_volume(GlobalAudio.master_bus_id)
	$buttons/music.value = GlobalAudio.get_volume(GlobalAudio.music_bus_id)
	$buttons/sfx.value = GlobalAudio.get_volume(GlobalAudio.sfx_bus_id)

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_master_value_changed(value: float) -> void:
	GlobalAudio.set_volume(GlobalAudio.master_bus_id, value)
	
func _on_music_value_changed(value: float) -> void:
	GlobalAudio.set_volume(GlobalAudio.music_bus_id, value)
	
func _on_sfx_value_changed(value: float) -> void:
	GlobalAudio.set_volume(GlobalAudio.sfx_bus_id, value)
