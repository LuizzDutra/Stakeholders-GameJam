extends Node2D

onready var hitbox_lixeiro = $Area2D
onready var player = get_node("../../Player")
onready var task_zelador = get_node("../../zelador/task_zelador")
var cont_lixeiro
var interact_id = "quest"

func _ready():
	pass

func interact():
	
	if task_zelador.zelado.dialog_state == 3:
		cont_lixeiro = player.cont_lixo
		if cont_lixeiro >= 5:
			task_zelador.zelado.dialog_state = 4
