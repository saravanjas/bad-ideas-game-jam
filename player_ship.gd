extends ShipClass



@onready var tile_map_layer_body_: TileMapLayer = $"TileMapLayer(body)"
func _ready() -> void:
	tilemap = tile_map_layer_body_

func _physics_process(delta: float) -> void:
	pass
		
