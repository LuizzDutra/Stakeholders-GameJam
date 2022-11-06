extends Node2D

onready var hitbox_lixeiro = $Area2D
onready var player = get_node("../YSort/Player")
onready var task_zelador = get_node("../zelador/task_zelador")
var cont_lixeiro

func _ready():
	pass

func _input(event):
	
	if event.is_action_pressed("enter") and len(hitbox_lixeiro.get_overlapping_areas()) > 0 and task_zelador.zelado.dialog_state == 1:
		
		print("aaaaa")
		cont_lixeiro = player.cont_lixo
		
		if cont_lixeiro >= 5:
			task_zelador.zelado.dialog_state = 2
