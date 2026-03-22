class_name ProjectileModuleClass
extends ModuleClass

@export var procjetile:PackedScene
func _ready():
	pass

func _process(_delta: float) -> void:
	pass

func spawnProjectile() -> ProjectileClass:
	var proj:ProjectileClass = procjetile.instantiate()
	proj.global_position = self.global_position
	proj.rotation = lookVector().angle()
	GlobalVariables.projectilesNode.add_child(proj)
	return proj
