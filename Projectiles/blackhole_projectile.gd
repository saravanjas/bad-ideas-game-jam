extends Node2D


@onready var animated_sprite_2d: AnimatedSprite2D = $RigidBody2D/AnimatedSprite2D
@onready var rigid_body_2d: Area2D = $RigidBody2D

var velocity = 0
var lookVector:Vector2 = Vector2.RIGHT

@export var damage := 999


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



func enemyEnteredHole(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)

func setVelocity(vel:float):
	velocity = vel

func setLookVector(lv:Vector2):
	lv = lv.normalized()
	lookVector = lv

func _physics_process(delta: float) -> void:
	global_position += lookVector * velocity * delta
