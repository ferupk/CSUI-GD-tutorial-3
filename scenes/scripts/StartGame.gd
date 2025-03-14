extends TextureButton


func _on_pressed() -> void:
	BackgroundMusicControl.play()
	get_tree().call_deferred("change_scene_to_file", "res://scenes/levels/Level1.tscn")
