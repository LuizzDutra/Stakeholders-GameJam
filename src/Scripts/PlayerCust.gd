extends "res://Scripts/player_data.gd"
#carrega a configuração default do player_data.gd
func _ready():
	$Hair.modulate = data["Hair_color"]
	$Body.modulate = data["Body_color"]
	#$Eyes.modulate = data["Eyes_color"]
