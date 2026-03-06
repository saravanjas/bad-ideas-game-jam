class_name ModuleClass
extends Node2D

var health := 1
var connectedModules:Array[Node2D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func getAdjacentModules() ->Array[ModuleClass]:
	var body:TileMapLayer = self.get_parent()
	var selfPos = body.local_to_map(position)
	var arr:Array[ModuleClass] = []
	for tile:Node2D in body.get_children():
		var pos = body.local_to_map(tile.position)
		if abs(pos.x - selfPos.x) + abs(pos.y - selfPos.y) == 1:
			arr.append(tile)	
	return arr
