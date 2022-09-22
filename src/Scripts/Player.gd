extends KinematicBody2D

export(Resource) var data_player

onready var sprite = $AnimatedSprite

var dir = Vector2.ZERO
var vel = Vector2.ZERO
var speed = 300
var frict = 2400
var acel = 1200 + frict
var facing = -1

var nome = "Gab"

var oculos: bool = false

func _ready():
	nome = data_player.get_data()["nome"]
	load_modulate()

func load_modulate():
	var r_data = data_player.get_data()
	#get_node("Sprites/Body").modulate = r_data["Body_color"]
	#get_node("Sprites/Hair").modulate = r_data["Hair_color"]
	#get_node("Sprites/Eyes").get_material().set_shader_param("modulate", r_data["Eyes_color"])


func _process(delta):
	#print(dir)
	dir.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	dir.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	
	if dir.x != 0:
		facing = dir.x
	
	vel += dir * acel * delta
	vel = vel.move_toward(Vector2.ZERO, frict * delta)
	vel = vel.limit_length(speed)
	
	if dir != Vector2.ZERO:
		sprite.play("walk")
	else:
		sprite.play("idle")
	sprite.scale.x = facing
	
	#print(vel)
	vel = move_and_slide(vel)
	
func set_active(active):
	set_physics_process(active)
	set_process(active)
	set_process_input(active)
