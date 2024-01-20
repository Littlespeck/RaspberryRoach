extends Node

func _ready():
	load_main_menu()

func on_new_game_pressed():
	get_node("MainMenu").queue_free()
	var game_scene = load("res://Resources/Scenes/Control/game_scene.tscn").instantiate()
	add_child(game_scene)
	game_scene.connect("game_finished", unload_game)

func unload_game(score):
	get_node("GameScene").queue_free()
	var main_menu = load("res://Resources/Scenes/Control/MainMenu.tscn").instantiate()
	add_child(main_menu)
	load_main_menu()

func load_main_menu():
	get_node("MainMenu/M/NewGame").connect("pressed", on_new_game_pressed)
