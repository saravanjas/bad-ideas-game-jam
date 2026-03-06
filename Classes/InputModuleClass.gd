class_name InputModuleClass
extends ModuleClass

func activate():
	var modules:Array[ModuleClass] = getAdjacentModules()
	for module in modules:
		if module.has_method("activate"):
			module.activate()
