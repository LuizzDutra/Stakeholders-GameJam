extends Button


var action = "Up"

signal my_pressed(my_action, buttonRef)

func _pressed():
	emit_signal("my_pressed", action, self)
