extends StaticBody2D

onready var hitbox_armario = $Area2D
onready var player = get_node("../cadeirante")

func _input(event):
	#print(hitbox_armario.get_overlapping_areas())
	if event.is_action_pressed("space") and len(hitbox_armario.get_overlapping_areas()) > 0 and player.dialog_state == 2:
		find_and_use_dialogue()
		
func find_and_use_dialogue():
	var player_puzzle = get_node("Area2D/puzzle_cadeirante")
	player_puzzle.show_puzzle()
