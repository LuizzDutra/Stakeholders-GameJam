extends CanvasLayer

onready var puzzle = $puzzle
onready var line_edit = $puzzle/LineEdit
onready var certo = $puzzle/certo
onready var errado = $puzzle/errado
onready var tempo_certo = $Timer
onready var tempo_errado = $Timer2
onready var cool_down_text = $Timer3
onready var close_timer = $CloseTimer
onready var self_armario = get_node("../..")
signal missao_concluida()

func _ready():
	certo.visible = false
	errado.visible = false
	puzzle.visible = false
	print(self_armario.get_children())
	
func show_puzzle():
	puzzle.visible = true
	line_edit.grab_focus()
	line_edit.text = ""
	turn_off_the_player()

func _input(event):
	
	if event.is_action_pressed("enter"):
		
		if line_edit.text.to_lower().strip_edges() == "amor e paz":
			line_edit.text = ""
			#line_edit.editable = false
			certo.visible = true
			emit_signal("missao_concluida")
			cool_down_text.start()
			tempo_certo.start()
			close_timer.start()
			self_armario.jogo.target = self_armario.player
			
		
		else:
			line_edit.text = ""
			#line_edit.editable = false
			errado.visible = true
			cool_down_text.start()
			tempo_errado.start()
	
	if puzzle.visible:
		if event.is_action_pressed("Return"):
			puzzle.visible = false
			get_tree().set_input_as_handled()
			turn_on_the_player()
		

func _on_Timer_timeout():
	certo.visible = false
	line_edit.editable = true

func _on_Timer2_timeout():
	errado.visible = false
	line_edit.editable = true

func turn_on_the_player():
	var player = get_tree().get_root().find_node("Player", true, false)
	if player:
		player.set_active(true)

func turn_off_the_player():
	var player = get_tree().get_root().find_node("Player", true, false)
	if player:
		player.set_active(false)


func _on_Timer3_timeout():
	line_edit.editable = true


func _on_exit_pressed():
	puzzle.visible = false
	turn_on_the_player()


func _on_CloseTimer_timeout():
	puzzle.visible = false
	turn_on_the_player()
