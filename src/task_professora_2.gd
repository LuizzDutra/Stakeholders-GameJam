extends Node2D

var pos_x_constante = 278
var pixel_space = 64
onready var is_self = $"."
onready var mesas = get_node("../mesas")
onready var prof = get_node("../../Professora")

func _ready():
	print(is_self.get_children())

func iniciar_task():
	draw_circle_blue(-463)
	draw_circle_blue(-339)

func draw_circle_blue(y):
	
	for i in range(0,8):
		var c = load("res://circulo_azul.tscn").instance()
		c.position.x = pos_x_constante + pixel_space * i
		c.position.y = y
		is_self.add_child(c)

func maker_mesa(y):
	
	for r in range(0,16):
		var m = load("res://Scenes/mesaEmpurr.tscn").instance()
		
		m.position.x = 161 + 32 * r
		m.position.y = y
		
		mesas.add_child(m)

func clear_mesa():
	
	for i in mesas.get_children():
		mesas.remove_child(i)

func monitorar_circulo():
	for r in is_self.get_children():
		if len(r.hitbox_circulo.get_overlapping_areas()) > 0:
			r.visible = false
		else:
			r.visible = true

func _physics_process(delta):
	monitorar_circulo()
	

func is_cadeiras_organizadas():
	
	if len(is_self.get_children()) == 0:
		return
		
	for i in is_self.get_children():
		print(i)
		if i.visible == true:
			return false
		else:
			pass
	
	return true

func circle_blue_clear():
	
	for r in is_self.get_children():
		is_self.remove_child(r)
