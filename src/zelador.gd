extends StaticBody2D

onready var hitbox_zelador = $Area2D
onready var zelador_task = $task_zelador
onready var quest = get_node("../Quest")
onready var pergunta = $pergunta
onready var self_professora = get_node("../Professora")
onready var jogo = get_node("../game")
var interact_id = "quest_npc"
var dialog_state
var descr_quest = "Ajudar o zelador a recolhe o lixo"

var zelador_task_off = [
	{"name":"Zelador","text":"Bom dia meu filho"},
	{"name":"Zelador","text":"O dia está muito bonito não é verdade ?"}
]
var zelador_dialogo_pergunta = [
	{"name":"Zelador","text":"eae meu filho como ocê tá ?"},
	{"name":"Zelador","text":"poderia fazer um favor para o seu velho ?"},
	{"name":"Zelador","text":"eu deixei 5 lixos pela escola."},
	{"name":"Zelador","text":"recolhe pra min minha criança"}
]

var zelador_dialogo_sim = [
	{"name":"Zelador","text":"Muito obrigado meu jovem"},
	{"name":"Zelador","text":"Tudo oq vc tem que fazer é o joga o lixo no lixeiro"}
]

var zelado_dialogo_missao_concluida = [
	{"name":"Zelador","text":"Parábens ocê é muito rapido!!!"},
	{"name":"zelador","text":"Parábens ocê é o filho do flash kkkk"}
]

var zelador_dialogo_nao = [
	{"name":"Zelador","text":"Vc não quer me ajudar ?"},
	{"name":"Zelador","text":"Ok tudo bem..."}
]

var dialog_start_zelador = [
	{"name":"Zelador","text":"Tic Toc a hora esta acabando"}
]

func _ready():
	dialog_state = -1

func interact():
	find_and_use_dialogue()

func find_and_use_dialogue():
	
	var dialog_npc = get_node("dialogo")
	
	match dialog_state:
		
		-1:
			dialog_npc.play_dialog(zelador_task_off)
		0:
			dialog_npc.play_dialog(zelador_dialogo_pergunta)
		1:
			dialog_npc.play_dialog(zelador_dialogo_sim)
		2:
			dialog_npc.play_dialog(zelador_dialogo_nao)
		3:
			dialog_npc.play_dialog(dialog_start_zelador)
		4:
			dialog_npc.play_dialog(zelado_dialogo_missao_concluida)


func _on_dialogo_ended():
	if dialog_state == 0:
		pergunta.show_pergunta("Você vai ajudar o zelador ?")
		
	if dialog_state == 4:
		quest.kill_quest(descr_quest)
	
	if dialog_state == 1:
		zelador_task.iniciar_task()
		dialog_state = 3

func _on_pergunta_sim():
	dialog_state = 1


func _on_pergunta_nao():
	dialog_state = 2
	quest.quest_failed(descr_quest)
	#jogo.target = self_professora não estou conseguindo colocar a seta na professora
	self_professora.task_professora_2.clear_mesa()
	self_professora.task_professora_2.maker_mesa(-289)
	self_professora.dialog_state = 2
