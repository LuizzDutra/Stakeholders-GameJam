extends Node2D

onready var quest = get_node("../../Quest")
var interact_id = "quest_npc"
var dialog_state
onready var self_zelador = get_node("../zelador")
onready var jogo = get_node("../..")
signal good_end
signal bad_end

var dialog_diretor_base = [
	{"name":"Diretor","text":"Você aqui novamente? O que aconteceu desta vez?"},
	{"name":"Você","text":"Sonhei que era expulso da escola por conta das bagunças."},
	{"name":"Você","text":"não quero que isso aconteça..."},
	{"name":"Você","text":"o que posso fazer?"},
	{"name":"Diretor","text":"Busque participar das aulas, melhore seu relacionamento com toda a escola."},
]

var dialog_diretor_1 = [
	{"name":"Diretor","text":"o que você está fazendo aqui ?"},
	{"name":"Diretor","text":"Já terminamos a nossa conversa"}
]

var dialog_marcos = [{"name":"Você:","text":"Eu quero ajudar o Marcos criando um rampa para ele, como posso fazer isso ?"},
					{"name":"Diretor","text":"Você pode usar aquela bancada ali do lado, os materiais eu não tenho disponível."}]

var dialog_end = [{"name":"Diretor","text":"Parabéns você tem mudado muito seu comportamento nessa escola! Impressionante!"}]

var dialog_bad = [
	{"name":"Diretor","text":"Você teve uma péssima conduta na escola."},
	{"name":"Diretor","text":"Aqui não é um espaço para brincadeiras."},
	{"name":"Diretor","text":"Nós não aceitamos delinquentes como você nessa escola."},
	{"name":"Diretor","text":"Você está expulso."},
	{"name":"Diretor","text":"Saia daqui e nunca mais volte."}
]

func _ready():
	dialog_state = 0
	
func interact():
	find_and_use_dialogue()

func find_and_use_dialogue():
	var dialog_player = get_node_or_null("dialogo")
	match dialog_state:
		
		0:
			dialog_player.play_dialog(dialog_diretor_base)	
		1:
			dialog_player.play_dialog(dialog_diretor_1)
		2:
			dialog_player.play_dialog(dialog_marcos)
		7:
			dialog_player.play_dialog(dialog_end)
		8:
			dialog_player.play_dialog(dialog_bad)
			

func _on_dialogo_ended():
	if dialog_state == 0:
		quest.add_quest(self_zelador.descr_quest)
		jogo.target = self_zelador
		dialog_state = 1
		self.self_zelador.dialog_state = 0
	if dialog_state == 2:
		get_tree().get_root().get_node("Game").target = self_zelador
		self_zelador.dialog_state = 6
	if dialog_state == 7:
		emit_signal("good_end")
	if dialog_state == 8:
		emit_signal("bad_end")
