extends Node

signal toggle_options()
signal toggle_menu()

func _ready():
	pass

func _on_options_menu_button_button_down():
	_on_toggle_menu()

func _on_toggle_menu():
	emit_signal("toggle_options")
	
