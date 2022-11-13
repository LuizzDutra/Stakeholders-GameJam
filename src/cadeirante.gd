extends KinematicBody2D

onready var hitbox_npc = $Area2D
onready var quest = get_node("../../Quest")
onready var dialog_state = -1
var quest_descricao = "Pegar o livro de matématica do marcos"
var interact_id = "quest_npc"
onready var jogo = get_node("../..")
onready var self_armario = get_node("../armario_azul")
onready var pergunta = $pergunta
onready var self_pedro = get_node("../pedro")

var rampa_descr = "Faça uma rampa para marcos"

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

var dialog_npc_rampa_start = [
	{"name":"Marcos","text":"Que pena que meu colega faltou para me ajudar a entrar na escola, pois aqui não tem rampa."},
	{"name":"Marcos","text":"Você pode me ajudar ?"}
]

var dialog_npc_rampa_ac = [
	{"name":"Marcos","text":"Muito obrigado!"},
	{"name":"Marcos","text":"Você pode me ajudar ?"}
]

var dialog_end = [{"name":"Marcos","text":"Muito obrigado!, você mudou muito, você devia falar com o diretor"},]

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
		5:
			dialogue_player.play_dialog(dialog_npc_missao_concluida)
		6:
			dialogue_player.play_dialog(dialog_npc_rampa_start)
		7:
			dialogue_player.play_dialog(dialog_npc_rampa_ac)
		9:
			dialogue_player.play_dialog(dialog_end)

func _on_missao_concluida():
	dialog_state = 4


func _on_dialogo_ended():
	if dialog_state == 0:
		pergunta.show_pergunta("Você quer ajudar o cadeirante marcos ?")
	
	if dialog_state == 1:
		dialog_state = 3
		jogo.target = self_armario
	if dialog_state == 4:
		quest.kill_quest(quest_descricao)
		jogo.target = self_pedro
		quest.add_quest(self_pedro.descr_quest)
		self_pedro.dialog_state = 0
		get_tree().get_root().get_node("Game").score += 250
		dialog_state = 5
	
	if dialog_state == 6:
		pergunta.show_pergunta("Você quer fazer uma rampa para marcos ?")

	if dialog_state == 7:
		get_tree().get_root().get_node("Game").target = get_tree().get_root().get_node("Game/YSort/diretor")
		get_tree().get_root().get_node("Game/YSort/diretor").dialog_state = 2
	
	if dialog_state == 9:
		get_tree().get_root().get_node("Game").target = get_tree().get_root().get_node("Game/YSort/diretor")

func _on_pergunta_sim():
	if dialog_state == 6:
		dialog_state = 7
		quest.add_quest(rampa_descr)
	else:
		dialog_state = 1


func _on_pergunta_nao():
	if dialog_state == 6:
		dialog_state = 2
		quest.quest_failed(rampa_descr)
		return
	quest.quest_failed(quest_descricao)
	jogo.target = self_pedro
	self_pedro.dialog_state = 0
	quest.add_quest(self_pedro.descr_quest)
