extends Control

onready var bodyPicker = $bodyPicker
onready var sprites = $Sprites

signal info_saved(s_var, color)

func _ready():
	bodyPicker.color = sprites.get_node("Body").modulate

func save_color_info(color, s_var):
	emit_signal("info_saved", s_var + "_color", color)
	
func _on_bodyPicker_color_changed(color):
	sprites.get_node("Body").modulate = color
	save_color_info(color, "Body")
