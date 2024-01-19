extends PanelContainer

@export var audio_control : Node
@export var video_control : Node
@export var language_control : Node
@export var keybind_control : Node
@export var reset_control : Node

# Called when the node enters the scene tree for the first time.
func _ready():
	_hide_all_options();

func _hide_all_options():
	audio_control.hide();
	video_control.hide();
	language_control.hide();
	keybind_control.hide();
	reset_control.hide();
	
func _on_keybind_button_down():
	_hide_all_options();
	keybind_control.show();

func _on_audio_button_down():
	_hide_all_options();
	audio_control.show();

func _on_video_button_down():
	_hide_all_options();
	video_control.show();

func _on_language_button_down():
	_hide_all_options();
	language_control.show();

func _change_resolution():
	pass
