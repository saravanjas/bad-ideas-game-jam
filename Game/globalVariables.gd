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
var playerHealthMax := 30
var playerHealthCurrent := 30
var playerInvincible := false

var drMeowsteinMaxHp := 500
var drMeowsteinCurrentHp := 500
@export var playerCanBeDamagedTimer := Timer.new()
var inventory:Dictionary = {
	"Cardboard" = 100,
	"Tape" = 100,
	"Screws" = 100,
} 
