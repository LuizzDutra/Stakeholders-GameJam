extends CanvasLayer

onready var puzzle = $puzzle_cadeir
onready var certo = $puzzle_cadeir/certo
onready var errado = $puzzle_cadeir/errado
onready var line_edit = $puzzle_cadeir/LineEdit
onready var tempo_certo = $Timer
onready var tempo_errado = $Timer2
onready var cooldown_text = $Timer3

func _ready():
	certo.visible = false
	errado.visible = false
	puzzle.visible = false

func show_puzzle():
	puzzle.visible = true
	turn_off_the_player()

func _input(event):
	
	if event.is_action_pressed("enter"):
		
		if line_edit.text.to_lower() == "30":
			line_edit.text = ""
			line_edit.editable = false
			certo.visible = true
			tempo_certo.start()
			cooldown_text.start()
		
		else:
			
			line_edit.text = ""
			line_edit.editable = false
			errado.visible = true
			tempo_errado.start()
			cooldown_text.start()
			
	if event.is_action_pressed("esc"):
		puzzle.visible = false
		turn_on_the_player()

func turn_on_the_player():
	var player = get_tree().get_root().find_node("Player", true, false)
	if player:
		player.set_active(true)

func turn_off_the_player():
	var player = get_tree().get_root().find_node("Player", true, false)
	if player:
		player.set_active(false)


func _on_Timer_timeout():
	certo.visible = false

func _on_Timer2_timeout():
	errado.visible = false


func _on_Timer3_timeout():
	line_edit.editable = true
