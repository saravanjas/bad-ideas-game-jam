extends ProjectileClass


@onready var animated_sprite_2d: AnimatedSprite2D = $RigidBody2D/AnimatedSprite2D





@export var damage := 999
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotation = randi()
	animated_sprite_2d.play()
	alternateSizes()
func alternateSizes():
	var scaleTween = create_tween()
	scaleTween.tween_property( animated_sprite_2d , "scale" , Vector2(1.2,1.2) , 0.5)
	scaleTween.play()
	await scaleTween.finished
	var scaleDownTween = create_tween()
	scaleDownTween.tween_property( animated_sprite_2d , "scale" , Vector2(0.8,0.8) , 0.5)
	scaleDownTween.play()
	alternateSizes()


func enemyEntered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
