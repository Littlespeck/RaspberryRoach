class_name AudioControl extends Control

signal _change_setting(setting, value)
var user_prefs : UserPreferences
@onready var MASTER_BUS_ID = AudioServer.get_bus_index("Master")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")

@export var master_slider : HSlider
@export var music_slider : HSlider
@export var sfx_slider : HSlider
var initial_master : float
var intial_music : float
var initial_sfx : float

func _ready():
	if (user_prefs == null):
		user_prefs = UserPreferences.load_or_create_prefs()

	initialize()

	Globals.connect("_reset_user_prefs", reset)
	Globals.connect("_intialize_user_prefs", initialize)

func _on_sfx_slider_value_changed(value:float):
	_set_audio_slider_level(value, "SFX")
	_change_setting.emit("sfx_audio_level",value)		

func _on_music_slider_value_changed(value:float):
	_set_audio_slider_level(value, "Music")
	_change_setting.emit("music_audio_level",value)

func _on_master_slider_value_changed(value:float):
	_set_audio_slider_level(value, "Master")
	_change_setting.emit("master_audio_level",value)

func _set_audio_slider_level(value: float, bus : String):
	match bus:
		"Master":
			AudioServer.set_bus_volume_db(MASTER_BUS_ID, linear_to_db(value))
			AudioServer.set_bus_mute(MASTER_BUS_ID, value < .05)
		"Music":
			AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))
			AudioServer.set_bus_mute(MUSIC_BUS_ID, value < .05)
		"SFX":
			AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
			AudioServer.set_bus_mute(SFX_BUS_ID, value < .05)

func reset():
	_set_audio_slider_level(initial_sfx, "SFX")
	_set_audio_slider_level(intial_music, "Music")
	_set_audio_slider_level(initial_master, "Master")
	master_slider.value = initial_master
	music_slider.value = intial_music
	sfx_slider.value = initial_sfx

func initialize():
	master_slider.value = user_prefs.master_audio_level
	initial_master = user_prefs.master_audio_level
	music_slider.value = user_prefs.music_audio_level
	intial_music = user_prefs.music_audio_level
	sfx_slider.value = user_prefs.sfx_audio_level
	initial_sfx = user_prefs.sfx_audio_level
	_set_audio_slider_level(initial_sfx, "SFX")
	_set_audio_slider_level(intial_music, "Music")
	_set_audio_slider_level(initial_master, "Master")
