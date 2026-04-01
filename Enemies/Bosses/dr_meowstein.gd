extends CharacterBody2D


@export var speed: float = 400
@export var acceleration: float = 15
var alive := true
var time : float
var positionDifference : float
var laserProjectile : PackedScene = preload("res://Enemies/Bosses/meowstein_laser.tscn")

@onready var PlayerAccess = get_tree().get_first_node_in_group("PlayerAccess")
@onready var projectileAccess = get_tree().get_first_node_in_group("Projectiles")
@onready var playerCameraAccess = get_tree().get_first_node_in_group("PlayerCamera")

@onready var ship: AnimatedSprite2D = $Animations/Ship
@onready var tail: AnimatedSprite2D = $Animations/Tail

@onready var laser_charge: AnimatedSprite2D = $Animations/LaserCharge
@onready var laser: AnimatedSprite2D = $Animations/Laser
@onready var laser_markers: Node2D = $CollisionShape2D/LaserMarkers
@onready var animations: Node2D = $Animations

@onready var laser_hurtbox: Area2D = $Animations/Laser/LaserHurtbox
@onready var action_timer: Timer = $ActionTimer
@onready var paw_timer: Timer = $pawTimer


var laserShootingPoints : Array

var previousActionChoice : int
@export var actionState : String
@export var movementState : String = "Idle"
var actionTimerStarted := false

var playerVisible := false

var target
@export var preferred_distance: float = 250.0
@export var tolerance: float = 40.0
@export var distance_noise: float = 50 # how much randomness
var orbit_direction: int = 1


var laserSpinAmount := 2
var laserSpinTime := 8
@onready var laser_windup: AudioStreamPlayer2D = $Animations/Laser/LaserWindup
@onready var laser_active: AudioStreamPlayer2D = $Animations/Laser/LaserActive
@onready var laser_light: PointLight2D = $Animations/LaserLight


var laserAttackAmountMax = 2
var laserProjectileAmountMax := 24


var pawFollowLenght := 10
@export var pawActive := false
@onready var cat_paw_1: CharacterBody2D = $CatPaw1
@onready var cat_paw_2: CharacterBody2D = $CatPaw2
@onready var marker_1: Marker2D = $PawMarkers/Marker1
@onready var marker_2: Marker2D = $PawMarkers/Marker2

@onready var damageSFX: AudioStreamPlayer2D = $DamagedSFX

@onready var explosion_small: AudioStreamPlayer2D = $ExplosionSmall
@onready var explosion: GPUParticles2D = $Explosion

var phase := 1
var previousPhase := 0
func _ready() -> void:
	target = GlobalVariables.playerBody
	laserShootingPoints = laser_markers.get_children()

func _physics_process(delta: float) -> void:
	if GlobalVariables.drMeowsteinCurrentHp <= 1000:
		laserAttackAmountMax = 3
		laserSpinAmount = 3
		laserSpinTime = 7.5
	if !alive:
		return
	if GlobalVariables.inBuildMode:
		process_mode = Node.PROCESS_MODE_DISABLED
	else:
		process_mode = Node.PROCESS_MODE_ALWAYS
	if alive:
		if GlobalVariables.drMeowsteinCurrentHp <= 0:
			GlobalScripts.EndGame()
			movementState = "Following"
			alive = false
			die()
			return
		laser_markers.rotation = animations.rotation
		if !playerVisible:
			speed = 2500
			preferred_distance = 0
		else:
			speed = 400
			preferred_distance = 250
		match movementState:
			"Idle":
				if !actionTimerStarted and playerVisible:
					startActionTimer(1)
			"Following":
				var to_player = target.global_position - global_position
				var distance = to_player.length()
				var direction = to_player.normalized()
				
				var target_distance = preferred_distance + randf_range(-20.0, 20.0)
				var move_dir = Vector2.ZERO
				if distance > target_distance + tolerance:
					move_dir = direction
				elif distance < target_distance - tolerance:
					move_dir = -direction
				else:
					move_dir = Vector2(-direction.y, direction.x) * orbit_direction
				velocity = velocity.lerp(move_dir * speed, acceleration * delta)
				move_and_slide()

func startActionTimer(time):
	actionTimerStarted = true
	action_timer.start(time)


func action_timer_timeout() -> void:
	movementState = "Following"
	actionTimerStarted = false
	var actionChoice = determineAction(previousActionChoice)
	match actionChoice:
		0:
			laserSpin()
		1:
			laserAttack()
		2:
			pawAttack()
func determineAction(previousAction):
	var choice := randi_range(0,2)
	if choice == previousAction:
		return determineAction(previousAction)
	else:
		previousActionChoice = choice
		print(choice)
		return choice

func laserAttack():
	preferred_distance = 400
	for i in range(laserAttackAmountMax):
		shootLasers()
		await get_tree().create_timer(1.5).timeout
	await get_tree().create_timer(2).timeout
	movementState = "Idle"
	preferred_distance = 250
