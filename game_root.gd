extends Node
var MAIN_MENU = preload("uid://cxs2w1oj2u4dy")
var ROOT = preload("res://game.tscn")
var OPTIONS = preload("uid://c6lgqrkh8s6ou")

var mainMenuInstance
var optionsInstance
var gameInstance
 
@onready var game_parent: Node2D = $GameParent

func _ready() -> void:
	
	
	
	mainMenuInstance = MAIN_MENU.instantiate()
	optionsInstance = OPTIONS.instantiate()
	gameInstance = ROOT.instantiate()
	
	UINodeAccess.MainMenu = mainMenuInstance
	UINodeAccess.OptionsMenu = optionsInstance
	UINodeAccess.GameInstance = gameInstance
	UINodeAccess.GameRoot = self
	
	add_child(optionsInstance)
	add_child(mainMenuInstance)
