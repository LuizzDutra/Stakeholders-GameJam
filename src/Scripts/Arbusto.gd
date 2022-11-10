extends Sprite



func _ready():
	get_material().set_shader_param("strengthScale", 50 + randi() % 50)
