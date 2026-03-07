extends ShipClass

@onready var character_body_2d: CharacterBody2D = $CharacterBody2D
@onready var tile_map_layer_body: TileMapLayer = $"CharacterBody2D/TileMapLayer"


func _ready() -> void:
	tilemap = tile_map_layer_body

func _physics_process(_delta: float) -> void:
	var modules:Array[ModuleClass]
	modules = getAllModules()

	resolvePhysics()
	character_body_2d.velocity = totalVelocity	
	character_body_2d.move_and_slide()	
