extends KinematicBody2D

export(Resource) var data_player

onready var sprite = $AnimatedSprite
onready var area = $Area2D

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

var cont_lixo = 0

var quests = []
var quest_npcs = []
var npcs = []

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

func _input(event):
	if event.is_action("space"):
		if event.is_pressed():
			search_interact()

func search_interact():
	var areas = area.get_overlapping_areas()
	
	if len(areas) > 0:
		for i in areas:
			var parent = i.get_parent()
			if parent != null:
				if parent.get("interact_id") and parent.has_method("interact"):
					var int_id = parent.interact_id
					if int_id == "npc":
						npcs.append(parent)
					if int_id == "quest_npc":
						quest_npcs.append(parent)
					if int_id == "quest":
						quests.append(parent)
					
					if len(quests) > 0:
						quests[0].interact()
					elif len(quest_npcs) > 0:
						quest_npcs[0].interact()
					elif len(npcs) > 0:
						npcs[0].interact()
					else:
						pass
	npcs = []
	quests = []
	quest_npcs = []
			


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
	
	
