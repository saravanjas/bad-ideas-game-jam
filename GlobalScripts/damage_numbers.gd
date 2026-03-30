extends Node2D


var font : FontFile = preload("res://GUI/Fonts/Tanker-Regular.otf")
var text

var lootItem : PackedScene = preload("res://Scenes/Loot/item_drop.tscn")

const DUCT_TAPE_TEXTURE = preload("uid://c2rdhtlco6t2g")
const NAILS_TEXTURE = preload("uid://dmeekj2y5s8e1")
const CARDBOARD_TEXTURE = preload("uid://q55or2u1xafj")


func display_number(value : int , position : Vector2 ):
	if text == null:
		text = get_node("/root/Game/DamageNumbers")
	var number = Label.new()
	number.global_position = position
	number.text = str(value)
	number.z_index = 5
	number.label_settings = LabelSettings.new()
	number.position += Vector2(-1,-8)
	number.label_settings.font_color = "#FFFFFF"
	if value > 15:
		number.label_settings.font_color = "#FFFFC2"
	if value > 25:
		number.label_settings.font_color = "#FCE38D"
	if value > 35:
		number.label_settings.font_color = "#FFB86E"
	if value > 45:
		number.label_settings.font_color = "#FF6E6E"
	if value > 90:
		number.label_settings.font_color = "#ff0000"
	number.label_settings.font = font
	
	number.label_settings.font_size = 36
	number.label_settings.outline_color = "#000"
	number.label_settings.outline_size = 6
	
	text.call_deferred("add_child",number)

	await number.resized
	number.pivot_offset = Vector2(number.size / 2)
	
	var tween = get_tree().create_tween()
	tween.tween_property(
		number , "texture_filter" , 0 , 0
	)
	tween.set_parallel(true)  
	tween.tween_property(
		number , "position:y" , number.position.y - 6 , 0.25
	).set_ease(Tween.EASE_OUT)
	#tween.tween_property(
		#number , "position:y" ,number.position.y , 0.5
	#w).set_ease(Tween.EASE_IN).set_delay(0.5)
	"""await tween.finished
	var tween2 = get_tree().create_tween()
	tween2.tween_property(
		number , "scale" , Vector2.ZERO , 0.1
	).set_ease(Tween.EASE_IN).set_delay(0.5)
	tween2.tween_property(
		number , "modulate:a" , 0.0 , 0.6
	)"""
	
	await tween.finished
	if not is_instance_valid(number):
		return
	var tween2 = get_tree().create_tween()
	if tween2:
		tween2.tween_property(number , "scale" , Vector2.ZERO , 0.1).set_ease(Tween.EASE_IN).set_delay(0.5)
		tween2.tween_property(number , "modulate:a" , 0.0 , 0.6)
		await tween2.finished
	if is_instance_valid(number):
		number.queue_free()

func spawnLoot( globalPosition , enemyType , parent):
	var numberRoll := randf_range(0,1)
	var lootRoll := randf_range(0,1)
	if numberRoll >= 0.2:
		var lootInstance = lootItem.instantiate()
		lootInstance.type = determineItem(lootRoll , enemyType)
		lootInstance.texture = determineTexture(lootInstance.type)
		lootInstance.global_position = globalPosition
		parent.add_child(lootInstance)
		

func determineItem(lootRoll , enemyType):
	if enemyType == "Objective":
		return 2;
	else:
		if lootRoll >= 0.8:
			return 2
		elif lootRoll  >= 0.5:
			return 1
		else:
			return 0
func determineTexture( type ):
	match type:
		0:
			return CARDBOARD_TEXTURE
		1:
			return DUCT_TAPE_TEXTURE
		2:
			return NAILS_TEXTURE
