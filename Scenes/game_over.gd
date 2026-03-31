extends Control

func _ready():
	hide()
	
func _process(_delta):
	if GlobalVariables.playerHealthCurrent <= 0 and not visible:
		trigger_game_over()
		
func trigger_game_over():
	visible = true
	get_tree().paused = true

func _on_quit_pressed() -> void:
	get_tree().quit()
