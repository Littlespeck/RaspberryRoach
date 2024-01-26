extends Area2D


func _on_body_entered(body):
	body.velocity.y -= 1200
	get_parent().get_parent().Pup_Points += 50
	queue_free()
