class_name  OptionsContainer extends PanelContainer

@onready var user_prefs : UserPreferences
signal _change_setting(setting, value)

@export var audio_control_node : Node
@export var audio_control : AudioControl
@export var video_control_node : Node
@export var video_control : VideoControl
@export var language_control_node : Node
@export var keybind_control_node : Node
@export var reset_control_node : Node

# Called when the node enters the scene tree for the first time.
func _ready():
	_hide_all_options();
	audio_control.connect("_change_setting", on_setting_changed)
	video_control.connect("_change_setting", on_setting_changed)

func on_setting_changed(setting, value):
	_change_setting.emit(setting, value)

func _hide_all_options():
	audio_control_node.hide();
	video_control_node.hide();
	language_control_node.hide();
	keybind_control_node.hide();
	reset_control_node.hide();
	
func _on_keybind_button_down():
	_hide_all_options();
	keybind_control_node.show();

func _on_audio_button_down():
	_hide_all_options();
	audio_control_node.show();

func _on_video_button_down():
	_hide_all_options();
	video_control_node.show();

func _on_language_button_down():
	_hide_all_options();
	language_control_node.show();
