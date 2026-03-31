extends CharacterBody2D



func die():
	print("Umro!")


func invincibility_timer_timeout() -> void:
	GlobalVariables.playerInvincible = false

func sayOuch():
	pass

func _process(delta: float) -> void:
	pass
