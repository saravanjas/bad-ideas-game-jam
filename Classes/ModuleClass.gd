class_name ModuleClass
extends Node2D


@export var health := 1
@export var recoil := 0

var connectedModules:Array[Node2D] = []
var playerCharacterBody:CharacterBody2D
var sprite:Sprite2D
var player:ShipClass
#var lookVector:Vector2

func _ready() -> void:
	playerCharacterBody = self.get_parent().get_parent()
	player = playerCharacterBody.get_parent()
	sprite = self.get_node("Sprite2D")
	#lookVector = Vector2.from_angle(deg_to_rad(rotation)+(PI/2.0)).normalized()
	_retoggleSpriteVisibility()
	
	rotateModule()
	
func _process(delta: float) -> void:
	#print((global_position - player.rootCenter.global_position).length())
	pass
	#lookVector = Vector2.from_angle(deg_to_rad(rotation)+(PI/2.0)).normalized()

func _retoggleSpriteVisibility():
	sprite.visible = false
	await get_tree().process_frame
	sprite.visible = true
	
func lookVector():
	var playerAngle = GlobalVariables.player.getLookVector().angle() + (PI/2.0)
	var moduleAngle = rotation#+(PI/2.0)
	var lv = Vector2.from_angle(playerAngle+moduleAngle)
	#print("plr: ", playerAngle/PI)
	#print("module: ", moduleAngle/PI)
	#print("returend a lv", lv)
	return lv

func getAdjacentModules() ->Array[ModuleClass]:
	var body:TileMapLayer = self.get_parent()
	var selfPos = body.local_to_map(position)
	var arr:Array[ModuleClass] = []
	for tile:Node2D in body.get_children():
		var pos = body.local_to_map(tile.position)
		if abs(pos.x - selfPos.x) + abs(pos.y - selfPos.y) == 1:
			arr.append(tile)	
	return arr

func applyForceToSelf(vector:Vector2, flipY:bool = true, flipX:bool = true):
	if flipY:
		vector.y *= -1
	if flipX:
		vector.x *= -1
	player.totalVelocity += vector

func applyTorqueToSelf(vector:Vector2,flipY:bool = true, flipX:bool = true):
	if flipY:
		vector.y *= -1
	if flipX:
		vector.x *= -1
	var torque = vector.cross(global_position - player.rootCenter.global_position)
	player.angularVelocity += (-torque/player.torqueSuspension)

##Build Mode
func rotateModule():
	while not player.moduleRotations.has(GlobalVariables.playerTilemap.local_to_map(position)):
		await get_tree().process_frame
	var angle = player.moduleRotations[GlobalVariables.playerTilemap.local_to_map(position)]
	angle = rad_to_deg(angle)
	self.rotation_degrees = angle
	
