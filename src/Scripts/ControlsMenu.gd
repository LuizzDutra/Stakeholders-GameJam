extends Control

onready var inputADM = $InputADM

func _ready():
	pass


func _on_UpButton_my_pressed(my_action):
	inputADM.activate(my_action)


func _on_InputADM_action_edited(my_action, key_name):
	if my_action == "Up":
		get_node("Keys/Up/UpButton").text = key_name
