extends KinematicBody2D

onready var hitbox_npc = $Area2D
onready var quest = get_node("../../Quest")
onready var dialog_state = 1
var quest_descricao = "Pegar o livro de matématica de marcos"

var dialog_npc_base = [
	{"name":"Marcos","text":"Olá tudo bem ?"},
	{"name":"Marcos","text":"Eu estou precisando de ajuda"},
	{"name":"Marcos","text":"Vc poderia pegar meu livro de matématica no armário pfv"}
]

var dialog_npc_missao_start = [
	{"name":"Marcos","text":"Vc sabia que eu gosto de matématica ?"},
	{"name":"Marcos","text":"É uma ciência exata incrivel!!!"}
]

var dialog_npc_missao_concluida = [
	{"name":"Marcos","text":"Muito obrigado"},
	{"name":"Marcos","text":"agora eu vou me divertir resolvendo equações kkkk"}
]

func _input(event):
	if event.is_action_pressed("space") and len(hitbox_npc.get_overlapping_areas()) > 0:
		find_and_use_dialogue()
		get_tree().set_input_as_handled()
		
func find_and_use_dialogue():
	var dialogue_player = get_node_or_null("Area2D/dialogo")
	
	match dialog_state:
		
		1:
			dialogue_player.play_dialog(dialog_npc_base)
			if dialogue_player.current_index >= len(dialog_npc_base):
				quest.add_quest(quest_descricao)
				dialog_state = 2
			return
		2:
			dialogue_player.play_dialog(dialog_npc_missao_start)
			return
		3:
			dialogue_player.play_dialog(dialog_npc_missao_concluida)
			quest.kill_quest(quest_descricao)
			return

func _on_missao_concluida():
	dialog_state = 3
