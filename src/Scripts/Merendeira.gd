extends Sprite

onready var dialogo = $dialogo

var interact_id = "quest_npc"
var descr = [{"name":"Tia da cantina:", "text":"Hoje o almoço é arroz, purê e batata."}]

func interact():
	dialogo.play_dialog(descr)
