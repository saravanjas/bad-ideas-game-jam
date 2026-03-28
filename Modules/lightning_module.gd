extends ProjectileModuleClass


@export var projectileVelocity:float = 10
@onready var box_open_animated_sprite_2d: AnimatedSprite2D = $BoxOpenAnimatedSprite2D
@onready var lightning_bolt: AnimatedSprite2D = $LightningBolt
@onready var lightning_hitbox: Area2D = $LightningHitbox
@onready var lightning_timer: Timer = $LightningTimer
@onready var lightning_sparks: GPUParticles2D = $LightningBolt/LightningSparks

var targets : Array = []
var attacking := false
var damage := 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func activate():
	
	if onCooldown: return
	
	lightning_sparks.emitting = true
	
	lightning_bolt.play("default")
	attacking = true
	lightning_timer.start(0.05)
	
	
	for body in lightning_hitbox.get_overlapping_bodies():
		if body.has_method("take_damage"):
			body.take_damage(damage)
	
	if attacking:
		playAnimation(box_open_animated_sprite_2d, true)
	
	
	if attacking:
		lightning_bolt.visible = true
		lightning_hitbox.monitoring = true
	else:
		lightning_bolt.visible = false
		lightning_hitbox.monitoring = false
	
	
	await get_tree().create_timer(cooldownTime).timeout
	onCooldown = false


func lightning_timer_timeout() -> void:
	attacking = false
	lightning_bolt.visible = false
	lightning_sparks.restart()
	lightning_sparks.emitting = false
