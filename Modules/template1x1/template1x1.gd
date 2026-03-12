extends ModuleClass

func activate():
	var vector:Vector2
	
	
	#lookVector = Vector2.from_angle(rotation+(PI/2.0)).normalized()
	var lookVector2 = lookVector()
	vector = lookVector2 * recoil
	applyForceToSelf(vector)
	
	applyTorqueToSelf(vector)
	
