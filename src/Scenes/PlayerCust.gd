extends Node2D

export(Resource) var data_player

func _ready():
	load_modulate()

func load_modulate():
	var r_data = data_player.get_data()
	print(r_data)
	get_node("Body").modulate = r_data["Body_color"]
	get_node("Hair").modulate = r_data["Hair_color"]
	get_node("Eyes").get_material().set_shader_param("modulate", r_data["Eyes_color"])
