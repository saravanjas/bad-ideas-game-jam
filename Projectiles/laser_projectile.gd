extends Node2D

@onready var laser_sfx: AudioStreamPlayer2D = $LaserSFX


var velocity = 0
var lookVector:Vector2 = Vector2.RIGHT

@export var damage := 8
func _ready() -> void:
	laser_sfx.pitch_scale = randf_range(1.4,1.7)
	laser_sfx.play()
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
