extends Node

var moduleIds:Dictionary = {
	"InputModuleA" = 4,
	"InputModuleW" = 3,
	"RocketModule" = 5,
	"ThrusterModule" = 1
}

var moduleInfo:Dictionary = {
	
	"InputModuleA" = {
		"Cost" = [1,2,1],
		"Text" = "Input A" ,
		"Texture" = "res://Sprites/Ship/Moduli/ModulSpriteovi/keyA.png"
	},
	
	
	"InputModuleW" = {
		"Cost" = [1,2,1],
		"Text" = "Input W",
		"Texture" = "res://Sprites/Ship/Moduli/ModulSpriteovi/keyW.png"
	} ,
	
	
	"RocketModule"  = {
		"Cost" = [1,0,0],
		"Text" = "Rocket" ,
		"Texture" = "res://Sprites/Ship/Moduli/ModulSpriteovi/rocketModule.png"
	} ,
	
	
	"ThrusterModule"  = {
		"Cost" = [4,2,0],
		"Text" = "Thruster",
		"Texture" = "res://Sprites/Ship/Moduli/ModulSpriteovi/boosterModule.png"
	} 
	
}
