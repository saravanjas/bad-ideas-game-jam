extends Node2D


var velocity = 0
var lookVector:Vector2 = Vector2.RIGHT

@export var damage := 8


func setVelocity(vel:float):
	velocity = vel

func setLookVector(lv:Vector2):
	lv = lv.normalized()
	lookVector = lv

func _physics_process(delta: float) -> void:
	global_position += lookVector * velocity * delta


func enemyDetected(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
