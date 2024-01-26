extends Area2D


func _on_body_entered(body):
	body.JUMP_VELOCITY -= 30.0
	get_parent().get_parent().Pup_Points += 200
	queue_free()
