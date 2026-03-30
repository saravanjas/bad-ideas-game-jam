extends Node2D

@onready var anntena : PackedScene = preload("res://Enemies/Objectives/antenna.tscn")
@onready var enemies: Node2D = $root/World1/Enemies

func _ready() -> void:
	UINodeAccess.GameInstance
	GlobalVariables.projectilesNode = get_tree().get_first_node_in_group("Projectiles")
	spawn_objective(GlobalVariables.anntenaeDestroyed)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func spawn_objective( AntennaeDestroyed ):
	var antennaInstance = anntena.instantiate()
	match AntennaeDestroyed:
		0:
			enemies.add_child(antennaInstance)
			antennaInstance.rotation = randi_range(-50,50)
			antennaInstance.global_position = determineSpawnpoint( GlobalVariables.playerBody.global_position , 10000)
			GlobalVariables.nextObjective = antennaInstance
		1:
			enemies.add_child(antennaInstance)
			antennaInstance.rotation = randi_range(-50,50)
			antennaInstance.global_position = determineSpawnpoint( GlobalVariables.playerBody.global_position , 11000)
			GlobalVariables.nextObjective = antennaInstance
		2:
			enemies.add_child(antennaInstance)
			antennaInstance.rotation = randi_range(-50,50)
			antennaInstance.global_position = determineSpawnpoint( GlobalVariables.playerBody.global_position , 11000)
			GlobalVariables.nextObjective = antennaInstance
		3:
			enemies.add_child(antennaInstance)
			antennaInstance.rotation = randi_range(-50,50)
			antennaInstance.global_position = determineSpawnpoint( GlobalVariables.playerBody.global_position , 11000)
			GlobalVariables.nextObjective = antennaInstance
func determineSpawnpoint( playerPos : Vector2 , distance : int):
	var angle = randf() * TAU
	var x = cos(angle) * distance
	var y = sin(angle) * distance
	return playerPos + Vector2(x,y)
