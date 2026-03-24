extends ShipClass

@onready var character_body_2d: CharacterBody2D = $CharacterBody2D
@onready var tile_map_layer_body: TileMapLayer = $CharacterBody2D/TileMapLayer
@onready var root_center: Marker2D = $CharacterBody2D/RootCenter
@onready var camera_2d: Camera2D = $CharacterBody2D/Camera2D
@onready var enemy_spawn_positions: Path2D = $EnemySpawnPositions


func _ready() -> void:
	tilemap = tile_map_layer_body
	characterBody = character_body_2d
	rootCenter = root_center
	GlobalVariables.playerTilemap = tilemap
	GlobalVariables.playerBody = character_body_2d
	GlobalVariables.player = self
	GlobalVariables.playerCamera = camera_2d
func _physics_process(_delta: float) -> void:
	if GlobalVariables.gamePaused: return
	enemy_spawn_positions.global_position = character_body_2d.global_position
	resolvePhysics()
	character_body_2d.velocity = totalVelocity
	character_body_2d.rotation = character_body_2d.rotation + _delta*angularVelocity
	character_body_2d.move_and_slide()	
