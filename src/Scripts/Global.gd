extends Node2D

onready var game_scene = load("res://Scenes/Game.tscn")
onready var menu = $Menu
onready var player_data = $player_data
var sprite_color_parts = ["Body", "Hair", "Eyes"]
var sprite_frame_parts = ["Body", "Hair", "Eyes", "Pants", "Shirt"]

func _ready():
	menu.connect("info_saved", self, "_on_info_saved")

func start_game():
	var game = game_scene.instance()
	#carrega a informação da cor do Player
	for i in range(len(sprite_color_parts)):
		var body_part = game.get_node("Player/Sprites/" + sprite_color_parts[i])
		var color_part = player_data.data[sprite_color_parts[i] + "_color"]
		#checka se o shader tem modulate próprio
		if body_part.get_material() != null:
			if body_part.get_material().get_shader_param("modulate") != null:
				body_part.get_material().set_shader_param("modulate", color_part)
			else:
				body_part.modulate = color_part
		else:
			body_part.modulate = color_part
	
	game.connect("return_to_menu", self, "_on_return_to_menu")
	add_child(game)

func _on_info_saved(s_var, info):
	print(info)
	if player_data.data.has(s_var):
		player_data.data[s_var] = info

func _on_return_to_menu():
	get_node("Game").queue_free()
	menu._ready()

func _on_Menu_start_game():
	start_game()
	menu.visible = false
