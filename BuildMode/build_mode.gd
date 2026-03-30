extends Control


## GRID BUILDER CONSTANTS
const COLLECTION_ID = 0
const MAX_TILE_ID = 5
const MAX_PLACE_DISTANCE = 4
##

## GRID VARIABLES
@onready var tilemap:TileMapLayer = GlobalVariables.playerTilemap
var inBuildMode:bool = false
var selectedBoxId:int = 1
var moduleLookVector := Vector2.RIGHT.normalized()
var lastPlacedTile:ModuleClass
var playerRotationInformation : float
var holdingTile = false
#@onready var playerAccess : Node2D = $"../Player/PlayerShip".get_child(0)
##

## SHOP VARIABLES 
var shop:Array[ShopItem] = []
@onready var blankShopItem = preload("res://BuildMode/ShopItem.tscn")
##

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var animated_sprite_2d: AnimatedSprite2D = $CanvasLayer/AnimatedSprite2D
@onready var texture_rect_bg: TextureRect = $CanvasLayer/Background
@onready var texture_rect_bp: TextureRect = $CanvasLayer/Background2
@onready var h_box_container: HBoxContainer = $ItemBoxes/HBoxContainer
@onready var buildmodeSFX: AudioStreamPlayer = $buildmodeSFX
@onready var box_placement_sfx: AudioStreamPlayer = $boxPlacementSFX

func _ready() -> void:
	fillShop()

var cd := false
func _process(delta: float) -> void:
	resolveBuildMode()
	animated_sprite_2d.visible = GlobalVariables.inBuildMode

func resolveBuildMode():
	if cd: return 
	if Input.is_action_just_pressed("Space"):
		
		if not GlobalVariables.inBuildMode:
			buildmodeSFX.play()
			playerRotationInformation = GlobalVariables.playerBody.rotation
			cd = true
			GlobalVariables.inBuildMode  = true
			tweenCameraBuildmode()
			canvas_layer.visible = true
			animated_sprite_2d.play()
			await animated_sprite_2d.animation_finished 
			#for child in get_children():
				#if child is CanvasLayer:
					#child.visible = true
			var backgroundAppearTween = _tween1()
			await backgroundAppearTween.finished
		
			var playerRotationTween = _tween2()
			await playerRotationTween.finished
			
			## add shop tweens and anims
			fillShop()
			
			cd = false
			GlobalVariables.buildModeSetupFinished = true
		else:
			var resetPlayerPosAndBackground = _tween3()
			GlobalVariables.inBuildMode  = false
			resetCameraTween()
			GlobalVariables.buildModeSetupFinished = false
			#for child in get_children():
				#if child is CanvasLayer:
					#child.visible = false
	
	if GlobalVariables.inBuildMode:
		GlobalVariables.gamePaused = true
		buildMode()
	else:
		GlobalVariables.gamePaused = false


func buildMode():
	tilemap = GlobalVariables.playerTilemap
	#place tiles
	if Input.is_action_just_pressed("LeftClick"):
		if holdingTile:
			if await tryPlaceTile():
				holdingTile = false
				
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

func itemBought(button:ShopItem, moduleName:String):
	print("bought: ", moduleName)
	selectedBoxId = BuildmodeVariables.moduleIds.get(moduleName)
	holdingTile = true
	button.queue_free()
	shop.erase(button)
	fillShop()

func tryPlaceTile() -> bool:
	var mousePos = get_global_mouse_position()
	mousePos = tilemap.to_local(mousePos)
	mousePos = tilemap.local_to_map(mousePos)
	if not confirmPlaceability(mousePos, ""):
		return false
	
	tilemap.set_cell(mousePos, COLLECTION_ID , Vector2i(0,0), selectedBoxId) #position of tile locally, id of collection, vecotr2i(0,0), id of tile
	tilemap.child_entered_tree.connect(getCellInstance.bind())
	await tilemap.child_entered_tree
	if lastPlacedTile.has_method("rotateModule"):
		lastPlacedTile.rotateModule(moduleLookVector.angle())
	box_placement_sfx.play()
	return true
	

func confirmPlaceability(pos:Vector2i, tileName:String) -> bool:
	var modules = GlobalVariables.player.getAllModules()
	#check if out of bounds
	if (abs(pos.x) + abs(pos.y)) > MAX_PLACE_DISTANCE:
		return false
	
	#check if the spot is empty
	if tilemap.get_cell_source_id(pos) != -1:
		return false
	
	#check adjacent
	var directions = [Vector2i(0,1), Vector2i(0,-1), Vector2i(1,0), Vector2i(-1,0)]
	var hasAdjacentModule = false

	for dir in directions:
		var neighbor = pos + dir
		if tilemap.get_cell_source_id(neighbor) != -1:
			hasAdjacentModule = true
			break

	if !hasAdjacentModule:
		return false
	return true
	
	
