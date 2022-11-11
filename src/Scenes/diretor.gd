extends Node2D

onready var quest = get_node("../../Quest")
var interact_id = "quest_npc"
var dialog_state
onready var self_zelador = get_node("../../zelador")
onready var jogo = get_node("../..")

var dialog_diretor_base = [
	{"name":"Diretor","text":"Vc tem tido uma pessíma conduta nessa escola"},
	{"name":"Diretor","text":"Tome cuidado meu jovem"},
	{"name":"Diretor","text":"Nessa escola não toleramos pessoas como você"}
]

var dialog_diretor_1 = [
	{"name":"Diretor","text":"o que vc está fazendo aqui ?"},
	{"name":"Diretor","text":"Já terminamos a nossa conversa"}
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

func _on_dialogo_ended():
	if dialog_state == 0:
		quest.add_quest(self_zelador.descr_quest)
		jogo.target = self_zelador
		dialog_state = 1
		self.self_zelador.dialog_state = 0
