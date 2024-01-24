extends Control

signal toggle_options() #signal to toggle options menu on. 
signal _change_setting(setting, value) #callback from individual controls to change settings.
signal _initialize_options() #signal to tell individual controls to set themselves appropriately.

var isDirty : bool = false
var user_prefs : UserPreferences
@export var options_container : OptionsContainer

func _ready():
	connect("toggle_options", on_toggle_options)
	options_container.connect("_change_setting", on_change_setting)
	user_prefs = UserPreferences.load_or_create_prefs()
	options_container.user_prefs = user_prefs

func save_prefs():
	user_prefs.save()

func on_toggle_options():
	hide()

func on_change_setting(setting, value):
	if !isDirty:
			isDirty = true
	#print("Var Name: " + setting + ". Value: ")
	#print(value)
	print(user_prefs.get(setting))
	user_prefs.set(setting,value)
	print(user_prefs.get(setting))
	pass

func _on_toggle_options():		
	pass # Replace with function body.


