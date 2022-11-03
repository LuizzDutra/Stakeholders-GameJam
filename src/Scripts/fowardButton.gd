extends Button


var action = "Up"

signal my_pressed(my_action)

func _pressed():
	emit_signal("my_pressed", action)
