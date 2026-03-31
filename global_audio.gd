extends Node

@onready var master_bus_id = AudioServer.get_bus_index("Master")
@onready var music_bus_id = AudioServer.get_bus_index("Music")
@onready var sfx_bus_id = AudioServer.get_bus_index("SFX")

func set_volume(bus_id: int, value: float):
	AudioServer.set_bus_volume_db(bus_id, linear_to_db(value))
	AudioServer.set_bus_mute(bus_id, value < 0.01)

func get_volume(bus_id: int) -> float:
	return db_to_linear(AudioServer.get_bus_volume_db(bus_id))

func get_volume_frame(value: float) -> int:
	if value <= 0.01:
		return 3 
	elif value < 0.33:
		return 2
	elif value < 0.66:
		return 1
	else:
		return 0
