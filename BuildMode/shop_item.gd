class_name ShopItem
extends Button

signal itemBoughtSignal(moduleName)


@onready var description: Label = $Description

@export var moduleName:String
@export var cost:Dictionary = {
	"Cardboard" = 0,
	"Tape" = 0,
	"Screws" = 0
} 

func _on_pressed() -> void:
	var passed = true
	for key in cost.keys():
		if GlobalVariables.inventory.get(key) < cost.get(key):
			passed = false
	if passed:
		for key in cost.keys():
			GlobalVariables.inventory.set(key,GlobalVariables.inventory.get(key) - cost.get(key))
		emit_signal("itemBoughtSignal", self, moduleName)
