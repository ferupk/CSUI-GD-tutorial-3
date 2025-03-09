extends Node2D

var default_bgm = load("res://assets/sounds/bgm.ogg")


func _ready() -> void:
	$BGM.stream = default_bgm


func play() -> void:
	$BGM.play()
