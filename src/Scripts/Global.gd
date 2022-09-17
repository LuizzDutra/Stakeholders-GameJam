extends Node2D

onready var game_scene = load("res://Scenes/Game.tscn")
onready var menu = $Menu
onready var player_data = load("res://resources/data_cust.tres")
onready var daltonic_canvas = get_node("daltonicCanvas")
var sprite_color_parts = ["Body", "Hair", "Eyes"]
var sprite_frame_parts = ["Body", "Hair", "Eyes", "Pants", "Shirt"]

func _ready():
	menu.connect("info_saved", self, "_on_info_saved")

func start_game():
	var game = game_scene.instance()
	game.connect("return_to_menu", self, "_on_return_to_menu")
	add_child(game)

func _on_info_saved(s_var, info):
	if player_data.data.has(s_var):
		player_data.data[s_var] = info

func _on_return_to_menu():
	get_node("Game").queue_free()
	menu._ready()

func _on_Menu_start_game():
	start_game()
	menu.visible = false


func _on_Menu_daltonic_change(index):
	if index == -1:
		daltonic_canvas.visible = false
	else:
		daltonic_canvas.visible = true
		
	daltonic_canvas.get_node("BackBufferCopy/Sprite")\
	.get_material().set_shader_param("mode", index)


func _on_Menu_dalt_int_change(value):
	daltonic_canvas.get_node("BackBufferCopy/Sprite")\
	.get_material().set_shader_param("intensity", value)
