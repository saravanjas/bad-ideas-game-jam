extends CharacterBody2D

@onready var target : CharacterBody2D = get_tree().get_first_node_in_group("PlayerAccess")
@onready var lootParent := get_tree().get_first_node_in_group("Loot")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var damage_sfx: AudioStreamPlayer2D = $DamageSFX

var speed := 225
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
	damage_sfx.pitch_scale = randf_range(0.8,1.2)
	damage_sfx.play()
	GlobalScripts.display_number(damage , global_position)
	animation_player.play("hit")
	healthPoints -= damage
	
func die():
	GlobalScripts.spawnLoot( self.global_position , "Normal" , lootParent )
	call_deferred("queue_free")
