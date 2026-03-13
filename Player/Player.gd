extends ShipClass

@onready var character_body_2d: CharacterBody2D = $CharacterBody2D
@onready var tile_map_layer_body: TileMapLayer = $"CharacterBody2D/TileMapLayer"
@onready var root_center: Marker2D = $CharacterBody2D/RootCenter


func _ready() -> void:
	tilemap = tile_map_layer_body
	characterBody = character_body_2d
	rootCenter = root_center
	GlobalVariables.playerTilemap = tile_map_layer_body

func _physics_process(_delta: float) -> void:
	if GlobalVariables.gamePaused: return
	
	resolvePhysics()
	character_body_2d.velocity = totalVelocity
	character_body_2d.rotation = character_body_2d.rotation + _delta*angularVelocity
	character_body_2d.move_and_slide()	
