extends ProjectileModuleClass

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

func _ready():
	cooldownTime = 30

func activate():
	if onCooldown: return
	onCooldown = true
	heal()
	await get_tree().create_timer(cooldownTime).timeout
	onCooldown = false

func heal():
	for i in range(5):
		$AudioStreamPlayer.play()
		gpu_particles_2d.emitting = true
		animation_player.play("HealFlash")
		GlobalVariables.playerHealthCurrent += 5
		await get_tree().create_timer(3).timeout
