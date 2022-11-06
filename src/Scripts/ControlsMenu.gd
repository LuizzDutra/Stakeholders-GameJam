extends Control

onready var inputADM = $InputADM
onready var button_list = [$Keys/Up/UpButton, $Keys/Down/DownButton, $Keys/Left/LeftButton, $Keys/Right/RightButton]

func _ready():
	print(button_list)
	pass


func _on_UpButton_my_pressed(my_action, buttonRef):
	inputADM.activate(my_action, buttonRef)
	
func _on_DownButton_my_pressed(my_action, buttonRef):
	inputADM.activate(my_action, buttonRef)


func _on_InputADM_action_edited():
	for i in InputMap.get_actions():
		for key in InputMap.get_action_list(i):
			if key.get("physical_scancode"):
				var check_return = check_comp(key)
				if check_return[0]:
					for act in check_return[1]:
						var but = get_button_by_action(act)
						if but != null:
							but.remove_color_override("font_color")
							but.remove_color_override("font_color_hover")
				else:
					for act in check_return[1]:
						var but = get_button_by_action(act)
						if but != null:
							but.add_color_override("font_color", Color(1,0,0))
							but.add_color_override("font_color_hover", Color(0.8,0,0))
					

func get_button_by_action(action):
	for but in button_list:
		if but.get("action") == action:
			return but
	return null

func check_comp(key):
	var count = 0
	var actions = []
	for i in InputMap.get_actions():
		for j in InputMap.get_action_list(i):
			if j.get("physical_scancode"):
				if j.physical_scancode == key.physical_scancode:
					count += 1
					actions.append(i)
	if count > 1:
		return [false, actions]
	else:
		return [true, actions]





func _on_LeftButton_my_pressed(my_action, buttonRef):
	inputADM.activate(my_action, buttonRef)


func _on_RightButton_my_pressed(my_action, buttonRef):
	inputADM.activate(my_action, buttonRef)
