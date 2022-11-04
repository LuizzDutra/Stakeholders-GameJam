extends StaticBody2D

onready var hitbox_zelador = $Area2D

var zelador_dialogo_base = [
	{"name":"Zelador","text":"eae meu filho como ocê tá ?"},
	{"name":"Zelador","text":"poderia fazer um favor para o seu velho ?"},
	{"name":"Zelador","text":"eu deixei 5 lixos pela escola."},
	{"name":"Zelador","text":"recolhe pra min minha criança"}
]

var zelador_dialogo_start = [
	{"name":"Zelador","text":"tic tac olha hora meu filho kkkk"}
]

var zelado_dialogo_missao_concluida = [
	{"name":"Zelador","text":"Parábens ocê é muito rapido!!!"},
	{"name":"zelador","text":"Parábens ocê é o filho do flash kkkk"}
]
func _ready():
	pass

func _input(event):
	if event.is_action_pressed("space") and len(hitbox_zelador.get_overlapping_areas()) > 0:
		find_and_use_dialogue()
		get_tree().set_input_as_handled()

func find_and_use_dialogue():
	pass
