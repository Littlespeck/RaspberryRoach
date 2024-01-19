extends Node

signal toggle_options()
signal toggle_menu()

func _ready():
	pass

func _on_quit_game_button_button_down():
	get_tree().quit();

func _on_options_menu_button_button_down():
	_on_toggle_menu()

func _on_start_game_button_button_down():
	pass # Replace with function body.

func _on_toggle_menu():
	pass
