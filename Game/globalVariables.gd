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
var BuyTileMap

var canBuy := true
var drMeowsteinMaxHp := 1800
var drMeowsteinCurrentHp := 1800
var bossFight := false

@export var playerCanBeDamagedTimer := Timer.new()
var inventory:Dictionary = {
	"Cardboard" = 0,
	"Tape" = 0,
	"Screws" = 0,
} 
func _process(delta: float) -> void:
	playerHealthCurrent = clamp(playerHealthCurrent , 0 , playerHealthMax)
