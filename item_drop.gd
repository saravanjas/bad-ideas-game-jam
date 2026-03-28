extends Area2D

var target : Area2D
@export var texture : CompressedTexture2D 
@export var type : int
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	sprite_2d.texture = texture
	rotation = randi()
func _process(delta: float) -> void:
	if target != null:
		global_position = global_position.move_toward(target.global_position , 500 * delta)


func collection_area_entered(area: Area2D) -> void:
	if area.has_method("set_target"):
		target = area.set_target()
