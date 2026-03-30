extends Node2D


@onready var animated_sprite_2d: AnimatedSprite2D = $RigidBody2D/AnimatedSprite2D
@onready var rigid_body_2d: Area2D = $RigidBody2D
@onready var playerCameraAccess = get_tree().get_first_node_in_group("PlayerCamera")
var velocity = 0
var lookVector:Vector2 = Vector2.RIGHT

@export var damage := 999

@onready var black_hole_sfx: AudioStreamPlayer2D = $BlackHoleSFX
@onready var despawn_timer: Timer = $DespawnTimer

func _ready() -> void:
	shake()
	black_hole_sfx.pitch_scale = randf_range(0.8,1.2)
	var sizeDown = create_tween()
	sizeDown.set_trans(Tween.TRANS_BOUNCE)
	sizeDown.tween_property( self , "scale" , Vector2(3,3) , 0.1)
	sizeDown.tween_property( self , "scale" , Vector2(1.2,1.2) , 0.1)
	sizeDown.play()
	rotation = randi()
	animated_sprite_2d.play()
	await sizeDown.finished
	alternateSizes()
func alternateSizes():
	var scaleTween = create_tween()
	scaleTween.tween_property( animated_sprite_2d , "scale" , Vector2(1.2,1.2) , 0.25)
	scaleTween.play()
	await scaleTween.finished
	var scaleDownTween = create_tween()
	scaleDownTween.tween_property( animated_sprite_2d , "scale" , Vector2(0.6,0.6) , 0.25)
	scaleDownTween.play()
	alternateSizes()



func enemyEnteredHole(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)

func setVelocity(vel:float):
	velocity = vel

func setLookVector(lv:Vector2):
	lv = lv.normalized()
	lookVector = lv

func _physics_process(delta: float) -> void:
	global_position += lookVector * velocity * delta

func shake():
	playerCameraAccess.shake(50)
	await get_tree().create_timer(0.5).timeout
	playerCameraAccess.stopShaking()


func screenExtied() -> void:
	despawn_timer.start()


func despawn_timer_timeout() -> void:
	queue_free()


func screenEntered() -> void:
	despawn_timer.stop()
