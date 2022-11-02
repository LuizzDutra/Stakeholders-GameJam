extends KinematicBody2D

var dialog_npc_spc_base = [
	
	{"name":"Luiza","text":"Olá, meu nome é Luiza"},
	{"name":"Luiza", "text":"Você poderia achar meu óculos perdido por favor ?"}
]

var dialog_npc_spc_missao_aceita = [
	{"name":"Luiza","text":"Eu não sei o que eu vou fazer da minha vida se eu não achar esse óculos"},
	{"name":"Luiza","text":"Esse óculos é muito importante para mim"},
	{"name":"Luiza","text":"..."}
]
var dialog_npc_spc_missao_concluida = [
	{"name":"Luiza","text":"Muito obrigada."},
	{"name":"Luiza","text":"Agora eu vou voltar para a sala de aula."},
	{"name":"Luiza","text":"Tenha uma boa aula."}
]

var dialog_state = 1
onready var quest = get_node("../../Quest")
var quest_descricao = "Pegar o óculos da sua amiga"


func _ready():
	var nodepath: NodePath = "../../Quest"
	print(get_node(nodepath).get_children())

onready var hitbox_npc_spc = $Area2D

func _input(event):
	if event.is_action_pressed("space") and len(hitbox_npc_spc.get_overlapping_areas()) > 0:
		if hitbox_npc_spc.get_overlapping_areas()[0].get_parent().is_processing_unhandled_input():
			find_and_use_dialogue()
			get_tree().set_input_as_handled()
		
func find_and_use_dialogue():
	var dialogue_player = get_node_or_null("Area2D/dialogo")
	
	match dialog_state:
		
		1:
			dialogue_player.play_dialog(dialog_npc_spc_base)
			return
		
		2:
			dialogue_player.play_dialog(dialog_npc_spc_missao_aceita)
			return
		3:
			dialogue_player.play_dialog(dialog_npc_spc_missao_concluida)
			return

func _on_missao_concluida():
	dialog_state = 3
	
	


func _on_dialogo_ended():
	if dialog_state == 1:
		quest.add_quest(quest_descricao)
		dialog_state = 2
	if dialog_state == 3:
		quest.kill_quest(quest_descricao)
