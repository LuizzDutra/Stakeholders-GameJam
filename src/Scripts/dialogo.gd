extends CanvasLayer

export(Resource) var dialog_file

onready var texto = $dialog/texto
onready var nome = $dialog/nome
onready var tempo = $dialog/Timer
onready var dialogo = $dialog
onready var cooldown_dialog = $Timer2
onready var sound = $AudioStreamPlayer
var random_number = RandomNumberGenerator.new()

var dialog = []
var current_index = 0
var dialog_ativo = false

signal ended

func _ready():
	dialogo.visible = false

func show_message():
	
	if not tempo.is_stopped():
		texto.visible_characters = texto.text.length()
		return
		
	current_index += 1
	
	if current_index >= len(dialog):
		cooldown_dialog.start()
		turn_on_the_player()
		dialogo.visible = false
		emit_signal(("ended"))
		return
		
	sound.play()
	texto.visible_characters = 0
	texto.text = dialog[current_index]["text"]
	nome.text = dialog[current_index]["name"]
	
	tempo.start()
	
func _input(event):
	if not dialog_ativo:
		return
	
	if current_index >= len(dialog):
		return
		
	if event is InputEventKey:
		
		if event.is_action_pressed("space"):
			get_tree().set_input_as_handled()
			show_message()
			
		if event.is_action_pressed("Return"):
			get_tree().set_input_as_handled()
	
	
func _on_Timer_timeout():
	if texto.visible_characters == texto.text.length():
		tempo.stop()
		return
	texto.visible_characters += 1

func play_dialog(dialogu):
	
	if dialog_ativo:
		return
	dialog = dialogu
	turn_off_the_player()
	current_index = -1
	dialogo.visible = true
	dialog_ativo = true
	show_message()

func _on_Timer2_timeout():
	dialog_ativo = false
	
func turn_on_the_player():
	var player = get_tree().get_root().find_node("Player", true, false)
	if player:
		player.set_active(true)

func turn_off_the_player():
	var player = get_tree().get_root().find_node("Player", true, false)
	if player:
		player. set_active(false)
