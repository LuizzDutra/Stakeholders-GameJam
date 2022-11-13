extends Node2D

# "leonardo da vinci"
var interact_id = "quest"
onready var quadro = $CanvasLayer/NinePatchRect
onready var professora = get_node("../Professora")
onready var player = get_node("../YSort/Player")
onready var timer = $Timer
onready var timer_certo = $TimerCerto
onready var errado = $CanvasLayer/NinePatchRect/Label2
onready var certo = $CanvasLayer/NinePatchRect/Label3

func _ready():
	quadro.visible = false

func interact():
	if professora.dialog_state == 0:
		abrir_quadro()

func abrir_quadro():
	quadro.visible = true
	turn_off_the_player()

func _input(event):
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


func _on_Certo_pressed():
	for i in get_node("CanvasLayer/NinePatchRect/Control").get_children():
		i.disabled = true
	certo.visible = true
	errado.visible = false
	timer_certo.start()
	


func _on_Button_pressed():
	errado.visible = true
	timer.start()


func _on_Timer_timeout():
	errado.visible = false


func _on_TimerCerto_timeout():
	certo.visible = false
	professora.dialog_state = 1
	quadro.visible = false
	turn_on_the_player()
