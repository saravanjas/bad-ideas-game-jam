extends ModuleClass

const 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	

func actiavte():
	var modules:Array[ModuleClass] = getAdjacentModules()
	for module in modules:
		if module.has_method("activate"):
			module.activate()
