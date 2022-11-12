extends StaticBody2D

var interact_id = "quest_npc"
onready var hitbox_barreira = $barreira/CollisionShape2D
var dialog_state
var porta_interacao = true
onready var quest = get_node("../Quest")
onready var self_diretor = get_node("../YSort/diretor")
onready var jogo = get_node("../")
onready var task_professora_2 = get_node("../YSort/task_professora_2")
onready var pergunta = $pergunta
var descricao_quest = "ajudar a organizar as mesas da sala"


func _ready():
	dialog_state = 0
	hitbox_barreira.disabled = false
var dialog_base_professora = [
	{"name":"Professora","text":"Espera um pouco ai garoto"},
	{"name":"Professora","text":"Resolva o exercicío que esta no quadro"}
]

var dialog_missao_concluida = [
	{"name":"Professora","text":"Muito bem meu anjo"},
	{"name":"Professora","text":"Agora vai para sala do diretor"}
]

var dialog_prof_sim = [
	{"name":"Professora","text":"Muito obrigado fofo"},
	{"name":"Professora","text":"Organizar ai pfv"}
]

var dialog_prof_nao = [
	{"name":"Professora","text":"ok"}
]

var dialog_prof_start = [
	{"name":"Professora","text":"......"}
]

var dialog_prof_missao_concluida_2 = [
	{"name":"Professora","text":"obrigado"}
]

var dialog_prof_pergunta = [
	{"name":"Professora","text":"Me ajudar pfv"}
]

var dialog_prof_off = [
	{"name":"Professora","text":"Me ajudar pfv"}
]

func interact():
	find_and_use_dialogue()

func find_and_use_dialogue():
	
	var dialogue_play = get_node("dialogo")
	
	if task_professora_2 != null:
		if task_professora_2.is_cadeiras_organizadas():
			task_professora_2.circle_blue_clear()
			dialog_state = 6
		
	match dialog_state:
		
		-1:
			dialogue_play.play_dialog(dialog_prof_off)
		0:
			dialogue_play.play_dialog(dialog_base_professora)
			return
		
		1:
			dialogue_play.play_dialog(dialog_missao_concluida)
			return
		2:
			dialogue_play.play_dialog(dialog_prof_pergunta)
			return
		
		3:
			dialogue_play.play_dialog(dialog_prof_nao)
		
		4:
			dialogue_play.play_dialog(dialog_prof_sim)
		
		5:
			dialogue_play.play_dialog(dialog_prof_start)
		
		6:
			dialogue_play.play_dialog(dialog_prof_missao_concluida_2)
			


func _on_dialogo_ended():
	
	if dialog_state == 1:
		hitbox_barreira.disabled = true
		jogo.target = self_diretor
		#dialog_state = 2
		porta_interacao = false
		dialog_state = -1
		
	if dialog_state == 2:
		pergunta.show_pergunta("Você vai ajudar a sua professora ?")
	
	if dialog_state == 4:
		task_professora_2.iniciar_task()
		dialog_state = 5
		jogo.target = null
	
	if dialog_state == 6:
		task_professora_2.queue_free()
		quest.kill_quest(descricao_quest)

func _on_pergunta_sim():
	dialog_state = 4


func _on_pergunta_nao():
	dialog_state = 3
	quest.failed_quest(descricao_quest)
