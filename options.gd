extends Control

@onready var master_bus_id = AudioServer.get_bus_index("Master")
@onready var music_bus_id = AudioServer.get_bus_index("Music")
@onready var sfx_bus_id = AudioServer.get_bus_index("SFX")

func _ready() -> void:
	$buttons/master.value = db_to_linear(AudioServer.get_bus_volume_db(master_bus_id))
	$buttons/music.value = db_to_linear(AudioServer.get_bus_volume_db(music_bus_id))
	$buttons/sfx.value = db_to_linear(AudioServer.get_bus_volume_db(sfx_bus_id))

func _on_master_value_changed(value: float) -> void:
	GlobalAudio.set_volume(GlobalAudio.master_bus_id, value)

func _on_music_value_changed(value: float) -> void:
	GlobalAudio.set_volume(GlobalAudio.music_bus_id, value)

func _on_sfx_value_changed(value: float) -> void:
	GlobalAudio.set_volume(GlobalAudio.sfx_bus_id, value)

func _on_back_pressed() -> void:
	UINodeAccess.MainMenu.visible = true
	UINodeAccess.OptionsMenu.visible = false
	
