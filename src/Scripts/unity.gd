extends KinematicBody2D

var dialog_npc_spc_base = [
	
	{"name":"Luiza","text":"olá meu nome é Luiza"},
	{"name":"Luiza", "text":"Vc poderia achar meus oculos perdido pfv"}
]

var dialog_npc_spc_missao_concluida = [
	{"name":"Luiza","text":"muito obrigago garoto"},
	{"name":"Luiza","text":"agora eu vou volta para a sala de aula"},
	{"name":"Luiza","text":"Tenha uma boa aula"}
]

var dialog_npc_esp

func _ready():
	dialog_npc_esp = dialog_npc_spc_base

onready var hitbox_npc_spc = $Area2D

func _input(event):
	if event.is_action_pressed("space") and len(hitbox_npc_spc.get_overlapping_areas()) > 0:
		find_and_use_dialogue()
		
func find_and_use_dialogue():
	var dialogue_player = get_node_or_null("Area2D/dialogo")
	
	if dialogue_player:
			dialogue_player.play_dialog(dialog_npc_esp)
		
func _on_oculos_oculos_catch():
	dialog_npc_esp = dialog_npc_spc_missao_concluida
