
extends Button


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

@export var moduleName:String
@onready var price_label_1: Label = $PriceTags/Control/Cardboard/PriceLabel1
@onready var sprite_2d: Sprite2D = $Sprite2D

@export var cost:Dictionary = {
	"Cardboard" = 1,
	"Tape" = 0,
	"Screws" = 0
} 

var pressedAmount := 0



func _process(delta: float) -> void:
	price_label_1.text = str(cost["Cardboard"])
	visible = GlobalVariables.buildModeSetupFinished
	if !GlobalVariables.canBuy:
		disabled = true
	else:
		disabled = false
func _on_pressed() -> void:
	var passed = true
	for key in cost.keys():
		if GlobalVariables.inventory.get(key) < cost.get(key):
			passed = false
	if passed:
		for key in cost.keys():
			GlobalVariables.inventory.set(key,GlobalVariables.inventory.get(key) - cost.get(key))
		increasePrice(pressedAmount)
		pressedAmount += 1
func _on_mouse_entered() -> void:
	audio_stream_player.play()
	var bounce = create_tween()
	bounce.set_trans(Tween.TRANS_CUBIC)
	bounce.tween_property(sprite_2d , "scale" , Vector2(4.5,4.5) , 0.3)
	bounce.play()
	await bounce.finished
	var bounceBack = create_tween()
	bounceBack.set_trans(Tween.TRANS_CUBIC)
	bounceBack.tween_property(sprite_2d , "scale" , Vector2(4.,4.) , 0.3)
	bounceBack.play()

func increasePrice(pressedAmount):
	match pressedAmount:
		0:
			cost["Cardboard"] += 1
		3:
			cost["Cardboard"] += 1
		5:
			cost["Cardboard"] += 1
		7:
			cost["Cardboard"] += 1
