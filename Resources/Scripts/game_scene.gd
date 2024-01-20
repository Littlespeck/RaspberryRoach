extends Node2D

signal game_finished(result)

var jump_mode = false
var player_character
var screen_size = 2080.0
var camera_altitude = screen_size / 2.0
var camera_offset = 600

func _ready():
	var new_map = load("res://Resources/Scenes/Maps/map_1.tscn").instantiate()
	add_child(new_map)
	var start_platform = load("res://Resources/Scenes/Objects/bacon_platform.tscn").instantiate()
	start_platform.position = Vector2(360, 1000)
	add_child(start_platform)
	player_character = load("res://Resources/Scenes/Objects/PlayerNode.tscn").instantiate()
	player_character.position = Vector2(360, 900)
	add_child(player_character)
	get_node("Camera2D").position.y = camera_altitude

func _process(delta):
	if get_node("Player/Roach PC").position.y + camera_offset < camera_altitude:
		camera_altitude = get_node("Player/Roach PC").position.y + camera_offset
		get_node("Camera2D").position.y = camera_altitude

	if get_node("Player/Roach PC").position.y > get_node("Camera2D").position.y + screen_size:
		var score = -camera_altitude
		emit_signal("game_finished", score)
