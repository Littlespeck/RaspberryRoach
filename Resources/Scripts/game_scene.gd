extends Node2D

signal game_finished(result)

var jump_mode = false
var player_character

func _ready():
	var new_map = load("res://Resources/Scenes/Maps/map_1.tscn").instantiate()
	add_child(new_map)
	var start_platform = load("res://Resources/Scenes/Objects/bacon_platform.tscn").instantiate()
	start_platform.position = Vector2(360, 1000)
	add_child(start_platform)
	player_character = load("res://Resources/Scenes/Objects/PlayerNode.tscn").instantiate()
	player_character.position = Vector2(360, 900)
	add_child(player_character)
