extends Control


## GRID BUILDER CONSTANTS
const COLLECTION_ID = 0
const MAX_TILE_ID = 4
##

## GRID VARIABLES
@onready var tilemap:TileMapLayer = GlobalVariables.playerTilemap
var inBuildMode:bool = false
var selectedBoxId:int = 1
var moduleLookVector := Vector2.RIGHT.normalized()
var lastPlacedTile:ModuleClass
var playerRotationInformation : float
@onready var playerAccess : Node2D = $"../Player/PlayerShip".get_child(0)
##

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var animated_sprite_2d: AnimatedSprite2D = $CanvasLayer/AnimatedSprite2D
@onready var texture_rect: TextureRect = $CanvasLayer/Background

var cd := false
func _process(delta: float) -> void:
	#print(cd)
	resolveBuildMode()
	animated_sprite_2d.visible = GlobalVariables.inBuildMode

func resolveBuildMode():
	if cd: return 
	if Input.is_action_just_pressed("Space"):
		if not GlobalVariables.inBuildMode:
			playerRotationInformation = playerAccess.rotation
			print(playerRotationInformation)
			cd = true
			GlobalVariables.inBuildMode  = true
			canvas_layer.visible = true
			animated_sprite_2d.play()
			await animated_sprite_2d.animation_finished 
			
			var backgroundAppearTween = create_tween()
			backgroundAppearTween.tween_property(texture_rect , "modulate:a" , 1.0 , 0.67)
			backgroundAppearTween.play()
			await backgroundAppearTween.finished
			
			cd = false
			
			var playerRotationTween = create_tween()
			playerRotationTween.set_trans(Tween.TRANS_EXPO)
			playerRotationTween.tween_property( playerAccess , "rotation" , 0 , 0.3 )
			playerRotationTween.play()
			await playerRotationTween.finished
			
			GlobalVariables.buildModeSetupFinished = true
		else:
			var resetPlayerPosAndBackground = create_tween()
			resetPlayerPosAndBackground.set_parallel(true)
			resetPlayerPosAndBackground.tween_property(texture_rect , "modulate:a" , 0.0 , 0.25)
			resetPlayerPosAndBackground.set_trans(Tween.TRANS_EXPO)
			resetPlayerPosAndBackground.tween_property( playerAccess , "rotation" , playerRotationInformation , 0.3 )
			resetPlayerPosAndBackground.play()
			
			GlobalVariables.inBuildMode  = false
			GlobalVariables.buildModeSetupFinished = false
			
			canvas_layer.visible = false
	
	if GlobalVariables.inBuildMode:
		GlobalVariables.gamePaused = true
		buildMode()
	else:
		GlobalVariables.gamePaused = false


func buildMode():
	tilemap = GlobalVariables.playerTilemap
	if Input.is_action_just_pressed("LeftClick"):
		print(tilemap)
		var mousePos = get_global_mouse_position()
		mousePos = tilemap.to_local(mousePos)
		mousePos = tilemap.local_to_map(mousePos)
		tilemap.set_cell(mousePos, COLLECTION_ID , Vector2i(0,0), selectedBoxId) #position of tile locally, id of collection, vecotr2i(0,0), id of tile
		tilemap.child_entered_tree.connect(getCellInstance.bind())
		await tilemap.child_entered_tree
		if lastPlacedTile.has_method("rotateModule"):
			lastPlacedTile.rotateModule(moduleLookVector.angle())
			
	#rotate module
	if Input.is_action_just_pressed("r"):
		var angle = moduleLookVector.angle()
		angle += PI/2.0
		moduleLookVector = Vector2.from_angle(angle).normalized()

	#select different modules
	if Input.is_action_just_pressed("ScrollDown"):
		selectedBoxId -= 1
		selectedBoxId = calibrateBoxId(selectedBoxId)
	elif Input.is_action_just_pressed("ScrollUp"):
		selectedBoxId += 1
		selectedBoxId = calibrateBoxId(selectedBoxId)

func calibrateBoxId(id:int):
	var ret = id
	if id <= 0:
		ret = MAX_TILE_ID
	elif id > MAX_TILE_ID:
		ret = 1
	return ret


func getCellInstance(child:ModuleClass):
	lastPlacedTile = child
