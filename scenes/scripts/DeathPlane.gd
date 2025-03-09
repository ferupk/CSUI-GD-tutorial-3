extends Area2D


func _on_body_entered(body: Node2D):
	if body.name == "Player":
		await body.kill()
		get_tree().reload_current_scene()
