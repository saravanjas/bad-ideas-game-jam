extends Area2D

@onready var loot_collection_area: Area2D = $"../LootCollectionArea"


func set_target():
	return loot_collection_area
