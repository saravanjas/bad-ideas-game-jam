extends ModuleClass
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var active : bool = false
@onready var booster_timeout_node: Timer = $BoosterTimeout
var current_anim : String 

func activate():
	animated_sprite_2d.visible = true
	booster_timeout_node.start()
	var vector:Vector2
	if active:
		animated_sprite_2d.play("on")
		current_anim = "on"
	else:
		animated_sprite_2d.play("start")
		current_anim = "start"
	#lookVector = Vector2.from_angle(rotation+(PI/2.0)).normalized()
	var lookVector2 = lookVector()
	vector = lookVector2 * recoil
	applyForceToSelf(vector)
	
	applyTorqueToSelf(vector)
	


func _on_animated_sprite_2d_animation_finished() -> void:
	if current_anim != "reset":
		active = true


func booster_timeout() -> void:
	$AnimatedSprite2D.play("reset")
	active = false
	current_anim = "reset"
