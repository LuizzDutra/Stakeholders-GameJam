extends Resource
class_name DataRes

export var data :Dictionary = {"Body_color": Color(0.84375,0.681566, 0.551361), "Hair_color": Color(0.371094, 0.204989, 0.10532),
			 "Eyes_color": Color(0.301052, 0.423398, 0.65625), "sprite_frame": 0, "nome": "Gab"}

var def_data: Dictionary

func _init():
	def_data = data

func reset_to_default():
	#duplicate não uso o mesmo endereço na memória
	#sem o duplicate não iria funcionar
	data = def_data.duplicate()

func get_data():
	return data

func get_default():
	return def_data
