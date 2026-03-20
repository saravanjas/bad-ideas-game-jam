extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var time : float
var positionDifference : float
@onready var PlayerAccess = get_tree().get_first_node_in_group("PlayerAccess")
@onready var laser: AnimatedSprite2D = $Laser
@onready var laser_charge: AnimatedSprite2D = $LaserCharge
@onready var action_timer: Timer = $ActionTimer
@onready var ship: AnimatedSprite2D = $Ship
@onready var tail: AnimatedSprite2D = $Tail

func _physics_process(delta: float) -> void:
	time += delta
	positionDifference = GlobalVariables.playerBody.global_position.x / global_position.x
	global_position = GlobalVariables.playerBody.global_position + Vector2(positionDifference * sin(15 * time),-250)
	
func LaserAttack():
	$Ship.play("LaserAttackTelegraph")
	$Tail.play("LaserAttack")


func action_timer_timeout() -> void:
	select_action()

func select_action():
	LaserAttack()


func _on_ship_animation_finished() -> void:
	laser_charge.visible = true
	laser_charge.play()


func laser_animation_finished() -> void:
	laser.visible = false
	tail.play("Idle")
	ship.play("Idle")
	startActionTimer()
func laser_charge_animation_finished() -> void:
	laser.visible = true
	laser.play("default")
	laser_charge.visible = false

func startActionTimer():
	action_timer.start()
