extends ProjectileModuleClass


@export var projectileVelocity:float = 450
@onready var box_open_animated_sprite_2d: AnimatedSprite2D = $BoxOpenAnimatedSprite2D
@onready var projectile : PackedScene = preload("res://Projectiles/BlackholeProjectile.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cooldownTime = 30


func activate():
	if onCooldown: return
	onCooldown = true
	var proj : = projectile.instantiate()
	playAnimation(box_open_animated_sprite_2d, true)
	proj.global_position = self.global_position
	proj.rotation = lookVector().angle()
	GlobalVariables.projectilesNode.add_child(proj)
	proj.setVelocity(projectileVelocity)
	proj.setLookVector(self.lookVector())
	await get_tree().create_timer(cooldownTime).timeout
	onCooldown = false
