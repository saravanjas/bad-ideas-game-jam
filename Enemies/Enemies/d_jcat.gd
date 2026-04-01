extends CharacterBody2D


@onready var target : CharacterBody2D = get_tree().get_first_node_in_group("PlayerAccess")
@onready var lootParent := get_tree().get_first_node_in_group("Loot")


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var damageSFX: AudioStreamPlayer2D = $DamageSFX
@onready var wing_flapping: AudioStreamPlayer2D = $WingFlapping



var speed := 300
@export var healthPoints := 30
@export var damage = 15

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if GlobalVariables.gamePaused : return
	#global_position = global_position.move_toward(target.global_position , speed * delta)
	var direction = (target.global_position - global_position).normalized()
	velocity = direction * speed
	flip(velocity.x)
	move_and_slide()
	
	if healthPoints <= 0:
		die()
func take_damage(damage):
	damageSFX.pitch_scale = randf_range(0.8,1.2)
	damageSFX.play()
	GlobalScripts.display_number(damage , global_position)
	animation_player.play("hit")
	healthPoints -= damage
	
func die():
	GlobalScripts.spawnLoot( self.global_position , "Normal" , lootParent )
	call_deferred("queue_free")

func flip(side):
	if side < 0:
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.flip_h = false
