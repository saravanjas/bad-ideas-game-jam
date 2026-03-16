extends Node

const moduli = "res://Sprites/Moduli/ModulSpriteovi/"

var textures = {
	"inputA" = preload(moduli + "keyA.png"),
	"inputW" = preload(moduli + "keyW.png"),
	"knife" = preload(moduli + "knifeModule.png"),
	"rocket" = preload(moduli + "rocketModule.png"),
	"thruster" = preload("res://TempSprites/1x1.png")
}

var ids = {
	"inputA" = 4,
	"inputW" = 3,
	"knife" = 5,
	"rocket" = 6,
	"thruster" = 1
}
