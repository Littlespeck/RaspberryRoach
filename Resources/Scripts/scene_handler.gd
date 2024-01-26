extends Node

signal toggle_options

var start_button : Button
var options_button : Button
var quit_button : Button
@export var control_root : Node
@onready var options_menu = preload("res://Resources/Scenes/UI/options_base.tscn").instantiate()

func _ready():
	Globals.connect("_toggle_options_menu",on_options_menu_close)
	load_options_menu()
	load_main_menu()


func load_options_menu():
	get_tree().root.add_child.call_deferred(options_menu)
	options_menu.hide()

func load_main_menu():
	start_button = get_node("main_menu_base/options_container/start_game_button")#.connect("pressed", on_new_game_pressed)
	start_button.connect("pressed", on_new_game_pressed)
	options_button = get_node("main_menu_base/options_container/options_menu_button")#.connect("pressed", on_options_pressed)
	options_button.connect("pressed", on_options_pressed)
	quit_button = get_node("main_menu_base/options_container/quit_game_button")#.connect("pressed", on_quit_game_pressed)
	quit_button.connect("pressed", on_quit_game_pressed)


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

func on_options_pressed():
	start_button.disabled = true
	options_button.disabled = true
	quit_button.disabled = true
	options_menu.show()

func on_options_menu_close():
	start_button.disabled = false
	options_button.disabled = false
	quit_button.disabled = false
	options_menu.hide()

