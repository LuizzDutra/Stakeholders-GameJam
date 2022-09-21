extends Area2D

signal oculos_catch()
func _ready():
	pass


func _on_oculos_body_entered(body):
	
	if body.is_in_group("player"):
		body.oculos = true
		emit_signal("oculos_catch")
		queue_free()
