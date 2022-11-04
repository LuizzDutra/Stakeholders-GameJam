extends Control

onready var inputADM = $InputADM
onready var but = $Keys/Up/UpButton

func _ready():
	#but.add_color_override()
	pass


func _on_UpButton_my_pressed(my_action, buttonRef):
	inputADM.activate(my_action, buttonRef)

