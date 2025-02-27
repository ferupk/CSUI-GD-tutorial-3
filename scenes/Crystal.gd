extends Area2D

@export var targetLevel = 1

func _on_body_entered(body: Node2D):
	if body.name == "Player":
		print("Level complete!")
		print("Loading next level...")
		get_tree().change_scene_to_file("res://scenes/levels/Level%s.tscn" % targetLevel)
