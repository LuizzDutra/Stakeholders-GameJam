extends Node2D

onready var game_scene = load("res://Scenes/Game.tscn")
onready var menu = $Menu
onready var player_data = $player_data

func _ready():
	menu.connect("info_saved", self, "_on_info_saved")

func start_game():
	var game = game_scene.instance()
	game.get_node("Player/Sprites/Body").modulate = player_data.Body_color
	game.connect("return_to_menu", self, "_on_return_to_menu")
	add_child(game)

func _on_info_saved(s_var, info):
	if player_data.get(s_var) != null:
		player_data.set(s_var, info)

func _on_return_to_menu():
	get_node("Game").queue_free()
	menu._ready()

func _on_Menu_start_game():
	start_game()
	menu.visible = false
