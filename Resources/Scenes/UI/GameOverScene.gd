extends Control

signal MainMenuPressed
signal PlayAagainPressed

func _on_main_menu_button_pressed():
	$".".MainMenuPressed.emit()

func _on_play_again_button_pressed():
	$".".PlayAagainPressed.emit()
