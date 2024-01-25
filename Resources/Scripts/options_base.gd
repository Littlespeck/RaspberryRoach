extends Control

signal _toggle_options_menu(value:bool) #signal to toggle options menu on. 
signal _change_setting(setting, value) #callback from individual controls to change settings.
signal _toggle_menu()

var isDirty : bool = false
var user_prefs : UserPreferences
@export var options_container : OptionsContainer
@export var buttons_container : ButtonsContainer
@export var popup_menu : Node
@export var base_theme : Theme
@export var dyslexia_theme : Theme
#@onready var my_node = $options_base

func _ready():
	options_container.connect("_change_setting", on_change_setting)
	user_prefs = UserPreferences.load_or_create_prefs()
	options_container.user_prefs = user_prefs
	buttons_container._enable_buttons()
	_check_theme(user_prefs.dyslexic_setting)
	Globals._intialize_user_prefs.emit()

func save_prefs():
	user_prefs.save()
	isDirty = false
	if popup_menu.is_visible_in_tree():
		popup_menu.hide()
		buttons_container._enable_buttons()
		options_container._show_last_selected()

func _on_back_button_pressed():
	if isDirty:
		buttons_container._disable_buttons()
		options_container._disable_settings()
		popup_menu.show()
	else:
		_on_toggle_options()

func _on_popup_no():
	Globals._reset_user_prefs.emit()
	popup_menu.hide()
	buttons_container._enable_buttons()
	options_container._show_last_selected()
	isDirty = false
	_on_toggle_options()

func on_change_setting(setting, value):
	if !isDirty:
			isDirty = true
	user_prefs.set(setting,value)
	if(setting == "dyslexic_setting"):
		_check_theme(value)

func _check_theme(value:bool):
	if(value == true):
		set_theme(dyslexia_theme)
	elif(value == false):
		set_theme(base_theme)

func _reset_user_prefs():
	Globals._reset_user_prefs.emit()
	_check_theme(user_prefs.dyslexic_setting)

func _on_toggle_options():
	Globals._toggle_options_menu.emit()