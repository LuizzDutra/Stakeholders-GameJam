extends Node2D

onready var game_scene = load("res://Scenes/Game.tscn")
onready var cutscene_scene = load("res://Scenes/Cutscene.tscn")
onready var menu = $CanvasLayer/Menu
onready var player_data = load("res://resources/data_cust.tres")
onready var daltonic_canvas = get_node("daltonicCanvas")
onready var credits = $credits
var sprite_color_parts = ["Body", "Hair", "Eyes"]
var sprite_frame_parts = ["Body", "Hair", "Eyes", "Pants", "Shirt"]
var cutscene_active = false


func _ready():
	menu.connect("info_saved", self, "_on_info_saved")
	
	"""
	var test_key = InputEventKey.new()
	test_key.physical_scancode = KEY_J
	InputMap.action_add_event("Right", test_key)
	
	var a :Array = []
	for i in InputMap.get_actions():
		a = []
		for j in InputMap.get_action_list(i):
			a.append(j.as_text())
		print(a)
	"""

"""
func _input(event):
	if event is InputEventKey:
		if event.is_pressed():
			print(event.as_text())
			if get_input_state == true:
				InputMap.action_add_event("Right", event)
				get_input_state = false
"""


func start_cutscene():
	var cutscene = cutscene_scene.instance()
	cutscene_active = true
	cutscene.connect("cutscene_end", self, "_on_cutscene_end")
	add_child(cutscene)

func start_game():
	var game = game_scene.instance()
	cutscene_active = false
	game.connect("return_to_menu", self, "_on_return_to_menu")
	game.connect("credits", self, "_on_credits")
	call_deferred("add_child", game)

func _on_info_saved(s_var, info):
	if player_data.data.has(s_var):
		player_data.data[s_var] = info

func _on_return_to_menu(n):
	get_node("Game").queue_free()
	if n:
		menu.Musica_default.play()
	else:
		get_node("AudioStreamPlayer").play()
	menu._ready()

func _on_Menu_start_game():
	start_cutscene()
	menu.Musica_default.stop()
	menu.musica_loop.stop()
	menu.visible = false


func _on_Menu_daltonic_change(index):
	if index == -1:
		daltonic_canvas.visible = false
	else:
		daltonic_canvas.visible = true
		
	daltonic_canvas.get_node("BackBufferCopy/Sprite")\
	.get_material().set_shader_param("mode", index)

func _on_cutscene_end():
	get_node("Cutscene").queue_free()
	start_game()

func _on_Menu_dalt_int_change(value):
	daltonic_canvas.get_node("BackBufferCopy/Sprite")\
	.get_material().set_shader_param("intensity", value)
	
func _on_credits():
	get_node("Game").queue_free()
	credits.visible = true
	menu.visible = false
	get_node("brega").play()
	
