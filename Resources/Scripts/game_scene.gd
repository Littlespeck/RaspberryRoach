extends Node2D

signal game_finished(result)

@export var platform_scene: PackedScene

var jump_mode = false
var player_character
var screen_size = 2080.0
var camera_altitude = screen_size / 3.0
var camera_offset = 0
var platform_spread = 400

func _ready():
	var new_map = load("res://Resources/Scenes/Maps/map_1.tscn").instantiate()
	add_child(new_map)
	var start_platform = load("res://Resources/Scenes/Objects/bacon_platform.tscn").instantiate()
	start_platform.position = Vector2(360, 1000)
	add_child(start_platform)
	player_character = load("res://Resources/Scenes/Objects/PlayerSprite.tscn").instantiate()
	player_character.position = Vector2(360, 900)
	player_character.scale = Vector2(.2, .2)
	add_child(player_character)
	get_node("Camera2D").position.y = camera_altitude
	
	spawn_platform()

func _process(_delta):
	if get_node("Roach PC").position.y + camera_offset < camera_altitude:
		camera_altitude = get_node("Roach PC").position.y + camera_offset
		get_node("Camera2D").position.y = camera_altitude

	if get_node("Roach PC").position.y > get_node("Camera2D").position.y + screen_size:
		var score = -camera_altitude
		emit_signal("game_finished", score)
	
func _physics_process(_delta):
	if get_node("Camera2D").position.y + 1000 > get_node("PlatformPath").position.y:
		spawn_platform()

func spawn_platform():
	var platform = platform_scene.instantiate()
	
	var platform_spawn_location = get_node("PlatformPath/PlatformSpawnLocation")
	platform_spawn_location.progress_ratio = randf()
	
	platform.position = platform_spawn_location.position
	platform.position.y = get_node("PlatformPath").position.y
	platform.scale.x = .5
	
	add_child(platform)
	get_node("PlatformPath").position.y -= platform_spread
	platform_spread += 5
