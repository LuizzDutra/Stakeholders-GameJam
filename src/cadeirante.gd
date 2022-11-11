extends KinematicBody2D

onready var hitbox_npc = $Area2D
onready var quest = get_node("../../Quest")
onready var dialog_state = 0
var quest_descricao = "Pegar o livro de matématica de marcos no armário."
var interact_id = "quest_npc"
onready var jogo = get_node("../..")
onready var self_armario = get_node("../armario_azul")
onready var pergunta = $pergunta

var cadeirante_off_dialog = [
	{"name":"Marcos","text":"zzzzzzzz"}
]
var dialog_npc_pergunta = [
	{"name":"Marcos","text":"Olá, tudo bem?"},
	{"name":"Marcos","text":"Eu estou precisando de ajuda"},
	{"name":"Marcos","text":"Você poderia pegar meu livro de matématica no armário pfv ?"}
]

var dialog_npc_missao_start = [
	{"name":"Marcos","text":"Você sabia que eu gosto de matématica?"},
	{"name":"Marcos","text":"É uma ciência exata incrivel!!!"}
]

var dialog_npc_missao_concluida = [
	{"name":"Marcos","text":"Muito obrigado"},
	{"name":"Marcos","text":"agora eu vou me divertir resolvendo equações kkkk"}
]

var dialog_npc_sim = [
	{"name":"Marcos","text":"valeu irmão"},
	{"name":"Marcos","text":"Você é uma pessoa muito legal sabia ?"}
]

var dialog_npc_nao = [
	{"name":"Marcos","text":"Poxa cara..."},
	{"name":"Marcos","text":"Eu só queria que alguém me ajudase..."}
]
func interact():
	find_and_use_dialogue()
		
func find_and_use_dialogue():
	var dialogue_player = get_node_or_null("Area2D/dialogo")
	
	match dialog_state:
		
		-1:
			dialogue_player.play_dialog(cadeirante_off_dialog)
		0:
			dialogue_player.play_dialog(dialog_npc_pergunta)
			return
		1:
			dialogue_player.play_dialog(dialog_npc_sim)
			return
		2:
			dialogue_player.play_dialog(dialog_npc_nao)
			return
		3:
			dialogue_player.play_dialog(dialog_npc_missao_start)
			return
		4:
			dialogue_player.play_dialog(dialog_npc_missao_concluida)

func _on_missao_concluida():
	dialog_state = 4


func _on_dialogo_ended():
	if dialog_state == 0:
		pergunta.show_pergunta("Você quer ajudar o cadeirante marcos ?")
	
	if dialog_state == 1:
		dialog_state = 3
		quest.add_quest(quest_descricao)
		jogo.target = self_armario
	if dialog_state == 4:
		quest.kill_quest(quest_descricao)


func _on_pergunta_sim():
	dialog_state = 1


func _on_pergunta_nao():
	dialog_state = 2
	quest.quest_failed(quest_descricao)
