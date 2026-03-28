extends ProjectileModuleClass


@export var projectileVelocity:float = 1200
@onready var box_open_animated_sprite_2d: AnimatedSprite2D = $BoxOpenAnimatedSprite2D
@onready var projectile : PackedScene = preload("res://Projectiles/LaserProjectile.tscn")

var timeBetweenLasers : float = 0.1
func _ready() -> void:
	pass # Replace with function body.


func activate():
	if onCooldown: return
	onCooldown = true
	
	playAnimation(box_open_animated_sprite_2d, true)
	for i in range(5):
		spawnLaser()
		await get_tree().create_timer(timeBetweenLasers).timeout
	await get_tree().create_timer(cooldownTime).timeout
	onCooldown = false

func spawnLaser():
	var proj : = projectile.instantiate()
	proj.global_position = self.global_position
	proj.rotation = lookVector().angle() 
	GlobalVariables.projectilesNode.add_child(proj)
	proj.setVelocity(projectileVelocity)
	proj.setLookVector(self.lookVector())
