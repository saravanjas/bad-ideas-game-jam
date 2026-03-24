extends ProjectileClass

@onready var animated_sprite_2d: AnimatedSprite2D = $RigidBody2D/AnimatedSprite2D


func _ready() -> void:
	animated_sprite_2d.play()
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().get_parent().is_class("TileMapLayer") : return
	print(area.get_parent().get_parent())
	print(area.get_parent().is_class("ModuleClass"))
