extends Control

@onready var master_slider = $buttons/master
@onready var music_slider = $buttons/music
@onready var sfx_slider = $buttons/sfx

@onready var master_icon = $buttons/master/master_icon
@onready var music_icon = $buttons/music/music_icon
@onready var sfx_icon = $buttons/sfx/sfx_icon
@onready var box_placement_sfx: AudioStreamPlayer = $boxPlacementSFX

func _ready() -> void:
	master_slider.value = GlobalAudio.get_volume(GlobalAudio.master_bus_id)
	music_slider.value = GlobalAudio.get_volume(GlobalAudio.music_bus_id)
	sfx_slider.value = GlobalAudio.get_volume(GlobalAudio.sfx_bus_id)
	
	update_all_icons()

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

func _on_back_pressed() -> void:
	UINodeAccess.MainMenu.visible = true
	UINodeAccess.OptionsMenu.visible = false
	


func back_mouse_entered() -> void:
	box_placement_sfx.play()
