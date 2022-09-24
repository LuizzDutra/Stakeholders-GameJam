extends KinematicBody2D

export(Resource) var data_player

onready var sprite = $AnimatedSprite

var sprite_path = "res://spriteFrames/spriteframe"

var dir = Vector2.ZERO
var vel = Vector2.ZERO
var speed = 300
var frict = 2400
var acel = 1200 + frict
var facing = -1
var stopped = false
var ativo = true

var nome = "Gab"

var oculos: bool = false

func _ready():
	nome = data_player.get_data()["nome"]
	load_modulate()

func load_modulate():
	var r_data = data_player.get_data()
	sprite.frames = load(sprite_path + str(int(r_data["sprite_frame"]) + 1) + ".tres")


func _process(delta):
	#print(dir)
	dir.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	dir.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	
	if stopped:
		print("yes")
		dir = Vector2.ZERO
	
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
	if not active:
		sprite.play("idle")
	ativo = active
	set_physics_process(active)
	set_process(active)
	set_process_input(active)
