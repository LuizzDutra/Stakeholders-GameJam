extends Control
onready var bodyPicker = $bodyPicker
onready var sprites = $Sprites
onready var metadata = load("res://data/player_metadata.tres")

func _ready():
	bodyPicker.color = sprites.get_node("Body").modulate
	save_color_info(bodyPicker.color, "Body")


func save_color_info(n, part):
	var file = File.new()
	file.open("res://data/player_color/" + part + ".txt", File.WRITE)
	file.store_var(n)
	file.close()

func _on_bodyPicker_color_changed(color):
	sprites.get_node("Body").modulate = color
	save_color_info(color, "Body")
