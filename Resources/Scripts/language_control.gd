class_name LanguageControl extends Control

var user_prefs : UserPreferences
signal _change_setting(setting, value)

@export var language_button : OptionButton
@export var font_button : CheckButton

var initial_language : int
var os_lang : int = -1
var intiial_dys : bool

var game_theme : Theme = preload("res://Resources/Localization/Theme/BasicTheme.tres")
var dyslexia_font : Font = preload("res://Resources/Localization/Theme/OpenDyslexic3-Regular.ttf")
var base_font : Font = preload("res://Resources/Localization/Theme/new_font_file.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	if(user_prefs == null):
		user_prefs = UserPreferences.load_or_create_prefs()

	Globals.connect("_reset_user_prefs", reset)
	Globals.connect("_intialize_user_prefs", initialize)

func set_translation(value:int):
	match value:
		0: 
			TranslationServer.set_locale("en")
		1: 
			TranslationServer.set_locale("es")
		2:
			TranslationServer.set_locale("de")
		3:
			TranslationServer.set_locale("fr")
		4:
			TranslationServer.set_locale("pt")

func _on_change_translation(index:int):
	set_translation(index)
	_change_setting.emit("language_setting",index)
 
func set_font(value:bool):
	if value:
		game_theme.set_font("font","Button",dyslexia_font)
		game_theme.set_font("font","Label",dyslexia_font)
		game_theme.default_font = dyslexia_font
	else:
		game_theme.set_font("font","Button",base_font)
		game_theme.set_font("font","Label",base_font)
		game_theme.default_font = base_font

func _on_change_font(value:bool):
	set_font(value)
	_change_setting.emit("dyslexic_setting", value)

func reset():
	set_translation(initial_language)
	language_button.selected = initial_language
	set_font(intiial_dys)
	font_button.button_pressed = intiial_dys

func initialize():
	check_intitial_region()
	font_button.button_pressed = user_prefs.dyslexic_setting
	intiial_dys = user_prefs.dyslexic_setting
	if os_lang >= 0 and os_lang < 5:
		if os_lang != user_prefs.language_setting:
			language_button.selected = user_prefs.language_setting
			initial_language = user_prefs.language_setting
			set_translation(user_prefs.language_setting)
		else:
			language_button.selected = os_lang
			initial_language = os_lang
			set_translation(os_lang)

func check_intitial_region():
	var get_os_lang = OS.get_locale_language()
	match get_os_lang:
		"en":
			os_lang = 0
		"es":
			os_lang = 1
		"de":
			os_lang = 2
		"fr":
			os_lang = 3
		"pt":
			os_lang = 4
		_:
			os_lang = -1
