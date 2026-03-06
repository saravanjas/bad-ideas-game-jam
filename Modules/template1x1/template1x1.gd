extends ModuleClass

func activate():
	print("activated")
	var vector:Vector2
	vector = lookVector * recoil	
	applyForceToSelf(vector)
