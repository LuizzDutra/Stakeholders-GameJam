extends StaticBody2D

onready var task_pedro = $task_pedro
var interact_id = "quest_npc"
var dialog_state


var dialog_base = [
	{"name":"Pedro","text":"olá meu nome é pedro"},
	{"name":"Pedro","text":"Vamos Jogar pedra,papel e tesoura ?"},
	{"name":"Pedro","text":"Vamos nessa!!!"}
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

func _ready():
	dialog_state = 0
	
func interact():
	if task_pedro.janela_task.visible == true:
		return
	find_and_use_dialogue()

func find_and_use_dialogue():
	
	var dialog_player = get_node("dialogo")
	
	
	match dialog_state:
		
		0:
			dialog_player.play_dialog(dialog_base)
			return
		1:
			dialog_player.play_dialog(dialog_point_1)
			return
		2:
			dialog_player.play_dialog(dialog_point_2)
			return
		3:
			dialog_player.play_dialog(dialog_point_3)
			return
		4:
			dialog_player.play_dialog(dialog_missao_concluida)
			return

func _on_dialogo_ended():
	if dialog_state == 4:
		return
	task_pedro.show_janela_task()
