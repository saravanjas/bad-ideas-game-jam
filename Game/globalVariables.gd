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
var inventory:Dictionary = {
	"Cardboard" = 100,
	"Tape" = 100,
	"Screws" = 100
} 
