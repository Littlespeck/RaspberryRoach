extends Control

@export var pri_jump : Button
@export var sec_jump : Button
@export var pri_left : Button
@export var sec_left : Button
@export var pri_right : Button
@export var sec_right : Button

var listen_text : String = "Listening..."

# Called when the node enters the scene tree for the first time.
func _ready():
	initialize()

func map_input():
	pass

func reset():
	pass

func initialize():
	pri_jump.text = InputMap.action_get_events("Jump")[0].as_text()
	pri_left.text = InputMap.action_get_events("Move_Left")[0].as_text()
	sec_left.text = InputMap.action_get_events("Move_Left")[1].as_text()
	pri_right.text = InputMap.action_get_events("Move_Right")[0].as_text()
	sec_right.text = InputMap.action_get_events("Move_Right")[1].as_text()