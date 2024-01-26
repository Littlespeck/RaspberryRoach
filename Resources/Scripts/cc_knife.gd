extends Node2D

signal PlayerDied

@onready var game_scene = self.get_parent()

func _ready():
	pass

func _on_area_2d_body_entered(body):
	if game_scene != null:
		var score = game_scene.score
		var BodyName = body.get_name()
		if  BodyName == str("Roach PC"):
			PlayerDied.emit(score)
			body.queue_free()
		body.queue_free()
