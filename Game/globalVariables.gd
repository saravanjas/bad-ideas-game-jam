extends Node

var gamePaused := false
var inBuildMode := false
var buildModeSetupFinished := false
var playerTilemap:TileMapLayer
var player:ShipClass
var playerBody:CharacterBody2D 

var projectilesNode:Node
