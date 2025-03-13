extends Node2D

@onready var break_sound = $AudioStreamPlayer


func _on_body_entered(body: Node2D):
	if body.name == "Player" and (body.is_stomping or body.stomp_bounce):
		await _break()
		self.queue_free()


func _break():
	$Sprites.call_deferred("set_visible", false)
	$CollisionShape2D.call_deferred("set_disabled", true)

	break_sound.play()
	await break_sound.finished
