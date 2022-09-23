extends Area2D

onready var sound_effect = $AudioStreamPlayer

signal oculos_catch()
func _ready():
	pass


func _on_oculos_body_entered(body):
	
	if body.is_in_group("player") and visible:
		body.oculos = true
		emit_signal("oculos_catch")
		visible = false
		sound_effect.play()
		


func _on_AudioStreamPlayer_finished():
	queue_free()
