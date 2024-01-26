extends Area2D


func _on_body_entered(body):
	get_parent().get_node("CCKnife").position.y += 200
	queue_free()
