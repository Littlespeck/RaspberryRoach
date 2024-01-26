extends Area2D


func _on_body_entered(_body):
	get_parent().get_parent().platform_spread = get_parent().get_parent().platform_spread * .5
	get_parent().get_parent().Pup_Points += 200
	queue_free()
