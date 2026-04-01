extends ProjectileClass

@onready var animated_sprite_2d: AnimatedSprite2D = $RigidBody2D/AnimatedSprite2D
@onready var explosion: GPUParticles2D = $RigidBody2D/Explosion




@export var damage := 35
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite_2d.play()

func enemyCollision(body: Node) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
	explosion.reparent(GlobalVariables.projectilesNode , true)
	explosion.emitting = true
	animated_sprite_2d.visible = false
	rigid_body_2d.call_deferred("set_contact_monitor" , false )
	queue_free()
func exitViewport() -> void:
	print("cao!")
	queue_free()
