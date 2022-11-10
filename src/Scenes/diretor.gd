extends Node2D

onready var quest = get_node("../../Quest")
var interact_id = "quest_npc"
var dialog_state
onready var self_zelador = get_node("../../zelador")

var dialog_diretor_base = [
	{"name":"Diretor","text":"Vc tem tido uma pessíma conduta nessa escola"},
	{"name":"Diretor","text":"Tome cuidado meu jovem"},
	{"name":"Diretor","text":"Nessa escola não toleramos pessoas como você"}
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


func _on_dialogo_ended():
	quest.add_quest(self_zelador.descr_quest,self_zelador)
