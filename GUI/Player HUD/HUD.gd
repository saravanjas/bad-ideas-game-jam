extends CanvasLayer

@onready var cardboard: Label = $Control/ItemInfo/Control/Cardboard/Cardboard
@onready var duct_tape: Label = $Control/ItemInfo/Control2/Tape/DuctTape
@onready var screws: Label = $Control/ItemInfo/Control3/Nails/Screws

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cardboard.text = str(GlobalVariables.inventory["Cardboard"])
	duct_tape.text = str(GlobalVariables.inventory["Tape"])
	screws.text = str(GlobalVariables.inventory["Screws"])
