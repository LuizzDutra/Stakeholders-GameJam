extends Node2D

onready var hitbox_lixeiro = $Area2D
onready var player = get_node("../YSort/Player")
var cont_lixeiro

func _ready():
	pass

func _input(event):
	
	if event.is_action_pressed("enter") and len(hitbox_lixeiro.get_overlapping_areas()) > 0:
		cont_lixeiro = player.cont_lixo
		print(cont_lixeiro)
