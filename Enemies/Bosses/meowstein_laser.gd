extends Area2D
@onready var laser_sfx: AudioStreamPlayer2D = $LaserSFX

var speed = 1000
var direction = Vector2.RIGHT
func _ready() -> void:
	laser_sfx.pitch_scale = randf_range(1,1.2)
	laser_sfx.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += direction * speed * delta
