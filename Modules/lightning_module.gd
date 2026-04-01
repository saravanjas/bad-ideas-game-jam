extends ProjectileModuleClass


@export var projectileVelocity:float = 10
@onready var box_open_animated_sprite_2d: AnimatedSprite2D = $BoxOpenAnimatedSprite2D
@onready var lightning_bolt: AnimatedSprite2D = $LightningBolt
@onready var lightning_hitbox: Area2D = $LightningHitbox
@onready var lightning_timer: Timer = $LightningTimer
@onready var lightning_sparks: GPUParticles2D = $LightningBolt/LightningSparks
@onready var lightning_sfx: AudioStreamPlayer2D = $LightningSFX

var targets : Array = []
var attacking := false
var damage := 3
var lightningSFXPlaying := false

func _ready() -> void:
	cooldownTime = 0.07


func activate():
	if onCooldown: return
	onCooldown = true
	if !lightningSFXPlaying:
		lightningSFXPlaying = true
		lightning_sfx.play()
	
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
	lightningSFXPlaying = false
	lightning_sfx.stop()

func lightning_sfx_finished() -> void:
	lightning_sfx.play()
