extends Node2D

const FADE_TRANS = Tween.TRANS_SINE
const FADE_DURATION = 1

@export var target_level = 1
@export var last = false

@onready var fade_out_tween: Tween
@onready var sfx = {
	"Hum": $SFX/Hum,
	"Win": $SFX/Win,
}


func _on_area_2d_body_entered(body: Node2D):
	if body.name == "Player":
		body.win()
		sfx.Win.play()
		_end_hum()
		await get_tree().create_timer(3.5).timeout

		if last:
			get_tree().call_deferred("change_scene_to_file", "res://scenes/levels/End.tscn")
		else:
			get_tree().call_deferred(
				"change_scene_to_file", "res://scenes/levels/Level%s.tscn" % target_level
			)


func _end_hum():
	fade_out_tween = create_tween()
	fade_out_tween.tween_property(sfx.Hum, "volume_db", -80, FADE_TRANS).set_trans(FADE_TRANS)

	await fade_out_tween.finished
	sfx.Hum.stop()
