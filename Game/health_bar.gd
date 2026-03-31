extends TextureProgressBar

func _ready() -> void:
	max_value = GlobalVariables.playerHealthMax
	value = GlobalVariables.playerHealthCurrent

func _process(delta: float) -> void:
	max_value = GlobalVariables.playerHealthMax
	value = GlobalVariables.playerHealthCurrent
