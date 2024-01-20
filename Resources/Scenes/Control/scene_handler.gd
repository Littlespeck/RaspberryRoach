extends Node

var score_table = []

func _ready():
	for i in Globals.high_score_table:
		score_table.append(Globals.high_score_table[i])
		
	
	load_main_menu()

func on_new_game_pressed():
	get_node("MainMenu").queue_free()
	var game_scene = load("res://Resources/Scenes/Control/game_scene.tscn").instantiate()
	add_child(game_scene)
	game_scene.connect("game_finished", unload_game)

func unload_game(score):
	get_node("GameScene").queue_free()
	score_table.append(score)
	score_table.sort_custom(descending_sort)
	score_table.remove_at(3)
	print(score_table)
	
	var main_menu = load("res://Resources/Scenes/Control/MainMenu.tscn").instantiate()
	add_child(main_menu)
	load_main_menu()

func load_main_menu():
	get_node("MainMenu/M/NewGame").connect("pressed", on_new_game_pressed)

func descending_sort(a, b):
	if a > b:
		return true
	return false
