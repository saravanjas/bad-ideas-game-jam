extends Node

var moduleIds:Dictionary = {
	"InputModuleA" = 4,
	"InputModuleW" = 3,
	"RocketModule" = 5,
	"ThrusterModule" = 1,
	"BlackholeModule" = 6,
	"LightningModule" = 7,
	"LaserModule" = 8,
	"InputModuleD" = 9,
	"InputModuleS" = 10,
	"RegenModule" = 11,
}

var moduleInfo:Dictionary = {
	
	"InputModuleA" = {
		"Cost" = [1,2,1],
		"Text" = "Input A" ,
		"Texture" = "res://Sprites/Ship/Moduli/ModulSpriteovi/keyA.png",
		"Weight" = 0.5
	},
	
	
	"InputModuleW" = {
		"Cost" = [1,2,1],
		"Text" = "Input W",
		"Texture" = "res://Sprites/Ship/Moduli/ModulSpriteovi/keyW.png",
		"Weight" = 0.5
	} ,
	
	
	"InputModuleS" = {
		"Cost" = [1,2,1],
		"Text" = "bmk iskr",
		"Texture" = "res://Sprites/Ship/Moduli/ModulSpriteovi/keyS.png",
		"Weight" = 0.5
	},
	
	
	"InputModuleD" = {
		"Cost" = [1,2,1],
		"Text" = "Ma-ma-mangio pasta , italiano lifestyle",
		"Texture" = "res://Sprites/Ship/Moduli/ModulSpriteovi/keyD.png",
		"Weight" = 0.5
	},
	
	
	"RocketModule"  = {
		"Cost" = [1,0,0],
		"Text" = "Rocket" ,
		"Texture" = "res://Sprites/Ship/Moduli/ModulSpriteovi/rocketModule.png",
		"Weight" = 3
	} ,
	
	
	"ThrusterModule"  = {
		"Cost" = [4,2,0],
		"Text" = "Thruster",
		"Texture" = "res://Sprites/Ship/Moduli/ModulSpriteovi/boosterModule.png",
		"Weight" = 2
	} ,
	
	
	"BlackholeModule" = {
		"Cost" = [4,4,8],
		"Text" = "It's super-massive.",
		"Texture" = "res://Sprites/Ship/Moduli/ModulSpriteovi/blackholeModule.png",
		"Weight" = 0.5
	},
	
	
	"LightningModule" = {
		"Cost" = [1,2,4],
		"Text" = "Z!z-zap!",
		"Texture" = "res://Sprites/Ship/Moduli/ModulSpriteovi/lightningModule.png",
		"Weight" = 1.75
	},
	
	
	"LaserModule" = {
		"Cost" = [0,1,5],
		"Text" = "Shing shing shing shing",
		"Texture" = "res://Sprites/Ship/Moduli/ModulSpriteovi/LaserModule.png",
		"Weight" = 2.75
	},
	
	
	"RegenModule" = {
		"Cost" = [3,3,3],
		"Text" = "Shing shing shing shing",
		"Texture" = "res://Sprites/Ship/Moduli/ModulSpriteovi/healingModule.png",
		"Weight" = 2
	}
}
