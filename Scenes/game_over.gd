extends Control

var is_dying := false

func _ready():
	hide()
	
func _process(_delta):
	if GlobalVariables.playerHealthCurrent <= 0 and not visible and not is_dying:
		start_death()
		
func start_death():
	is_dying = true
	GlobalVariables.playerInvincible = true
	
	await get_tree().create_timer(1.0).timeout
	trigger_game_over()
		
func trigger_game_over():
	$AudioStreamPlayer.play()
	visible = true
	get_tree().paused = true

func _on_quit_pressed() -> void:
	get_tree().quit()
