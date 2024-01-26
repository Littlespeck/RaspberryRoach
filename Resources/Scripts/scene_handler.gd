extends Node

signal toggle_options

@export var control_root : Node
@onready var options_menu = preload("res://Resources/Scenes/UI/options_base.tscn").instantiate()

func _ready():
	#load_options_menu()
	load_main_menu()


func load_options_menu():
	get_tree().root.add_child.call_deferred(options_menu)

func load_main_menu():
	get_node("main_menu_base/options_container/start_game_button").connect("pressed", on_new_game_pressed)
	get_node("main_menu_base/options_container/quit_game_button").connect("pressed", on_quit_game_pressed)
	get_node("main_menu_base/options_container/options_menu_button").connect("pressed", on_options_menu_pressed)

##
##Buttons
##

func on_new_game_pressed():
	get_node("main_menu_base").queue_free()
	var game_scene = load("res://Resources/Scenes/Control/game_scene.tscn").instantiate()
	add_child(game_scene)
	game_scene.connect("game_finished", unload_game)

func on_quit_game_pressed():
	get_tree().quit()

func unload_game(score):
	get_node("GameScene").queue_free()
	$Munch.play()
	
	
	var game_over_scene = load("res://Resources/Scenes/UI/GameOverScene.tscn").instantiate()
	game_over_scene.get_node("Control").get_node("ScoreLabel").text = str(score)
	
	add_child(game_over_scene)
	
	get_node("GameOverScene/ButtonContainer/VBoxContainer/MainMenuButton").connect("pressed", on_main_menu_button_pressed)
	get_node("GameOverScene/ButtonContainer/VBoxContainer/PlayAgainButton").connect("pressed", on_play_again_button_pressed)

func on_main_menu_button_pressed():
	print("pressed")
	get_node("GameOverScene").queue_free()
	var main_menu = load("res://Resources/Scenes/UI/main_menu_base.tscn").instantiate()
	add_child(main_menu)
	load_main_menu()

func on_play_again_button_pressed():
	print("pressed")
	get_node("GameOverScene").queue_free()
	var game_scene = load("res://Resources/Scenes/Control/game_scene.tscn").instantiate()
	add_child(game_scene)
	game_scene.connect("game_finished", unload_game)

func on_options_menu_pressed():
	emit_signal("toggle_options")

