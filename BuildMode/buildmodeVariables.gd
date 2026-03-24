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
		"Text" = "Input A"
	},
	
	
	"InputModuleW" = {
		"Cost" = [1,2,1],
		"Text" = "Input W"
	} ,
	
	
	"RocketModule"  = {
		"Cost" = [1,0,0],
		"Text" = "Rocket"
	} ,
	
	
	"ThrusterModule"  = {
		"Cost" = [4,2,0],
		"Text" = "Thruster"
	} 
	
}
