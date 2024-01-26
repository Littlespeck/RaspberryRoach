extends Area2D


func _on_body_entered(body):
	body.JUMP_VELOCITY -= 30.0
	queue_free()
