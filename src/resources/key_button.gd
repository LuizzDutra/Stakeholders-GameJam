extends Button
class_name KeyButton

export var action = ""

signal my_pressed(my_action, buttonRef)

func _pressed():
	emit_signal("my_pressed", action, self)
