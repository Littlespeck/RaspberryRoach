extends Node2D

signal game_finished(result)

var map_node

func _ready():
	map_node = load("res://Resources/Scenes/Maps/map_1.tscn").instantiate
	add_child(map_node)
