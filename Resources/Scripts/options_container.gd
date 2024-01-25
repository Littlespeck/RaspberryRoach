class_name  OptionsContainer extends PanelContainer

@onready var user_prefs : UserPreferences
signal _change_setting(setting, value)

@export var audio_control_node : Node
@export var audio_control : AudioControl
@export var video_control_node : Node
@export var video_control : VideoControl
@export var language_control_node : Node
@export var language_control : LanguageControl
@export var keybind_control_node : Node
@export var reset_control_node : Node

var last_pressed : int

# Called when the node enters the scene tree for the first time.
func _ready():
	_hide_all_options()
	audio_control.connect("_change_setting", on_setting_changed)
	video_control.connect("_change_setting", on_setting_changed)
	language_control.connect("_change_setting", on_setting_changed)
	last_pressed = -1

func on_setting_changed(setting, value):
	_change_setting.emit(setting, value)

func _hide_all_options():
	audio_control_node.hide()
	video_control_node.hide()
	language_control_node.hide()
	keybind_control_node.hide()
	reset_control_node.hide()
	
func _on_keybind_button_down():
	_hide_all_options()
	keybind_control_node.show()
	last_pressed = 3

func _on_audio_button_down():
	_hide_all_options()
	audio_control_node.show()
	last_pressed = 2

func _on_video_button_down():
	_hide_all_options()
	video_control_node.show()
	last_pressed = 1

func _on_language_button_down():
	_hide_all_options()
	language_control_node.show()
	last_pressed = 0

func _show_last_selected():
	match last_pressed:
		0:
			language_control_node.show()
		1:
			video_control_node.show()
		2:
			audio_control_node.show()
		3:
			keybind_control_node.show()

func _disable_settings():
	_hide_all_options()
	
		
