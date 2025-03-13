extends Node2D

@export var target_level = 1


func _on_area_2d_body_entered(body: Node2D):
	if body.name == "Player":
		body.win()
		await get_tree().create_timer(3.5).timeout
		get_tree().call_deferred(
			"change_scene_to_file", "res://scenes/levels/Level%s.tscn" % target_level
		)
