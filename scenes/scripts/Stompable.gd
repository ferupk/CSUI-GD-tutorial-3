extends Node2D

@onready var break_sound = $AudioStreamPlayer


func _on_body_entered(body: Node2D):
	if body.name == "Player" and (body.is_stomping or body.stomp_bounce):
		await _break()
		self.queue_free()


func _break():
	$CollisionShape2D.call_deferred("set_disabled", true)

	for sprite in $Sprites.get_children():
		sprite.play("Break")

	break_sound.play()
	await break_sound.finished
