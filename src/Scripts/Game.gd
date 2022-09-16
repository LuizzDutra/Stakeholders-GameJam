extends Node2D

signal return_to_menu

func _process(delta):
	if Input.is_action_just_pressed("Return"):
		emit_signal("return_to_menu")
