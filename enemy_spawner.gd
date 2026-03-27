extends Node2D

@onready var cat_grunt : PackedScene = preload("res://Enemies/Enemies/meowship.tscn")
@onready var acidcat : PackedScene = preload("res://Enemies/Enemies/acidcat.tscn")
@onready var ghostcat : PackedScene = preload("res://Enemies/Enemies/ghostcat.tscn")
@onready var spawnLocation : PathFollow2D = get_tree().get_first_node_in_group("SpawnLocations")

@export var maxEnemyCount : int = 5
var currentEnemyCount : int = 0
var time_count : float 
func _ready() -> void:
	spawn_enemy()
func _process(delta: float) -> void:
	time_count += delta
	var seconds : int = time_count
	currentEnemyCount = get_child_count()
func spawn_enemy():
	pass
	if currentEnemyCount == maxEnemyCount:
		return
	var enemyChoice := randi_range(0,2)
	var enemy_instance
	match enemyChoice:
		0:
			enemy_instance = cat_grunt.instantiate()
		1:
			enemy_instance = acidcat.instantiate()
		2:
			enemy_instance = ghostcat.instantiate()
	spawnLocation.progress_ratio = randf_range(0,1)
	enemy_instance.global_position = spawnLocation.global_position
	add_child(enemy_instance)
	


func spawn_timer_timeout() -> void:
	#spawn_enemy()
	pass
