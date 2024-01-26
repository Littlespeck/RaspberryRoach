extends Node2D

signal game_finished(result)
signal PlayerDied

var jump_mode = false
var player_character
var screen_size = 2080.0
var camera_altitude = screen_size / 3.75
var camera_offset = 0
var CCKnife_altitude = screen_size / 5
var CCKnife_offset = 600
@export var platform_spread = 80
var powerup_spread = 2000

var score = 0
var Pup_Points = 0

const BaconPlatform: PackedScene = preload("res://Resources/Scenes/Objects/Platforms/bacon_platform.tscn")
const LettucePlatform: PackedScene = preload("res://Resources/Scenes/Objects/Platforms/lettuce_platform.tscn")
const BagelPlatform: PackedScene = preload("res://Resources/Scenes/Objects/Platforms/bagel_platform.tscn")
const GurkinPlatform: PackedScene = preload("res://Resources/Scenes/Objects/Platforms/gurkin_platform.tscn")
const TomatoPlatform: PackedScene = preload("res://Resources/Scenes/Objects/Platforms/tomato_platform.tscn")

const Berry: PackedScene = preload("res://Resources/Scenes/Objects/Fruit/berry.tscn")
const Candy: PackedScene = preload("res://Resources/Scenes/Objects/Fruit/candy.tscn")
const Gummy: PackedScene = preload("res://Resources/Scenes/Objects/Fruit/gummy.tscn")

func _ready():
	var new_map = load("res://Resources/Scenes/Maps/map_1.tscn").instantiate()
	add_child(new_map)
	
	var start_platform = BagelPlatform.instantiate()
	start_platform.position = Vector2(360, 960)
	$PlatformContainer.add_child(start_platform)
	
	player_character = load("res://Resources/Scenes/Objects/PlayerSprite.tscn").instantiate()
	player_character.position = Vector2(360, 900)
	player_character.scale = Vector2(.20, .20)
	add_child(player_character)
	
	var CCKnife = load("res://Resources/Scenes/Objects/cc_knife.tscn").instantiate()
	add_child(CCKnife)
	CCKnife.position = Vector2(360, 2000)
	CCKnife.scale = Vector2(.55, .55)
	
	get_node("Camera2D").position.y = camera_altitude
	
	get_node("CCKnife").connect("PlayerDied", GameFinished)
	
	spawn_platform()

func _process(_delta):
	
	if player_character != null:
		if get_node("Roach PC").position.y + camera_offset < camera_altitude:
			camera_altitude = get_node("Roach PC").position.y + camera_offset
			get_node("Camera2D").position.y = camera_altitude
			

		if get_node("Roach PC").position.y > get_node("Camera2D").position.y + screen_size:
			GameFinished(score)
			print(score)

func _physics_process(delta):
	if get_node("CCKnife").position.y - get_node("Roach PC").position.y < 1000:
		get_node("CCKnife").position.y -= 100 * delta 
	else:
		get_node("CCKnife").position.y -= 500 * delta
	if get_node("Camera2D").position.y < get_node("PlatformPath").position.y + 1000:
		spawn_platform()
		get_node("PlatformPath").position.y -= platform_spread + 20 * randf()
		platform_spread += 1
	if get_node("Camera2D").position.y < get_node("PowerUpPath").position.y + 3000:
		var coin = randi_range(0,1)
		if coin == 0:
			spawn_powerup()
	UpdateScore()

func spawn_platform():
	var platform = select_platform().instantiate()
	
	var platform_spawn_location = get_node("PlatformPath/PlatformSpawnLocation")
	platform_spawn_location.progress_ratio = randf()
	
	platform.position = platform_spawn_location.position
	platform.position.y = get_node("PlatformPath").position.y
	platform.scale.x = .7
	
	$PlatformContainer.add_child(platform)
	
func spawn_powerup():
	var powerup = select_powerup().instantiate()
	
	var platform_spawn_location = get_node("PowerUpPath/PowerUpSpawnLocation")
	platform_spawn_location.progress_ratio = randf()
	
	powerup.position = platform_spawn_location.position
	powerup.position.y = get_node("PowerUpPath").position.y
	powerup.scale.x = .7
	
	$PlatformContainer.add_child(powerup)
	get_node("PowerUpPath").position.y -= powerup_spread + 20 * randf()
	
func select_powerup():
	var random_number = randi_range(1, 3)
	match random_number:
		1:
			return Berry
		2:
			return Candy
		3:
			return Gummy

func select_platform():
	var random_number = randi_range(1, 4)
	match random_number:
		1:
			return BaconPlatform
		2:
			return LettucePlatform
		3:
			return GurkinPlatform
		4:
			return TomatoPlatform

func UpdateScore():
	if get_node("Roach PC").position.y < 0 and -get_node("Roach PC").position.y +Pup_Points > score:
		score = snapped(-get_node("Roach PC").position.y, 0) + Pup_Points
		get_node("CanvasLayer/Control/ScoreLabel").text = str(score)


func GameFinished(finalscore):
	emit_signal("game_finished", finalscore)
