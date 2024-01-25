class_name ButtonsContainer extends VBoxContainer

@export var language_button : Button
@export var video_button : Button
@export var audio_button : Button
@export var keybind_button : Button

func _ready():
	pass # Replace with function body.

func _disable_buttons():
	language_button.disabled = true
	video_button.disabled = true
	audio_button.disabled = true
	keybind_button.disabled = true

func _enable_buttons():
	language_button.disabled = false
	video_button.disabled = false
	audio_button.disabled = false
	keybind_button.disabled = false

