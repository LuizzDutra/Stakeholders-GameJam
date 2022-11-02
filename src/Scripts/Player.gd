extends KinematicBody2D

export(Resource) var data_player

onready var sprite = $AnimatedSprite

var sprite_path = "res://spriteFrames/spriteframe"

var dir = Vector2.ZERO
var vel = Vector2.ZERO
var speed = 175
var frict = 2400
var acel = 1200 + frict
var facing = -1
var stopped = false

var r_input = 0
var l_input = 0
var u_input = 0
var d_input = 0

var nome = "Gab"

var oculos: bool = false

func _ready():
	nome = data_player.get_data()["nome"]
	load_modulate()

func load_modulate():
	var r_data = data_player.get_data()
	sprite.frames = load(sprite_path + str(int(r_data["sprite_frame"]) + 1) + ".tres")


func _process(delta):
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

func _unhandled_input(event):
	if event.is_action("Right"):
		if event.is_pressed():
			r_input = 1
		else:
			r_input = 0
	if event.is_action("Left"):
		if event.is_pressed():
			l_input = 1
		else:
			l_input = 0
	
	if event.is_action("Up"):
		if event.is_pressed():
			u_input = 1
		else:
			u_input = 0
	if event.is_action("Down"):
		if event.is_pressed():
			d_input = 1
		else:
			d_input = 0
	
	dir.x = r_input - l_input
	dir.y = d_input - u_input
	


func set_active(n):
	dir = Vector2.ZERO
	r_input = 0
	l_input = 0 
	u_input = 0
	d_input = 0
	set_process_unhandled_input(n)
	
