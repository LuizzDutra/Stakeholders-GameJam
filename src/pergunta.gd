extends Node2D

onready var painel_pergunta = $CanvasLayer
onready var pergunta = $CanvasLayer/texto
onready var sim = $CanvasLayer/input/sim
onready var nao =  $CanvasLayer/input/nao
onready var input = $CanvasLayer/input

signal sim
signal nao

func _ready():
	painel_pergunta.visible = false

func show_pergunta(p:String):
	painel_pergunta.visible = true
	pergunta.text = p
	button_on()

func _physics_process(delta):
	
	if sim.pressed:
		print("sim")
		emit_signal("sim")
		process_input()
	
	elif nao.pressed:
		print("não")
		emit_signal("nao")
		process_input()

func process_input():
	for i in input.get_children():
		i.disabled = true
	
	painel_pergunta.visible = false

func button_on():
	for i in input.get_children():
		i.disabled = false
