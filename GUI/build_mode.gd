extends Control

const COLLECTION_ID = 0
const MAX_TILE_ID = 4

var tilemap:TileMapLayer #= GlobalVariables.playerTilemap
var player:ShipClass #= GlobalVariables.player
var inBuildMode:bool = false
var selectedBoxId:int = 1
var moduleLookVector := Vector2.RIGHT.normalized()
var lastPlacedTile:ModuleClass

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var animated_sprite_2d: AnimatedSprite2D = $CanvasLayer/AnimatedSprite2D
@onready var cameraSelf: Camera2D = $CanvasLayer/AnimatedSprite2D/Camera2D
@onready var item_list: ItemList = $CanvasLayer/ItemList


var cd := false	

func _ready() -> void:	
	await get_tree().process_frame
	player = GlobalVariables.player
	tilemap = GlobalVariables.playerTilemap
	
	tilemap.child_entered_tree.connect(getCellInstance.bind())
	item_list.item_selected.connect(changeSelection.bind())

func _process(delta: float) -> void:
	#print(cd)
	resolveBuildMode()

func resolveBuildMode():
	if GlobalVariables.inBuildMode:
		buildMode()
		
	if cd: return 
	if Input.is_action_just_pressed("Space"):
		if not GlobalVariables.inBuildMode:
			cd = true
			GlobalVariables.gamePaused  = true
			canvas_layer.visible = true
			player.visible = false
			
			refreshModuleList()
			animated_sprite_2d.play()
			await animated_sprite_2d.animation_finished
			
			player.visible = true
			GlobalVariables.inBuildMode = true 
			setShip()
			cd = false
		else:
			GlobalVariables.gamePaused  = false
			GlobalVariables.inBuildMode = false
			canvas_layer.visible = false
			setShip()
	
func buildMode():
	if Input.is_action_just_pressed("LeftClick"):
		#var mousePos = get_global_mouse_position()
		var mousePos = get_viewport().get_mouse_position()
		mousePos = tilemap.to_local(mousePos)
		mousePos = tilemap.local_to_map(mousePos)
		
		
		if not checkIfInRange(mousePos, 2): return
		tilemap.set_cell(mousePos, COLLECTION_ID , Vector2i(0,0), selectedBoxId) #position of tile locally, id of collection, vecotr2i(0,0), id of tile
		
		var angle = moduleLookVector.angle()
		player.moduleRotations[mousePos] = angle

		await tilemap.child_entered_tree
	
		lastPlacedTile.rotateModule()#moduleLookVector.angle()
			
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

func checkIfHasNeighbour(pos:Vector2i):
	var directions = [
		Vector2i(1,0),   # right
		Vector2i(-1,0),  # left
		Vector2i(0,1),   # down
		Vector2i(0,-1)   # up
	]
	
	for dir in directions:
		var neighbor = pos + dir
		if tilemap.get_cell_source_id(neighbor) != -1:
			return true
			
	return false

func checkIfInRange(pos:Vector2, rangei:int):
	if abs(pos.x) <= rangei and abs(pos.y) <= rangei:
		return true
	else:
		return false

func calibrateBoxId(id:int):
	var ret = id
	if id <= 0:
		ret = MAX_TILE_ID
	elif id > MAX_TILE_ID:
		ret = 1
	return ret

func getCellInstance(child:ModuleClass):
	lastPlacedTile = child

var lastPos:Vector2 #GlobalVariables.player.global_position
var lastRotation:float #GlobalVariables.player.rotation
var lastTransfrom:Transform2D
func setShip():
	var playerBody = GlobalVariables.playerBody
	var cameraPlayer = GlobalVariables.camera
	
	if GlobalVariables.inBuildMode:
		lastPos = playerBody.global_position
		lastRotation = playerBody.rotation
		lastTransfrom = player.global_transform
		
		cameraPlayer.enabled = false
		cameraSelf.enabled = true
		
		player.reparent(canvas_layer)
		playerBody.global_position = animated_sprite_2d.to_global(Vector2.ZERO)
		playerBody.rotation = 0
		
	else:
		
		cameraSelf.enabled = false
		cameraPlayer.enabled = true
		player.reparent(get_tree().root.get_node("root"))
		#player.global_transform = lastTransfrom
		playerBody.global_position = lastPos
		playerBody.rotation = lastRotation

func refreshModuleList():
	item_list.clear()
	for textureName:String in GlobalModules.textures:
		item_list.add_item(textureName, GlobalModules.textures[textureName], true)

func changeSelection(index:int):
	var moduleName:String = item_list.get_item_text(index)
	selectedBoxId = GlobalModules.ids[moduleName]
	
	
