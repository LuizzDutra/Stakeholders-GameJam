extends Node2D

# "leonardo da vinci"
var interact_id = "quest"
onready var quadro = $CanvasLayer/NinePatchRect
onready var input_res = $CanvasLayer/NinePatchRect/LineEdit
onready var professora = get_node("../Professora")
onready var player = get_node("../YSort/Player")

func _ready():
	quadro.visible = false

func interact():
	if professora.dialog_state == 0:
		abrir_quadro()

func abrir_quadro():
	quadro.visible = true
	turn_off_the_player()
	input_res.grab_focus()

func _input(event):
	
	if event.is_action_pressed("enter") and professora.dialog_state == 0:
		
		if input_res.text.to_lower().strip_edges() == "20":
			input_res.clear()
			professora.dialog_state = 1
			quadro.visible = false
			turn_on_the_player()
			
				
		else:
			input_res.clear()
	
	if event.is_action_pressed("Return"):
		quadro.visible = false
		turn_on_the_player()

func turn_on_the_player():
	var player = get_tree().get_root().find_node("Player", true, false)
	if player:
		player.set_active(true)

func turn_off_the_player():
	var player = get_tree().get_root().find_node("Player", true, false)
	if player:
		player.set_active(false)
