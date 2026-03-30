extends Area2D

var target : Area2D
@export var texture : CompressedTexture2D 
@export var type : int
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var outline_texture: Sprite2D = $outlineItem
@onready var outline_color: Sprite2D = $outlineColor

@export var itemPickupSpeed : int = 850
func _ready() -> void:
	sprite_2d.texture = texture
	outline_texture.texture = texture
	outline_color.texture = texture
	outline_color.self_modulate = matchMaterialColor()
	rotation = randi()
func _process(delta: float) -> void:
	if target != null:
		global_position = global_position.move_toward(target.global_position , itemPickupSpeed * delta)


func collection_area_entered(area: Area2D) -> void:
	if area.has_method("set_target"):
		target = area.set_target()

func matchMaterialColor():
	match type:
		0:
			return Color.YELLOW
		1:
			return Color.DODGER_BLUE
		2:
			return Color.RED
