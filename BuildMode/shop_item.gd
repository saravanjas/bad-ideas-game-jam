class_name ShopItem
extends Button

signal itemBoughtSignal(moduleName)
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


@onready var description: Label = $Description
@onready var itemTexture : Sprite2D = $ItemOfferTexture
@export var moduleName:String
@export var cost:Dictionary = {
	"Cardboard" = 0,
	"Tape" = 0,
	"Screws" = 0
} 
var revealed := false



func _process(delta: float) -> void:
	if !GlobalVariables.inBuildMode:
		animated_sprite_2d.frame = 0
		revealed = false
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
	if !revealed:
		animated_sprite_2d.play("default")
		revealed = true
