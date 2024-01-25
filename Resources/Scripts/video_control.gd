class_name VideoControl extends Control

signal _change_setting(setting, value)
var Resolutions : Dictionary = {
	"720x1280":Vector2i(720,1280),
	"1080x1920":Vector2i(1080,1920),
	"1440x2160":Vector2i(1440,2160)
}
var initial_vsync : bool
var initial_framerate : int
var initial_screen_option : int
var user_prefs : UserPreferences

@onready var resolution_button = get_node("MarginContainer/VBoxContainer/resolution_option/ResolutionOptions")
@export var v_sync_button : CheckButton
@export var framerate_button : OptionButton
@export var fullscreen_button : OptionButton

func _ready():
	#_add_resolutions()
	if (user_prefs == null):
		user_prefs = UserPreferences.load_or_create_prefs()	
	Globals.connect("_reset_user_prefs", reset)
	Globals.connect("_intialize_user_prefs", initialize)

func initialize():
	_initialize_video_settings()

func reset():
	_set_screen_options(initial_screen_option)
	_set_max_framerate(initial_framerate)
	_set_vsync(initial_vsync)

func _add_resolutions():
	for r in Resolutions:
		resolution_button.add_item(r)

func _on_resolution_button_item_selected(index:int) -> void:
	var res = resolution_button.get_item_text(index)
	get_window().set_size(Resolutions[res])
	_center_screen()

func _on_screen_options_selected(index:int) -> void:
	_set_screen_options(index)
	_change_setting.emit("screen_option", index)

func _on_framerate_max_selected(index:int) -> void:
	_set_max_framerate(index)
	_change_setting.emit("max_framerate", index)

func _on_vsync_button_toggled(toggled_on:bool):
	_set_vsync(toggled_on)
	_change_setting.emit("v_sync", toggled_on)

func _center_screen():
	var center = DisplayServer.screen_get_position()+DisplayServer.screen_get_size()/2
	var window_size = get_window().get_size_with_decorations()
	get_window().set_position(center - window_size/2)

func _set_vsync(value:bool):
	if value:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

func _set_max_framerate(value:int):
	match value:
		0:
			Engine.set_max_fps(0)
		1:
			Engine.set_max_fps(30)
		2:
			Engine.set_max_fps(60)
		3:
			Engine.set_max_fps(90)
		4:
			Engine.set_max_fps(120)
		5:
			Engine.set_max_fps(144)

func _set_screen_options(value:int):
	match value:
		0:
			get_window().set_mode(Window.MODE_WINDOWED)
			_center_screen()	
		1:
			get_window().set_mode(Window.MODE_EXCLUSIVE_FULLSCREEN)
		2:
			get_window().set_mode(Window.MODE_FULLSCREEN)

func _initialize_video_settings():
	_set_max_framerate(user_prefs.max_framerate)
	_set_screen_options(user_prefs.screen_option)
	_set_vsync(user_prefs.v_sync)
	v_sync_button.button_pressed = user_prefs.v_sync
	initial_vsync = user_prefs.v_sync
	framerate_button.selected = user_prefs.max_framerate
	initial_framerate = user_prefs.max_framerate
	fullscreen_button.selected = user_prefs.screen_option
	initial_framerate = user_prefs.screen_option
