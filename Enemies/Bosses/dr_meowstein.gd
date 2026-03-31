extends CharacterBody2D


@export var speed: float = 400
@export var acceleration: float = 15

var time : float
var positionDifference : float
var laserProjectile : PackedScene = preload("res://Enemies/Bosses/meowstein_laser.tscn")
@onready var PlayerAccess = get_tree().get_first_node_in_group("PlayerAccess")
@onready var projectileAccess = get_tree().get_first_node_in_group("Projectiles")

@onready var ship: AnimatedSprite2D = $Animations/Ship
@onready var tail: AnimatedSprite2D = $Animations/Tail

@onready var laser_charge: AnimatedSprite2D = $Animations/LaserCharge
@onready var laser: AnimatedSprite2D = $Animations/Laser
@onready var laser_markers: Node2D = $CollisionShape2D/LaserMarkers
@onready var animations: Node2D = $Animations


@onready var debug: Label = $debug
@onready var action_timer: Timer = $ActionTimer

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

var laserAttackAmountMax = 2
var laserProjectileAmountMax := 24

@export var pawActive := false
func _ready() -> void:
	target = GlobalVariables.playerBody
	laserShootingPoints = laser_markers.get_children()

func _physics_process(delta: float) -> void:
	laser_markers.rotation = animations.rotation
	debug.text = movementState
	if !playerVisible:
		speed = 2500
		preferred_distance = 0
	else:
		speed = 400
		preferred_distance = 250
	match movementState:
		"Idle":
			if !actionTimerStarted:
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
			laserAttack()
		1:
			laserSpin()
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
	ship.play("LaserAttackTelegraph")
	await ship.animation_finished
	ship.play("Idle")
	laser_charge.visible = true
	laser_charge.play()
	tail.play("LaserAttack")
	await laser_charge.animation_finished
	laser_charge.visible = false
	laser.visible = true
	laser.play("LaserSpin")
	var rotationTween = create_tween()
	rotationTween.set_trans(Tween.TRANS_LINEAR)
	rotationTween.tween_property( animations , "rotation" , laserSpinAmount * (2 * PI) , laserSpinTime)
	rotationTween.play()
	await rotationTween.finished
	laser.play("default")
	await laser.animation_finished
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
		await get_tree().create_timer(6).timeout
		pawActive = false
		movementState = "Idle"
	else:
		await get_tree().create_timer(6).timeout
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
