extends Node2D

onready var audio = $AudioStreamPlayer2D

signal easter_start
signal easter_end

var interact_id = "prop"

func interact():
	if !audio.playing:
		audio.play()
		emit_signal("easter_start")
	


func _on_AudioStreamPlayer2D_finished():
	emit_signal("easter_end")
