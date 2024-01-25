extends Control

signal MainMenuPressed
signal PlayAagainPressed

@onready var score = self.get_parent().score
@onready var ScoreLabel = $CanvasLayer/Control/ScoreLabel


func _physics_process(delta):
	ScoreLabel.text = str(score)

func _on_main_menu_button_pressed():
	$".".MainMenuPressed.emit()

func _on_play_again_button_pressed():
	$".".PlayAagainPressed.emit()

