extends Area2D


func _on_body_entered(body):
	body.JUMP_VELOCITY -= 50.0
	queue_free()
