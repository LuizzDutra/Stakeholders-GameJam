extends KinematicBody2D

var interact_id = "quest_npc"
onready var jogo = get_node("../..")
onready var self_armario = get_node("../armario")
onready var pergunta = $pergunta
onready var self_cadeirante = get_node("../cadeirante")

var dialog_off_luiza = [
	{"name":"Luiza","text":"Olá, meu nome é Luiza"},
	{"name":"Luiza","text":"`Prazer em conhecer você"}
]
var dialog_npc_spc_pergunta = [
	
	{"name":"Luiza","text":"Olá, meu nome é Luiza"},
	{"name":"Luiza", "text":"Você poderia achar meu óculos perdido por favor?"}
]

var dialog_npc_spc_missao_sim = [
	{"name":"Luiza","text":"Você vai me ajudar a achar os meus ôculos ?"},
	{"name":"Luiza","text":"Esse óculos é muito importante para mim"},
	{"name":"Luiza","text":"Muito obrigado"}
]

var dialoo_npc_spc_nao = [
	{"name":"Luiza","text":"Tudo bem amigo"},
	{"name":"Luiza","text":"vlw..."}
]
var dialog_npc_spc_missao_concluida = [
	{"name":"Luiza","text":"Muito obrigada."},
	{"name":"Luiza","text":"Agora eu vou voltar para a sala de aula."},
	{"name":"Luiza","text":"Tenha uma boa aula."}
]

var dialog_npc_spc_missao_start = [
	{"name":"Luiza","text":"Esse ôculos é muito valioso para mim"},
	{"name":"Luiza","text":"Eu não sei oq fazer sem eles..."}
]

var dialog_state = -1
onready var quest = get_node("../../Quest")
var quest_descricao = "Pegar o óculos da Luiza"


func _ready():
	var nodepath: NodePath = "../../Quest"
	print(get_node(nodepath).get_children())

onready var hitbox_npc_spc = $Area2D

func interact():
	find_and_use_dialogue()
		
func find_and_use_dialogue():
	var dialogue_player = get_node_or_null("Area2D/dialogo")
	
	match dialog_state:
		
		-1:
			dialogue_player.play_dialog(dialog_off_luiza)
			return
		0:
			dialogue_player.play_dialog(dialog_npc_spc_pergunta)
			return
		1:
			dialogue_player.play_dialog(dialog_npc_spc_missao_sim)
			return
		2:
			dialogue_player.play_dialog(dialoo_npc_spc_nao)
			return
		3:
			dialogue_player.play_dialog(dialog_npc_spc_missao_start)
			return
		4:
			dialogue_player.play_dialog(dialog_npc_spc_missao_concluida)
			return
		5:
			dialogue_player.play_dialog(dialog_npc_spc_missao_concluida)
			return

func _on_missao_concluida():
	dialog_state = 4

func _on_dialogo_ended():
	if dialog_state == 0:
		pergunta.show_pergunta("Vc quer ajudar a luiza a achar os seus óculos")
	
	if dialog_state == 1:
		jogo.target = self_armario
		dialog_state = 3
	if dialog_state == 4:
		quest.kill_quest(quest_descricao)
		jogo.target = self_cadeirante
		self_cadeirante.dialog_state = 0
		quest.add_quest(self_cadeirante.quest_descricao)
		get_tree().get_root().get_node("Global/Game").score += 250
		dialog_state = 5

func _on_pergunta_sim():
	dialog_state = 1


func _on_pergunta_nao():
	dialog_state = 2
	quest.quest_failed(quest_descricao)
	jogo.target = self_cadeirante
	self_cadeirante.dialog_state = 0
	quest.add_quest(self_cadeirante.quest_descricao)
