extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player.win()
	await get_tree().create_timer(5).timeout
	BackgroundMusicControl.stop()
	get_tree().call_deferred("change_scene_to_file", "res://scenes/levels/Start.tscn")
