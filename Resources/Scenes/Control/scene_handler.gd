extends Node

@export var control_root : Node

var main_menu = preload("res://Resources/Scenes/UI/main_menu_base.tscn").instantiate()
var options_menu = preload("res://Resources/Scenes/UI/options_base.tscn").instantiate()

func _ready():
	#load_options_menu()
	load_main_menu()
	

func load_options_menu():
	get_tree().root.add_child.call_deferred(options_menu)


func load_main_menu():
	get_tree().root.add_child.call_deferred(main_menu)

