extends Resource
class_name DataRes

var def_data := {"Body_color": Color(0.84375,0.681566, 0.551361), "Hair_color": Color(0.371094, 0.204989, 0.10532),
			 "Eyes_color": Color(0.301052, 0.423398, 0.65625), "Body_frame": 0, "Shirt_frame": 0,
			 "Pants_frame": 0, "Hair_frame": 0, "Eyes_frame": 0}

export var data :Dictionary = def_data

func get_data():
	return data

func get_default():
	return def_data
	#print(data)