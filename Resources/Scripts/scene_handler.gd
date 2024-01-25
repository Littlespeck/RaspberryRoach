extends Node

signal MainMenuPressed
signal PlayAgainPressed

var score_table = []

@export var control_root : Node
@onready var options_menu = preload("res://Resources/Scenes/UI/options_base.tscn").instantiate()

func _ready():
	for i in Globals.high_score_table:
		score_table.append(Globals.high_score_table[i])
	#load_options_menu()
	load_main_menu()


func load_options_menu():
	get_tree().root.add_child.call_deferred(options_menu)

func load_main_menu():
	get_node("main_menu_base/options_container/start_game_button").connect("pressed", on_new_game_pressed)
	get_node("main_menu_base/options_container/quit_game_button").connect("pressed", on_quit_game_pressed)

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
	score_table.append(score)
	score_table.sort_custom(descending_sort)
	score_table.remove_at(3)
	print(score_table)
	
	
	var game_over_scene = load("res://Resources/Scenes/UI/GameOverScene.tscn").instantiate()
	game_over_scene.get_node("ScoreLabel").text = "Score: " + str(score)
	
	add_child(game_over_scene)
	
	get_node("GameOverScene/ButtonContainer/VBoxContainer/PlayAgainButton").connect("Pressed", on_main_menu_button_pressed)
	get_node("GameOverScene/ButtonContainer/VBoxContainer/MainMenuButton").connect("Pressed", on_play_again_button_pressed)

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
	
func descending_sort(a, b):
	if a >= b:
		return true
	return false
