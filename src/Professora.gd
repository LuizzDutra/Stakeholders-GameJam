extends StaticBody2D

var interact_id = "quest_npc"
onready var hitbox_barreira = $barreira/CollisionShape2D
var dialog_state
onready var quest = get_node("../Quest")
onready var self_diretor = get_node("../YSort/diretor")



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
func interact():
	find_and_use_dialogue()

func find_and_use_dialogue():
	
	var dialogue_play = get_node("dialogo")
	
	match dialog_state:
		
		0:
			dialogue_play.play_dialog(dialog_base_professora)
			return
		
		1:
			dialogue_play.play_dialog(dialog_missao_concluida)
			return


func _on_dialogo_ended():
	
	if dialog_state == 1:
		hitbox_barreira.disabled = true
		quest.add_quest("None",self_diretor)
