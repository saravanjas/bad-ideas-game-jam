class_name ProjectileClass
extends Node2D

@onready var rigid_body_2d: RigidBody2D = $RigidBody2D
@onready var collision_shape_2d: CollisionShape2D = $RigidBody2D/CollisionShape2D


var velocity = 0
var lookVector:Vector2 = Vector2.RIGHT


func _physics_process(delta: float) -> void:
	rigid_body_2d.move_and_collide(velocity*lookVector)
	
func setVelocity(vel:float):
	velocity = vel

func setLookVector(lv:Vector2):
	lv = lv.normalized()
	lookVector = lv
