extends CharacterBody2D

@onready var target : CharacterBody2D = get_tree().get_first_node_in_group("PlayerAccess")
@onready var loot : PackedScene = preload("res://Scenes/Loot/item_drop.tscn")
@onready var lootParent := get_tree().get_first_node_in_group("Loot")
var speed := 400
@export var healthPoints := 15
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if GlobalVariables.gamePaused : return
	#global_position = global_position.move_toward(target.global_position , speed * delta)
	var direction = (target.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
	if healthPoints <= 0:
		die()
func take_damage(damage):
	healthPoints -= damage
	
func die():
	var lootInstance = loot.instantiate()
	lootParent.call_deferred("add_sibling" , lootInstance)
	lootInstance.global_position = self.global_position
	call_deferred("queue_free")
