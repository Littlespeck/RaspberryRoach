extends Node2D

signal game_finished(result)

@export var bacon_platform: PackedScene
@export var lettuce_platform: PackedScene

var jump_mode = false
var player_character
var screen_size = 2080.0
var camera_altitude = screen_size / 3.0
var camera_offset = 0
var platform_spread = 80

func _ready():
	var new_map = load("res://Resources/Scenes/Maps/map_1.tscn").instantiate()
	add_child(new_map)
	var start_platform = lettuce_platform.instantiate()
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
	var platform = select_platform().instantiate()
	
	var platform_spawn_location = get_node("PlatformPath/PlatformSpawnLocation")
	platform_spawn_location.progress_ratio = randf()
	
	platform.position = platform_spawn_location.position
	platform.position.y = get_node("PlatformPath").position.y
	platform.scale.x = .5
	
	add_child(platform)
	get_node("PlatformPath").position.y -= platform_spread + 20 * randf()
	platform_spread += 1

func select_platform():
	var random_number = randi_range(1, 10)
	if random_number == 1:
		return bacon_platform
	else:
		return lettuce_platform
