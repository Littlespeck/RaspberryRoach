class_name AudioControl extends Control

signal _change_setting(setting, value)
var user_prefs : UserPreferences
@onready var MASTER_BUS_ID = AudioServer.get_bus_index("Master")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")

@export var master_slider : HSlider
@export var music_slider : HSlider
@export var sfx_slider : HSlider

func _ready():
	if (user_prefs == null):
		user_prefs = UserPreferences.load_or_create_prefs()

	master_slider.value = user_prefs.master_audio_level
	music_slider.value = user_prefs.music_audio_level
	sfx_slider.value = user_prefs.sfx_audio_level

func _on_sfx_slider_value_changed(value:float):
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(SFX_BUS_ID, value < .05)
	_change_setting.emit("sfx_audio_level",value)
	
	

func _on_music_slider_value_changed(value:float):
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MUSIC_BUS_ID, value < .05)
	_change_setting.emit("music_audio_level",value)


func _on_master_slider_value_changed(value:float):
	AudioServer.set_bus_volume_db(MASTER_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MASTER_BUS_ID, value < .05)
	_change_setting.emit("master_audio_level",value)

	
	