func fillShop():
	while shop.size() < 3:
		var newItem:ShopItem = blankShopItem.instantiate()
		var itemKey = rollItem()
		fillBlankItem(itemKey, newItem)
		h_box_container.add_child(newItem)
		newItem.itemBoughtSignal.connect(self.itemBought.bind())
		shop.append(newItem)

func rollItem() -> String:
	var max = BuildmodeVariables.moduleInfo.size()
	var itemKey = BuildmodeVariables.moduleInfo.keys()[randi_range(0,max-1)]
	return itemKey
	
func fillBlankItem(name:String, newItem:ShopItem): 
	## add cost
	var i = 0
	for key in newItem.cost.keys():
		print(key)
		newItem.cost[key] = BuildmodeVariables.moduleInfo[name]["Cost"][i]
		i += 1
	
	## add Module Name / Key
	newItem.moduleName = name
	## add Description
	await get_tree().process_frame
	newItem.description.text = BuildmodeVariables.moduleInfo[name]["Text"]
	newItem.itemTexture.texture = load(BuildmodeVariables.moduleInfo[name]["Texture"])
	newItem.price_label_1.text = str(newItem.cost["Cardboard"])
	newItem.price_label_2.text = str(newItem.cost["Tape"])
	newItem.price_label_3.text = str(newItem.cost["Screws"])
func calibrateBoxId(id:int):
	var ret = id
	if id <= 0:
		ret = MAX_TILE_ID
	elif id > MAX_TILE_ID:
		ret = 1
	return ret

func getCellInstance(child:ModuleClass):
	lastPlacedTile = child

func _tween1() -> Tween:
	var backgroundAppearTween = create_tween()
	backgroundAppearTween.set_parallel(true)
	backgroundAppearTween.tween_property(texture_rect_bg , "modulate:a" , 1.0 , 0.67)
	backgroundAppearTween.tween_property(texture_rect_bp , "modulate:a" , 1.0 , 0.67)
	backgroundAppearTween.tween_property(h_box_container , "modulate:a" , 1.0 , 0.67)
	backgroundAppearTween.tween_property(h_box_container , "modulate:a" , 1.0 , 0.67)
	backgroundAppearTween.play()
	return backgroundAppearTween

func _tween2() -> Tween:
	var playerRotationTween = create_tween()
	playerRotationTween.set_trans(Tween.TRANS_EXPO)
	playerRotationTween.tween_property( GlobalVariables.playerBody , "rotation" , 0 , 0.3 ) #playerAccess
	playerRotationTween.play()
	return playerRotationTween
	
func _tween3() -> Tween:
	var resetPlayerPosAndBackground = create_tween()
	resetPlayerPosAndBackground.set_parallel(true)
	resetPlayerPosAndBackground.tween_property(texture_rect_bg , "modulate:a" , 0.0 , 0.25)
	resetPlayerPosAndBackground.tween_property(texture_rect_bp , "modulate:a" , 0.0 , 0.25)
	resetPlayerPosAndBackground.tween_property(h_box_container , "modulate:a" , 0.0 , 0.67)
	resetPlayerPosAndBackground.tween_property(h_box_container , "modulate:a" , 0.0 , 0.67)
	resetPlayerPosAndBackground.set_trans(Tween.TRANS_EXPO)
	resetPlayerPosAndBackground.tween_property( GlobalVariables.playerBody , "rotation" , playerRotationInformation , 0.3 )
	resetPlayerPosAndBackground.play()
	return resetPlayerPosAndBackground

func tweenCameraBuildmode():
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(GlobalVariables.playerCamera , "zoom" , Vector2(1.5,1.5) , 0.5)
	tween.tween_property(GlobalVariables.playerCamera , "position:y" , -50 , 0.5)
	tween.play()

func resetCameraTween():
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(GlobalVariables.playerCamera , "zoom" , Vector2(1.0,1.0) , 0.5)
	tween.tween_property(GlobalVariables.playerCamera , "position:y" , 0 , 0.5)
	tween.play()

func _tween1_hbox() -> Tween:
	var backgroundAppearTween = create_tween()
	backgroundAppearTween.set_parallel(true)
	backgroundAppearTween.tween_property(h_box_container , "modulate:a" , 1.0 , 0.67)
	backgroundAppearTween.tween_property(h_box_container , "modulate:a" , 1.0 , 0.67)
	backgroundAppearTween.play()
	return backgroundAppearTween
