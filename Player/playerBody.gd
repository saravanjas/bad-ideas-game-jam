extends CharacterBody2D

@onready var tile_map_layer: TileMapLayer = $TileMapLayer


func die():
	print("Umro!")


func invincibility_timer_timeout() -> void:
	GlobalVariables.playerInvincible = false

func sayOuch():
	pass

func _process(delta: float) -> void:
	if GlobalVariables.playerHealthCurrent <= 0:
		get_tree().quit()
	GlobalVariables.playerHealthMax = tile_map_layer.get_child_count() * 5