func laserSpin():
	speed = 200
	preferred_distance = 250
	laser_windup.play()
	ship.play("LaserAttackTelegraph")
	var laserLight = create_tween()
	laserLight.set_parallel(true)
	laserLight.tween_property(laser_light , "energy" , 16 , 4)
	laserLight.tween_property(laser_light , "texture_scale" , 1.5 , 4)
	laserLight.play()
	
	
	await ship.animation_finished
	ship.play("Idle")
	laser_charge.visible = true
	laser_charge.play()
	tail.play("LaserAttack")
	
	
	await laser_charge.animation_finished#
	playerCameraAccess.shake(125)
	laser_active.play()
	laser_hurtbox.monitoring = true
	laser_charge.visible = false
	laser.visible = true
	laser.play("LaserSpin")
	var rotationTween = create_tween()
	rotationTween.set_trans(Tween.TRANS_LINEAR)
	rotationTween.tween_property( animations , "rotation" , laserSpinAmount * (2 * PI) , laserSpinTime)
	rotationTween.play()
	
	
	await rotationTween.finished
	playerCameraAccess.stopShaking()
	laser.play("default")
	await laser.animation_finished
	
	
	var laserLightReset = create_tween()
	laserLightReset.set_parallel(true)
	laserLightReset.tween_property(laser_light , "energy" , 0 , 0.5)
	laserLightReset.tween_property(laser_light , "texture_scale" , 0.4 , 0.5)
	laserLightReset.play()
	laser_active.stop()
	laser_hurtbox.monitoring = false
	laser.visible = false
	tail.play("Idle")
	animations.rotation = 0
	
	
	await get_tree().create_timer(3).timeout
	movementState = "Idle"
	actionState = "Idle"
	preferred_distance = 250
	speed = 400

func pawAttack():
	if !pawActive:
		actionState = "PawAttack"
		pawActive = true
		pawTimer()
		movementState = "Idle"
	else:
		await get_tree().create_timer(2).timeout
		movementState = "Idle"

func shootLasers():
	for i in range(randi_range(10,laserProjectileAmountMax)):
		var laserInstance1 = laserProjectile.instantiate()
		var laserInstance2 = laserProjectile.instantiate()
		laserInstance1.global_position = laserShootingPoints[0].position
		laserInstance1.direction = (target.global_position - self.global_position).normalized()
		laserInstance1.rotation = laserInstance1.direction.angle()
		laserInstance2.global_position = laserShootingPoints[1].position
		laserInstance2.direction = (target.global_position - self.global_position).normalized()
		laserInstance2.rotation = laserInstance1.direction.angle()
		self.add_child(laserInstance1)
		self.add_child(laserInstance2)
		await get_tree().create_timer(randf_range(0.1,0.2)).timeout


func playerDetected(body: Node2D) -> void:
	playerVisible = true


func playerUndetected(body: Node2D) -> void:
	playerVisible = false
func pawTimer():
	paw_timer.start(pawFollowLenght)


func paw_timer_timeout() -> void:
	pawActive = false
	resetPaws(cat_paw_1 , 1)
	resetPaws(cat_paw_2 , 2)

func resetPaws(paw , pawNum):
	if pawNum == 1:
		var tween = create_tween()
		tween.set_parallel(true)
		tween.tween_property( paw , "global_position" , marker_1.global_position  , 0.5)
		tween.tween_property( paw , "rotation" , 0 , 0.5)
		tween.play()
	else:
		var tween = create_tween()
		tween.set_parallel(true)
		tween.tween_property( paw , "global_position" , marker_2.global_position  , 0.5)
		tween.tween_property( paw , "rotation" , 0 , 0.5)
		tween.play()
		
func take_damage(damage):
	damageSFX.pitch_scale = randf_range(0.8,1.2)
	damageSFX.play()
	GlobalScripts.display_number(damage , global_position)
	GlobalVariables.drMeowsteinCurrentHp -= damage

func die():
	for child in get_children():
		if child is AnimatedSprite2D:
			child.stop()
		if child is Area2D:
			child.monitoring = false
		if child is AudioStreamPlayer2D:
			child.stop()
	shake()
	explode()
func shake():
	var tween = create_tween()
	tween.tween_property(animations , "position:x" , randi_range(-10,10) , randi_range(0.1 , 0.2))
	tween.play()
	await tween.finished
	shake()
	
func explode():
	var explosionCount = randi_range(12,15)
	for i in range(explosionCount):
		explosion_small.play()
		var explosionInstance = explosion.duplicate()
		explosionInstance.emitting = true
		add_child(explosionInstance)
		await get_tree().create_timer(randf_range(0.1,0.3)).timeout
		explosion.position = Vector2(0,40) + global_position + randomizePosition()
	await get_tree().create_timer(1.5).timeout
	bigExplosion()

func randomizePosition():
	return Vector2(randi_range(-40,40),randi_range(-40,40))

func bigExplosion():
	explosion.position = Vector2(0,40)
	explosion.emitting = true
	explosion.amount = 2024
	explosion.lifetime = 8
	explosion.scale = explosion.scale * 5
	playerCameraAccess.shake(80)
