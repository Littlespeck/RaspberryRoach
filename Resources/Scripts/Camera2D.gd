extends Camera2D


func _process(delta):
	if get_parent().player_character.get_node("Roach PC").velocity.y < 0:
		position.y = get_parent().player_character.get_node("Roach PC").position.y
