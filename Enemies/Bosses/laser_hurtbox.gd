extends Area2D



var overlap : Array = []
var entered := false

func setInvincibilityFrames(area: Area2D) -> void:
	entered = true
	if area.has_method("setIFrameLenght"):
		area.setIFrameLenght(0.019)


func resetIFrames(area: Area2D) -> void:
	entered = false
	overlap.clear()
	if area.has_method("resetIFrameLenght"):
		area.resetIFrameLenght()

func _process(delta: float) -> void:
	if monitoring:
		overlap = get_overlapping_areas()
		if entered:
			if !(overlap == []):
				for area in overlap:
					if area.has_method("hitByBoss"):
						area.hitByBoss(null)
