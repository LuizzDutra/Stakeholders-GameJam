extends KinematicBody2D

var dialog_npc_esp = [
	{"name":"Luiza","text":"Olá meu nome é Luiza"},
	{"name":"Luiza","text":"Isso é apenas um teste"},
	{"name":"Luiza","text":"Bye,bye meu amigo"}
]

onready var hitbox_npc_spc = $Area2D

func _input(event):
	if event.is_action_pressed("space") and len(hitbox_npc_spc.get_overlapping_bodies()) > 0:
		find_and_use_dialogue()
		
func find_and_use_dialogue():
	var dialogue_player = get_node_or_null("Area2D/dialogo")
	if dialogue_player:
		dialogue_player.play_dialog(dialog_npc_esp)
