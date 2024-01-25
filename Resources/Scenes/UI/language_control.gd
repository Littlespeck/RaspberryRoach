class_name LanguageControl extends Control

var user_prefs : UserPreferences
signal _change_setting(setting, value)

@export var language_button : OptionButton
@export var font_button : CheckButton

# Called when the node enters the scene tree for the first time.
func _ready():
	if(user_prefs == null):
		user_prefs = UserPreferences.load_or_create_prefs()
	
	set_translation(user_prefs.language_setting)
	language_button.selected = user_prefs.language_setting
	font_button.button_pressed = user_prefs.dyslexic_setting


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

func _on_change_font(value:bool):
	_change_setting.emit("dyslexic_setting", value)
	
