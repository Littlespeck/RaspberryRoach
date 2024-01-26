extends Area2D


func _on_body_entered(body):
	get_parent().get_parent().platform_spread -= 20
	queue_free()
