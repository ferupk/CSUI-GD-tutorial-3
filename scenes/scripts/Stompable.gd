extends Area2D


func _on_body_entered(body: Node2D):
	if body.name == "Player" and (body.isStomping or body.stompBounce):
		self.queue_free()
