class_name ShipClass
extends Node2D

## PHYSICS CONSTANTS
const torqueSuspension := 10000
const spaceDrag := .98 # newtons laws = bad
const inertia = .98
##

## PHYSICS VARIABLES
var rootCenter:Marker2D
var characterBody:CharacterBody2D
var totalVelocity:Vector2 = Vector2(0,0)
var angularVelocity:float = 0
##

## GRID BUILDER CONSTANTS
const COLLECTION_ID = 0
const MAX_TILE_ID = 4
##

## GRID VARIABLES
var tilemap:TileMapLayer
var inBuildMode:bool = false
var selectedBoxId:int = 1
var moduleLookVector := Vector2.RIGHT.normalized()
var lastPlacedTile:ModuleClass
##

func _process(_delta: float) -> void:
	#resolveBuildMode()
	#if not inBuildMode:
	#	resolveAllModules()
	pass
	#

func getLookVector() -> Vector2:
	var currRotation = characterBody.rotation
	var lv = Vector2.from_angle(currRotation).normalized()
	return lv

func resolveAllModules():
	pass

func resolvePhysics():
	#slowly deaccelerate
	if totalVelocity != Vector2.ZERO:
		totalVelocity *= spaceDrag
	if totalVelocity.is_zero_approx() : 
		totalVelocity = Vector2.ZERO
		
	#slowly deaccelerate angular velocity
	if abs(angularVelocity) != 0:
		angularVelocity *= inertia
	if abs(angularVelocity) <= .001 : 
		angularVelocity = 0

func getAllModules() -> Array:
	var arr:Array[ModuleClass] = []
	for tile in tilemap.get_children():
		if tile is ModuleClass:
			arr.append(tile)
	return arr


#func resolveBuildMode():
	### entering build mode
	#if Input.is_action_pressed("Space"):
		#inBuildMode = true
	#if Input.is_action_just_released("Space"):
		#inBuildMode = false
#
	#if inBuildMode:
		#GlobalVariables.gamePaused = true
		#buildMode()
	#else:
		#GlobalVariables.gamePaused = false		
#
#func buildMode():
	#if Input.is_action_just_pressed("LeftClick"):
		#var mousePos = get_global_mouse_position()
		#mousePos = tilemap.to_local(mousePos)
		#mousePos = tilemap.local_to_map(mousePos)
		#tilemap.set_cell(mousePos, COLLECTION_ID , Vector2i(0,0), selectedBoxId) #position of tile locally, id of collection, vecotr2i(0,0), id of tile
		#tilemap.child_entered_tree.connect(getCellInstance.bind())
		#await tilemap.child_entered_tree
		#if lastPlacedTile.has_method("rotateModule"):
			#lastPlacedTile.rotateModule(moduleLookVector.angle())
			#
	##rotate module
	#if Input.is_action_just_pressed("r"):
		#var angle = moduleLookVector.angle()
		#angle += PI/2.0
		#moduleLookVector = Vector2.from_angle(angle).normalized()
#
	##select different modules
	#if Input.is_action_just_pressed("ScrollDown"):
		#selectedBoxId -= 1
		#selectedBoxId = calibrateBoxId(selectedBoxId)
	#elif Input.is_action_just_pressed("ScrollUp"):
		#selectedBoxId += 1
		#selectedBoxId = calibrateBoxId(selectedBoxId)

	#
#func calibrateBoxId(id:int):
	#var ret = id
	#if id <= 0:
		#ret = MAX_TILE_ID
	#elif id > MAX_TILE_ID:
		#ret = 1
	#return ret
#
#func getCellInstance(child:ModuleClass):
	#lastPlacedTile = child

#gets the look vector of the entire ship
