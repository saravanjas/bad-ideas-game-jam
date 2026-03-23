extends CharacterBody2D


@onready var target : CharacterBody2D = get_tree().get_first_node_in_group("PlayerAccess")
@onready var loot : PackedScene = preload("res://Scenes/Loot/item_drop.tscn")
@onready var lootParent := get_tree().get_first_node_in_group("Loot")
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var speed := 250
@export var healthPoints := 30
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if GlobalVariables.gamePaused : return
	#global_position = global_position.move_toward(target.global_position , speed * delta)
	var direction = (target.global_position - global_position).normalized()
	flip(velocity.x)
	velocity = direction * speed
	move_and_slide()
	if healthPoints <= 0:
		die()
func take_damage(damage):
	animation_player.play("hit")
	healthPoints -= damage
	
func die():
	var lootInstance = loot.instantiate()
	lootParent.call_deferred("add_sibling" , lootInstance)
	lootInstance.global_position = self.global_position
	call_deferred("queue_free")
	
func flip(side):
	if side < 0:
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.flip_h = false
