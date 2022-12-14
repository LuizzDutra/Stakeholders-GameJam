extends StaticBody2D

onready var task_pedro = $task_pedro
onready var pergunta = $pergunta
var interact_id = "quest_npc"
var dialog_state
var descr_quest = "Jogar pedra,papel e tesoura"
onready var quest = get_node("../../Quest")
onready var cadeirante = get_parent().get_node("cadeirante")

var dialog_off_pedro = [
	{"name":"Pedro","text":"O diretor é uma pessoa muito sinistra"},
	{"name":"Pedro","text":"Ele me da muito medo de verdade"}
]
var dialog_pergunta = [
	{"name":"Pedro","text":"olá meu nome é pedro"},
	{"name":"Pedro","text":"Vamos Jogar pedra,papel e tesoura ?"},
]

var dialog_point_1 = [
	{"name":"Pedro","text":"Nossa vc é bom."},
	{"name":"Pedro","text":"Vamos de novo!!!"}
]

var dialog_point_2 = [
	{"name":"Pedro","text":"na rodada anterior foi sorte."},
	{"name":"Pedro","text":"Vamos só mais uma vez !!!"}
]

var dialog_point_3 = [
	{"name":"Pedro","text":"Só mais esse rodada por favor"},
]

var dialog_missao_concluida = [
	{"name":"Pedro","text":"Vc é muito bom em pedra,papel e tesoura"},
	{"name":"Pedro","text":"outra hora a gente joga belê ?"}
]

var dialog_pedro_sim = [
	{"name":"Pedro","text":"Vamos nessa!!! 1 2 3..."}
]

var dialog_nao = [
	{"name":"Pedro","text":"você não gosta de pedra,papel e tesoura ?"}
]

var dialog_bad = [
	{"name":"Pedro","text":"O diretor queria falar com você."}
]

func _ready():
	dialog_state = 0
	
func interact():
	if task_pedro.janela_task.visible == true:
		return
	find_and_use_dialogue()

func find_and_use_dialogue():
	
	var dialog_player = get_node("dialogo")
	
	
	match dialog_state:
		-2:
			dialog_player.play_dialog(dialog_nao)
		-1:
			dialog_player.play_dialog(dialog_off_pedro)
		0:
			dialog_player.play_dialog(dialog_pergunta)
			return
		1:
			dialog_player.play_dialog(dialog_pedro_sim)
			return
		2:
			dialog_player.play_dialog(dialog_point_1)
			return
		3:
			dialog_player.play_dialog(dialog_point_2)
			return
		4:
			dialog_player.play_dialog(dialog_point_3)
			return
		5:
			dialog_player.play_dialog(dialog_missao_concluida)
		6:
			dialog_player.play_dialog(dialog_missao_concluida)
		7:
			dialog_player.play_dialog(dialog_bad)

func _on_dialogo_ended():
	
	if dialog_state == 0:
		pergunta.show_pergunta("Você vai jogar pedra,papel e tesoura com pedro ?")
	if not dialog_state != -1 or dialog_state == 0:
		return
	if dialog_state == 5 or dialog_state == -2:
		if dialog_state == 5:
			print("here")
			quest.kill_quest(descr_quest)
			dialog_state = 6
			get_tree().get_root().get_node("Game").score += 250
			if get_tree().get_root().get_node("Game").score >= 750:
				get_tree().get_root().get_node("Game").target = cadeirante
				cadeirante.dialog_state = 6
				return
			else:
				dialog_state = 7
				get_tree().get_root().get_node("Game").target = get_tree().get_root().get_node("Game/YSort/diretor")
				get_tree().get_root().get_node("Game/YSort/diretor").dialog_state = 8
				return
			return
		return
	task_pedro.show_janela_task()


func _on_pergunta_sim():
	dialog_state = 1

func _on_pergunta_nao():
	dialog_state = -2
	quest.quest_failed(descr_quest)
