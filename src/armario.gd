extends StaticBody2D

onready var hitbox_armario = $Area2D
onready var player = get_node("../unity")
onready var jogo = get_node("../../")
var interact_id = "quest"

func interact():
	var player_puzzle = get_node("Area2D/puzzle_luiza")
	if player.dialog_state == 3 and not player_puzzle.puzzle.visible:
		find_and_use_dialogue()

		
func find_and_use_dialogue():
	var player_puzzle = get_node("Area2D/puzzle_luiza")
	#print("Olá mano")
	player_puzzle.show_puzzle()
