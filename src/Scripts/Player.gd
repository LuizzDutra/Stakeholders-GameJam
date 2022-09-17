extends KinematicBody2D

export(Resource) var data_player

var dir = Vector2.ZERO
var vel = Vector2.ZERO
var speed = 300
var frict = 2400
var acel = 1200 + frict
onready var eye = $Sprites/Eyes

func _ready():
	var data = data_player.get_data()
	get_node("Sprites/Body").modulate = data["Body_color"]
	get_node("Sprites/Hair").modulate = data["Hair_color"]
	get_node("Sprites/Eyes").get_material().set_shader_param("modulate", data["Eyes_color"])

func _process(delta):
	#print(dir)
	dir.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	dir.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	
	vel += dir * acel * delta
	vel = vel.move_toward(Vector2.ZERO, frict * delta)
	vel = vel.limit_length(speed)
	#print(vel)
	vel = move_and_slide(vel)
