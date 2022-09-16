extends Node2D

export(String, FILE, "*.json") var dialog_file

onready var texto = $dialogo/texto
onready var nome = $dialogo/nome
onready var tempo = $dialogo/Timer
onready var dialogo = $dialogo
onready var cooldown_dialog = $Timer2

var dialog = []
var current_index = 0
var dialog_ativo = false

func _ready():
	dialogo.visible = false

func show_message():
	
	if not tempo.is_stopped():
		texto.visible_characters = texto.text.length()
		return
		
	current_index += 1
	
	if current_index >= len(dialog):
		cooldown_dialog.start()
		dialogo.visible = false
		return
		
	texto.visible_characters = 0
	texto.text = dialog[current_index]["text"]
	nome.text = dialog[current_index]["name"]
	
	tempo.start()
	
func _input(event):
	if not dialog_ativo:
		return
		
	if event is InputEventKey:
		
		if event.is_action_pressed("E"):
			show_message()

func load_dialog():
	var file = File.new()
	if file.file_exists(dialog_file):
		file.open(dialog_file, file.READ)
		return parse_json(file.get_as_text())

func _on_Timer_timeout():
	if texto.visible_characters == texto.text.length():
		tempo.stop()
		return
	texto.visible_characters += 1

func play_dialog():
	
	if dialog_ativo:
		return
		
	dialog = load_dialog()
	current_index = -1
	dialogo.visible = true
	dialog_ativo = true
	show_message()

func _on_Timer2_timeout():
	dialog_ativo = false
