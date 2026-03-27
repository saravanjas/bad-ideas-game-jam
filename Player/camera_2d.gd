extends Camera2D
@onready var player_ship: ShipClass = $"../.."

@export var shakingEnabled := true
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	#position = player_ship.rootCenter.position
func shake(shakingStrenght ):
	if shakingEnabled:
		var tween = create_tween()
		tween.tween_property( self , "position:x" , randi_range(-shakingStrenght,shakingStrenght) , randi_range(0.1 , 0.2))
		tween.play()
		await tween.finished
		shake(shakingStrenght)

func stopShaking():
	shakingEnabled = false
