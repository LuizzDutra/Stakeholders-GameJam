extends StaticBody2D

var interact_id = "quest_npc"
onready var hitbox_barreira = $barreira/CollisionShape2D
var dialog_state
var porta_interacao = true
onready var quest = get_node("../../Quest")
onready var self_diretor = get_node("../diretor")
onready var jogo = get_node("../../")
onready var task_professora_2 = get_node("../task_professora_2")
onready var pergunta = $pergunta
onready var self_luiza = get_node("../unity")
var descricao_quest = "ajudar a organizar as mesas da sala"


func _ready():
	dialog_state = 0
	hitbox_barreira.disabled = false
var dialog_base_professora = [
	{"name":"Professora","text":"Já que você não prestou atenção na aula, pois estava dormindo"},
	{"name":"Professora","text":"resolva esta questão que está no quadro"}
]

var dialog_missao_concluida = [
	{"name":"Professora","text":"Você sempre foi  muito desatento."},
	{"name":"Professora","text":"Busque melhorar sua conduta, o diretor pode lhe ajudar com isso."}
]

var dialog_prof_sim = [
	{"name":"Você","text":"Com certeza, pode contar com minha ajuda!!!"},
	{"name":"Professora","text":"Muito bem."},
	{"name":"Professora","text":"Coloque cada cadeira dentro do circulos azul"},
	{"name":"Professora","text":"vamos começar ?"}
]

var dialog_prof_nao = [
	{"name":"Você","text":"Oxe! vou não, preciso jogar bola"},
	{"name":"Professora","text":"Não sei o que faço com você"},
	{"name":"Professora","text":"Francamente..."}
]

var dialog_prof_start = [
	{"name":"Professora","text":"As mesas não estão organizadas!!!"}
]

var dialog_prof_missao_concluida_2 = [
	{"name":"Professora","text":"Obrigada."},
	{"name":"Professora","text":"Você está melhorando sua conduta de forma extraordinária !!!"}
]

var dialog_prof_pergunta = [
	{"name":"Professora","text":"Você poderia me ajudar colocando as cadeiras no lugar? "}
]

var dialog_prof_off = [
	{"name":"Professora","text":"Você sabia que menos de 5% dos oceanos foram explorado ?"},
	{"name":"Professora","text":"Interessante não é ?"}
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
		7:
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
		quest.kill_quest(descricao_quest)

		jogo.target = self_luiza
		quest.add_quest(self_luiza.quest_descricao)
		self_luiza.dialog_state = 0
		get_tree().get_root().get_node("Global/Game").score += 250
		dialog_state = 7
	
func _on_pergunta_sim():
	dialog_state = 4


func _on_pergunta_nao():
	dialog_state = 3
	quest.quest_failed(descricao_quest)
	jogo.target = self_luiza
	self_luiza.dialog_state = 0
	quest.add_quest(self_luiza.quest_descricao)
