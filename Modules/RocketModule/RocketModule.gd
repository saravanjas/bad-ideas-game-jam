extends ProjectileModuleClass


@export var projectileVelocity:float = 10
@onready var box_open_animated_sprite_2d: AnimatedSprite2D = $BoxOpenAnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cooldownTime = 0.03


func activate():
	if onCooldown: return
	onCooldown = true
	var proj:ProjectileClass = spawnProjectile()
	playAnimation(box_open_animated_sprite_2d, true)
	proj.setVelocity(projectileVelocity)
	proj.setLookVector(self.lookVector())
	await get_tree().create_timer(cooldownTime).timeout
	onCooldown = false
