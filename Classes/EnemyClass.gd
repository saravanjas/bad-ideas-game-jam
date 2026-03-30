class_name EnemyClass
extends CharacterBody2D

@export var healthPoints:int = 100
@export var speed:int = 200

@export var innerDistance:int = 50 #how can the enemy get to the player
@export var outerDistance:int = 100#the furthest the enemy needs to be to attack

@export var timeBeforeNewHoverRadius:int = 60


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var lootParent := get_tree().get_first_node_in_group("Loot")
var target = GlobalVariables.playerBody
var hoverRadius:int



func _ready() -> void:
	generateHoverRadiusLoop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if GlobalVariables.gamePaused : return
	
	#var direction = (target.global_position - global_position).normalized()
	#velocity = direction * speed
	calculateAndSetVelocity()
	
	move_and_slide()
	flip(velocity.x)
	if healthPoints <= 0:
		die()
		

func generateHoverRadiusLoop():
	while not GlobalVariables.gamePaused:
		print("yes")
		await get_tree().create_timer(timeBeforeNewHoverRadius).timeout
		hoverRadius = getNewHoverRadius()
	
func getNewHoverRadius() -> int: #generates the radius between inner and outer distancee
	return randi_range(innerDistance,outerDistance)
	

func calculateAndSetVelocity():
	var direction = (target.global_position - global_position).normalized()
	velocity = direction * speed * \
	(((target.global_position - global_position).length()-hoverRadius)/ hoverRadius)


func take_damage(damage):
	GlobalScripts.display_number(damage , global_position)
	animation_player.play("hit")
	healthPoints -= damage
	
func flip(side):
	if side < 0:
		animated_sprite_2d.flip_h = false
	else:
		animated_sprite_2d.flip_h = true

func die():
	GlobalScripts.spawnLoot( self.global_position , "Normal" , lootParent )
	call_deferred("queue_free")
