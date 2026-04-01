class_name ShopItem
extends Button

signal itemBoughtSignal(moduleName)
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var audio_stream_player_1: AudioStreamPlayer = $AudioStreamPlayer1

@onready var description: Label = $Description
@onready var itemTexture : Sprite2D = $ItemOfferTexture
@export var moduleName:String
@onready var price_label_1: Label = $PriceTags/Control/Cardboard/PriceLabel1
@onready var price_label_2: Label = $PriceTags/Control2/Tape/PriceLabel2
@onready var price_label_3: Label = $PriceTags/Control3/Nails/PriceLabel3

@export var cost:Dictionary = {
	"Cardboard" = 0,
	"Tape" = 0,
	"Screws" = 0
} 
var revealed := false



func _process(delta: float) -> void:
	if !GlobalVariables.canBuy:
		disabled = true
	else:
		disabled = false
	if !GlobalVariables.inBuildMode:
		animated_sprite_2d.frame = 0
		revealed = false
	itemTexture.visible = GlobalVariables.inBuildMode
func _on_pressed() -> void:
	var passed = true
	for key in cost.keys():
		if GlobalVariables.inventory.get(key) < cost.get(key):
			passed = false
	if passed:
		for key in cost.keys():
			GlobalVariables.inventory.set(key,GlobalVariables.inventory.get(key) - cost.get(key))
		emit_signal("itemBoughtSignal", self, moduleName)
func _on_mouse_entered() -> void:
	bounce()
	if GlobalVariables.buildModeSetupFinished:
		if !revealed:
			animated_sprite_2d.play("default")
			revealed = true
func bounce() -> void:
	audio_stream_player_1.pitch_scale = randf_range(0.9,1.1)
	audio_stream_player_1.play()
	var bounce = create_tween()
	bounce.set_trans(Tween.TRANS_CUBIC)
	bounce.set_parallel(true)
	bounce.tween_property( $AnimatedSprite2D , "scale" , Vector2(2.5,2.5) , 0.3)
	bounce.tween_property( $Sprite2D , "scale" , Vector2(2.5,2.5),0.3)
	bounce.play()
	await bounce.finished
	var bounceBack = create_tween()
	bounceBack.set_trans(Tween.TRANS_CUBIC)
	bounceBack.set_parallel(true)
	bounceBack.tween_property( $Sprite2D , "scale" , Vector2(2.,2.),0.3)
	bounceBack.tween_property($AnimatedSprite2D , "scale" , Vector2(2.,2.) , 0.3)
	bounceBack.play()
