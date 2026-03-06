class_name ShipClass
extends Node2D

## PHYSICS CONSTANTS
const spaceDrag := .98 # newtons laws = bad
##

## PHYSICS VARIABLES
var totalVelocity:Vector2 = Vector2(0,0)
##

## GRID BUILDER CONSTANTS
const COLLECTION_ID = 0
const MAX_TILE_ID = 4
##

## GRID VARIABLES
var tilemap:TileMapLayer
var inBuildMode:bool = false
var selectedBoxId:int = 1
##

func _process(delta: float) -> void:
	resolveBuildMode()
	if not inBuildMode:
		resolveAllModules()
	
func resolveBuildMode():
	## entering build mode
	if Input.is_action_pressed("Space"):
		inBuildMode = true
	if Input.is_action_just_released("Space"):
		inBuildMode = false

	if inBuildMode:
		if Input.is_action_just_pressed("LeftClick"):
			#var mousePos = get_viewport().get_mouse_position()
			var mousePos = get_global_mouse_position()
			mousePos = tilemap.to_local(mousePos)
			tilemap.set_cell(tilemap.local_to_map(mousePos), COLLECTION_ID , Vector2i(0,0), selectedBoxId) #position of tile locally, id of collection, vecotr2i(0,0), id of tile
		
		if Input.is_action_just_pressed("ScrollDown"):
			selectedBoxId -= 1
			selectedBoxId = calibrateBoxId(selectedBoxId)
		elif Input.is_action_just_pressed("ScrollUp"):
			selectedBoxId += 1
			selectedBoxId = calibrateBoxId(selectedBoxId)

func resolveAllModules():
	pass

func resolvePhysics():
	#slowly deaccelerate
	if totalVelocity != Vector2.ZERO:
		totalVelocity *= spaceDrag
	if totalVelocity.is_zero_approx() : 
		totalVelocity = Vector2.ZERO
	
func calibrateBoxId(id:int):
	var ret = id
	if id <= 0:
		ret = MAX_TILE_ID
	elif id > MAX_TILE_ID:
		ret = 1
	return ret

func getAllModules():
	var arr:Array[ModuleClass] = []
	for tile in tilemap.get_children():
		if tile is ModuleClass:
			arr.append(tile)
	return arr
