extends CharacterBody2D


const SPEED = 30000.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	var direction : Vector2 = Input.get_vector("a" , "d" , "w" , "s")
	velocity = direction * SPEED
	move_and_slide()
