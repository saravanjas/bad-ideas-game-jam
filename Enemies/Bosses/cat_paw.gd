extends CharacterBody2D

var speed = 350
var acceleration = 40
@onready var dr_meowstein: CharacterBody2D = $".."
var target
@export var preferred_distance: float = 15
@export var tolerance: float = 5
@export var distance_noise: float = 5 # how much randomness
var orbit_direction: int = 1




@export var turn_speed: float = 4  # how fast it can turn

@onready var marker_1: Marker2D = $"../PawMarkers/Marker1"
@onready var marker_2: Marker2D = $"../PawMarkers/Marker2"


func _process(delta: float) -> void:
	if !dr_meowstein.pawActive:
		match name:
			"CatPaw1":
				target = marker_1
				var to_player = target.global_position - global_position
				var distance = to_player.length()
				var direction = to_player.normalized()
				
				var target_distance = preferred_distance + randf_range(-20.0, 20.0)
				var move_dir = Vector2.ZERO
				if distance > target_distance + tolerance:
					move_dir = direction
				elif distance < target_distance - tolerance:
					move_dir = -direction
				else:
					move_dir = Vector2(-direction.y, direction.x) * orbit_direction
				velocity = velocity.lerp(move_dir * speed, acceleration * delta)
				move_and_slide()
			"CatPaw2":
				target = marker_2
				var to_player = target.global_position - global_position
				var distance = to_player.length()
				var direction = to_player.normalized()
				
				var target_distance = preferred_distance + randf_range(-20.0, 20.0)
				var move_dir = Vector2.ZERO
				if distance > target_distance + tolerance:
					move_dir = direction
				elif distance < target_distance - tolerance:
					move_dir = -direction
				else:
					move_dir = Vector2(-direction.y, direction.x) * orbit_direction
				velocity = velocity.lerp(move_dir * speed, acceleration * delta)
				move_and_slide()
	else:
		target = GlobalVariables.playerBody
		
		var desired_dir = (target.global_position - global_position).normalized()
		var current_dir = velocity.normalized()
		var new_dir = current_dir.lerp(desired_dir, turn_speed * delta).normalized()
		rotation = new_dir.angle() + PI/2
		velocity = new_dir * speed
		move_and_slide()
		
