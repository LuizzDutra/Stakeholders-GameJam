extends Node2D

onready var game_scene = load("res://Scenes/Game.tscn")
onready var menu = $Menu


func start_game():
	var game = game_scene.instance()
	var file = File.new()
	file.open("res://data/player_color/Body.txt", File.READ)
	game.get_node("Player/Sprites/Body").modulate = file.get_var()
	add_child(game)
	file.close()

func _on_Menu_start_game():
	start_game()
	menu.visible = false
