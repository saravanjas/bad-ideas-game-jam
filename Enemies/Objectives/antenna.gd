extends CharacterBody2D

var health = 300
var maxHealth = 300
@onready var explosion: GPUParticles2D = $Explosion
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var explosion_aftermath: Node2D = $"../ExplosionAftermath"
@onready var smoke: GPUParticles2D = $"../ExplosionAftermath/Sprite2D2/Smoke"
@onready var playerCameraAccess = get_tree().get_first_node_in_group("PlayerCamera")
@onready var gameManager = get_tree().get_first_node_in_group("gameManager")
@onready var radio_noise: AudioStreamPlayer2D = $"../RadioNoise"
@onready var antenna_damaged_sfx: AudioStreamPlayer2D = $"../AntennaDamagedSFX"
@onready var explosion_small: AudioStreamPlayer2D = $"../ExplosionSmall"
@onready var explosion_big: AudioStreamPlayer2D = $"../ExplosionBig"
@onready var alarm: AudioStreamPlayer2D = $"../Alarm"
@onready var lootParent := get_tree().get_first_node_in_group("Loot")

var destroyed := false
var canStopShaking := false
var alarmPlaying := false

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func take_damage(damage):
	GlobalScripts.display_number(damage , global_position + randomizePosition())
	antenna_damaged_sfx.play()
	print("Raketa OUCH!")
	health -= damage
	if health <= 0 and !destroyed:
		destroyed = true
		collision_layer = 64
		explode()
		shake()
		radio_noise.stop()
	if health <= (maxHealth * 0.75) and !alarmPlaying:
		alarmPlaying = true
		alarm.play()
func explode():
	var explosionCount = randi_range(5,7)
	for i in range(explosionCount):
		explosion_small.play()
		var explosionInstance = explosion.duplicate()
		explosionInstance.emitting = true
		add_child(explosionInstance)
		await get_tree().create_timer(randf_range(0.1,0.4)).timeout
		explosion.position = Vector2(0,40) + global_position + randomizePosition()
	await get_tree().create_timer(1.5).timeout
	BIG_explode()
func BIG_explode():
	alarm.stop()
	canStopShaking = true
	destroyed = true
	explosion_big.play()
	animated_sprite_2d.visible = false
	explosion_aftermath.modulate = Color(0.28,0.28,0.28,1)
	for child in explosion_aftermath.get_children():
		child.visible = true
		child.rotation = randi_range(-25,25)
	animated_sprite_2d.position = Vector2.ZERO
	for child in explosion.get_children():
		child.queue_free()
	explosion.position = Vector2(0,40)
	explosion.emitting = true
	explosion.amount = 2024
	explosion.lifetime = 8
	explosion.scale = explosion.scale * 5
	smoke.emitting = true
	playerCameraAccess.shake(80)
	await get_tree().create_timer(1).timeout
	playerCameraAccess.stopShaking()
	GlobalVariables.nextObjective = null
	GlobalVariables.anntenaeDestroyed = GlobalVariables.anntenaeDestroyed + 1
	gameManager.spawn_objective( GlobalVariables.anntenaeDestroyed)
	for i in range(randi_range(5,10)):
		GlobalScripts.spawnLoot(global_position + randomizePosition() , "Objective" , lootParent)
	
func shake():
	if !canStopShaking:
		var tween = create_tween()
		tween.tween_property(animated_sprite_2d , "position:x" , randi_range(-10,10) , randi_range(0.1 , 0.2))
		tween.play()
		await tween.finished
		shake()


func visible_on_screen() -> void:
	if !destroyed:
		GlobalVariables.objectiveOnScreen = true


func screen_exited() -> void:
		GlobalVariables.objectiveOnScreen = false


func radio_over() -> void:
	if !destroyed:
		radio_noise.play()

func randomizePosition():
	return Vector2(randi_range(-40,40),randi_range(-40,40))
