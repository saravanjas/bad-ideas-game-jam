extends AudioStreamPlayer
@onready var main_menu_ost: AudioStreamPlayer = $"."
@onready var boss_fight_ost: AudioStreamPlayer = $"../BossFightOST"
@onready var build_mode_ost: AudioStreamPlayer = $"../BuildModeOST"

var currentPlaying : AudioStreamPlayer = null
func _ready() -> void:
	currentPlaying = main_menu_ost

func changeTrack(index):
	var volTween = create_tween()
	volTween.tween_property( currentPlaying , "volume_db" , -15 , 1.5)
	volTween.play()
	await volTween.finished
	currentPlaying.stop()
	match index:
		0:
			currentPlaying = main_menu_ost
			currentPlaying.play()
			var volumeUp = create_tween()
			volumeUp.tween_property(currentPlaying , "volume_db" , 0. , 1.5)
			volumeUp.play()
		1:
			currentPlaying = main_menu_ost
			currentPlaying.play()
			var volumeUp = create_tween()
			volumeUp.tween_property(currentPlaying , "volume_db" , 0. , 1.5)
			volumeUp.play()
		2:
			currentPlaying = build_mode_ost
			currentPlaying.play()
			var volumeUp = create_tween()
			volumeUp.tween_property(currentPlaying , "volume_db" , 0. , 1.5)
			volumeUp.play()
