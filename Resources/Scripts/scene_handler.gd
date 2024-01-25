extends Node

signal MainMenuPressed
signal PlayAagainPressed

var score_table = []
var GameOver = false

@export var control_root : Node
var start_button : Button
var options_button : Button
var quit_button : Button
signal _on_toggle_options(bool)
@onready var game_over_scene = preload("res://Resources/Scenes/UI/GameOverScene.tscn")
var options_menu = preload("res://Resources/Scenes/UI/options_base.tscn").instantiate()

func _ready():
	Globals.connect("_toggle_options_menu",on_options_menu_close)
	for i in Globals.high_score_table:
		score_table.append(Globals.high_score_table[i])
	
	load_options_menu()
	load_main_menu()
	#PlayAagainPressed.connect()

func _physics_process(delta):
	if GameOver:
		get_node("GameOverScene").connect("MainMenuPressed", _on_main_menu_button_pressed)
		GameOver = false

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

func unload_game(score):
	get_node("GameScene").queue_free()
	$Munch.play()
	score_table.append(score)
	score_table.sort_custom(descending_sort)
	score_table.remove_at(3)
	print(score_table)
	GameOver = true
	
	var game_over_scene = load("res://Resources/Scenes/UI/GameOverScene.tscn").instantiate()
	add_child(game_over_scene)

func _on_main_menu_button_pressed():
	get_node("GameOverScene").queue_free()
	var main_menu = load("res://Resources/Scenes/UI/main_menu_base.tscn").instantiate()
	add_child(main_menu)
	load_main_menu()

func descending_sort(a, b):
	if a > b:
		return true
	return false


