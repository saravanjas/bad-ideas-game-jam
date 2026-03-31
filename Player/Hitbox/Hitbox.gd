extends Area2D

var sprite : Sprite2D
@export var damageSound : PackedScene
var damageSoundInstance
func _ready() -> void:
	damageSoundInstance = damageSound.instantiate()
	add_child(damageSoundInstance)
	var parent = get_parent()
	for child in parent.get_children():
		if child is Sprite2D:
			sprite = child
			break
func body_entered(body: Node2D) -> void:
	if !GlobalVariables.playerInvincible:
		damage_tween()
		GlobalVariables.playerInvincible = true
		GlobalVariables.playerCanBeDamagedTimer.start()
		GlobalVariables.playerHealthCurrent -= 1
		GlobalVariables.playerBody.sayOuch()

func damage_tween():
	damageSoundInstance.pitch_scale = randf_range(0.8,1.2)
	damageSoundInstance.play()
	var damage_tween = create_tween()
	damage_tween.set_parallel(true)
	damage_tween.set_trans(Tween.TRANS_SPRING)
	damage_tween.tween_property(sprite , "scale" , Vector2(2,2) , 0.2)
	damage_tween.tween_property(sprite , "modulate" , Color(1,0,0) , 0.1)
	damage_tween.play()
	await damage_tween.finished
	var reset = create_tween()
	reset.set_parallel(true)
	reset.tween_property(sprite , "scale" , Vector2(1,1) , 0.3)
	reset.tween_property(sprite , "modulate" , Color(1,1,1) , 0.1)
	reset.play()


func hitByBoss(area: Area2D) -> void:
	if !GlobalVariables.playerInvincible:
		damage_tween()
		GlobalVariables.playerInvincible = true
		GlobalVariables.playerCanBeDamagedTimer.start(0.02)
		GlobalVariables.playerHealthCurrent -= 1
		GlobalVariables.playerBody.sayOuch()
