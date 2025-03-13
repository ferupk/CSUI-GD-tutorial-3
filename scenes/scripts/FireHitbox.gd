extends Area2D


func _on_body_entered(body: Node2D):
	if body.name == "Player":
		body.kill()
		await get_tree().create_timer(2.5).timeout
		get_tree().call_deferred("reload_current_scene")
