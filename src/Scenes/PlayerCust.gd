extends Node2D

export(Resource) var data_player
onready var r_data = data_player.get_data()

func _ready():
	load_modulate()


func load_modulate():
	get_node("Body").modulate = r_data["Body_color"]
	get_node("Hair").modulate = r_data["Hair_color"]
	get_node("Eyes").get_material().set_shader_param("modulate", r_data["Eyes_color"])
