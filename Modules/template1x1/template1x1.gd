extends ModuleClass

func activate():
	var vector:Vector2
	lookVector = Vector2.from_angle(rotation+(PI/2.0)).normalized()
	vector = lookVector * recoil
	applyForceToSelf(vector)
