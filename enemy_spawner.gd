extends Node2D

@onready var cat_grunt : PackedScene = preload("res://Enemies/Enemies/meowship.tscn")
@onready var spawnLocation : PathFollow2D = get_tree().get_first_node_in_group("SpawnLocations")


func _ready() -> void:
	spawn_enemy()
func spawn_enemy():
	var enemy_instance = cat_grunt.instantiate()
	spawnLocation.progress_ratio = randf_range(0,1)
	enemy_instance.global_position = spawnLocation.global_position
	add_child(enemy_instance)
	


func spawn_timer_timeout() -> void:
	spawn_enemy()
