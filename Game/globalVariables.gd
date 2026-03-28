extends Node

var gamePaused := false
var inBuildMode := false
var buildModeSetupFinished := false
var playerTilemap:TileMapLayer
var player:ShipClass
var playerBody:CharacterBody2D 
var playerCamera : Camera2D
var projectilesNode:Node
var hasSelectedModule := false
var anntenaeDestroyed := 0
var nextObjective = null
var objectiveOnScreen := false
var inCombat := false
var inventory:Dictionary = {
	"Cardboard" = 0,
	"Tape" = 0,
	"Screws" = 0
} 
