extends Area2D


func _on_body_entered(body: Node2D):
	if body.name == "Player":
		print("Fall out!")
		print("Restarting level...")
		get_tree().reload_current_scene()
