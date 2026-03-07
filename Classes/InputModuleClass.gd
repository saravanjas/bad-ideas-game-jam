class_name InputModuleClass
extends ModuleClass

@export var key:String
@onready var sprite_2d: Sprite2D = $Sprite2D

var keys = {
	"w":preload("uid://cxeo868pjb75g"),
	"a":preload("uid://c2ntpn00aoydo"),
	#"s":,
	#"d"
}

func _ready() -> void:
	playerCharacterBody = self.get_parent().get_parent()
	sprite_2d.texture = keys.get(key)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed(key):
		activate()

func activate():
	var modules:Array[ModuleClass] = getAdjacentModules()
	for module in modules:
		if module.has_method("activate") and not(module is InputModuleClass):
			module.activate()

func rotateModule(angle:float):
	self.rotation = 0
