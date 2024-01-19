extends Control

signal toggle_options()

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("toggle_options", on_toggle_options)

func on_toggle_options():
	hide()

func _on_toggle_options():
	pass # Replace with function body.
