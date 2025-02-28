extends Node2D

@export var target_level = 1


func _on_area_2d_body_entered(body: Node2D):
	if body.name == "Player":
		print("Level complete!")
		print("Loading next level...")
		get_tree().change_scene_to_file("res://scenes/levels/Level%s.tscn" % target_level)
