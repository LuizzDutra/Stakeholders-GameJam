extends StaticBody2D

onready var hitbox_zelador = $Area2D
onready var zelador_task = $task_zelador
onready var quest = get_node("../../Quest")
onready var pergunta = $pergunta
onready var self_professora = get_node("../Professora")
onready var jogo = get_node("../..")
var interact_id = "quest_npc"
var dialog_state
var descr_quest = "Ajudar o zelador a recolher o lixo"

var zelador_task_off = [
	{"name":"Zelador","text":"Bom dia meu filho"},
	{"name":"Zelador","text":"O dia está muito bonito não é verdade ?"}
]
var zelador_dialogo_pergunta = [
	{"name":"Zelador","text":"Hoje estou com uma dor nas costas…"},
	{"name":"Zelador","text":"Você poderia me ajudar coletando os lixos das salas? "},
]

var zelador_dialogo_sim = [
	{"name":"Você","text":"Posso sim, meu brother."},
	{"name":"Zelador","text":"Muito obrigado!!!"},
	{"name":"Zelador","text":"Preste bastante atenção."},
	{"name":"Zelador","text":"Tudo oque você tem que fazer é o jogar o lixo neste lixeiro aqui do lado."},
	{"name":"Zelador","text":"Você tem que fazer isso antes que o tempo limite acabe."},
	{"name":"Zelador","text":"Você está preparado?"}
]

var zelado_dialogo_missao_concluida = [
	{"name":"Zelador","text":"Muito obrigado!!!"},
	{"name":"zelador","text":"Estou te devendo uma."}
]

var zelador_dialogo_nao = [
	{"name":"Você","text":"Estou afim não velho"},
	{"name":"Zelador","text":"Ok.tudo bem..."}
]

var dialog_start_zelador = [
	{"name":"Zelador","text":"Tic Toc a hora esta acabando."}
]

var dialog_ferramenta = [{"name":"Você:", "text":"Eu queria ferramentas para fazer uma rampo para o Marcos, você tem ?"},
						 {"name":"Zelador","text":"Como você tem mudado de comportamento posso lhe dar este martelo, alguns pregos e algumas tábuas"}]

var dialog_end = [{"name":"Zelador","text":"Se precisar de mais alguma coisa estou aqui."}]

func _ready():
	dialog_state = -1
	print(jogo.name)

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
		5:
			dialog_npc.play_dialog(zelado_dialogo_missao_concluida)
		6:
			dialog_npc.play_dialog(dialog_ferramenta)


func _on_dialogo_ended():
	if dialog_state == 0:
		pergunta.show_pergunta("Você vai ajudar o zelador ?")
		
	if dialog_state == 4:
		jogo.target = self_professora
		quest.kill_quest(descr_quest)
		self_professora.dialog_state = 2
		quest.add_quest(self_professora.descricao_quest)
		jogo.score += 250
		dialog_state = 5
		self_professora.task_professora_2.clear_mesa()
		#self_professora.task_professora_2.maker_mesa(-289)
		jogo.cur_music.stop()
		jogo.cur_music = jogo.get_node("musicas").get_node("padrao")
		jogo.cur_music.play()
	
	if dialog_state == 1:
		zelador_task.iniciar_task()
		dialog_state = 3
		jogo.target = null
		jogo.cur_music.stop()
		jogo.cur_music = jogo.get_node("musicas").get_node("zela")
		jogo.cur_music.play()
	
	if dialog_state == 6:
		dialog_state = 7
		get_tree().get_root().get_node("Global/Game").target = get_tree().get_root().get_node("Global/Game").get_node("LugarRampa")
		
		

func _on_pergunta_sim():
	dialog_state = 1
	

func _on_pergunta_nao():
	dialog_state = 2
	quest.quest_failed(descr_quest)
	jogo.target = self_professora
	self_professora.task_professora_2.clear_mesa()
	#self_professora.task_professora_2.maker_mesa(-289)
	self_professora.dialog_state = 2
	quest.add_quest(self_professora.descricao_quest)
