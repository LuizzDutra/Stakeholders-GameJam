extends StaticBody2D

onready var hitbox_zelador = $Area2D
onready var zelador_task = $task_zelador

var dialog_state

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
	dialog_state = 0

func _input(event):
	if event.is_action_pressed("space") and len(hitbox_zelador.get_overlapping_areas()) > 0:
		find_and_use_dialogue()
		get_tree().set_input_as_handled()

func find_and_use_dialogue():
	
	var dialog_npc = get_node("dialogo")
	
	match dialog_state:
		
		0:
			dialog_npc.play_dialog(zelador_dialogo_base)
		1:
			dialog_npc.play_dialog(zelador_dialogo_start)
		2:
			dialog_npc.play_dialog(zelado_dialogo_missao_concluida)


func _on_dialogo_ended():
	if dialog_state == 0:
		dialog_state = 1
		zelador_task.iniciar_task()
