extends Node2D

onready var janela_task = $painel_task
onready var painel_amigo = $painel_task/amigo/Sprite
onready var option_res = $painel_task/button_options
onready var painel_inimigo = $painel_task/inimigo/Sprite
onready var texto = $painel_task/Label
onready var tempo = $Timer
onready var pedro = get_node("../")
var is_pressed = false
onready var input_tesoura = $painel_task/input_text/key_tesoura
onready var input_papel = $painel_task/input_text/key_papel
onready var input_pedra = $painel_task/input_text/key_pedra


var res_npc
var res_player
var random = RandomNumberGenerator.new()

func _ready():
	janela_task.visible = false
	ocultar_resul()
	input_papel.text = input_task("Up")
	input_tesoura.text = input_task("Down")
	input_pedra.text = input_task("Right")
	is_pressed = true
	
	
	
func show_janela_task():
	janela_task.visible = true
	turn_off_the_player()


func _on_papel_pressed():
	res_player = 2
	painel_amigo.set_rotation_degrees(0)
	painel_amigo.frame = 2
	buttons_off()
	random_res_npc()
	process_resul()


func _on_pedra_pressed():
	res_player = 1
	painel_amigo.set_rotation_degrees(0)
	painel_amigo.frame = 1
	buttons_off()
	random_res_npc()
	process_resul()
	
func _on_tesoura_pressed():
	res_player = 0
	painel_amigo.set_rotation_degrees(90)
	painel_amigo.frame = 0
	buttons_off()
	random_res_npc()
	process_resul()


func random_res_npc():
	random.randomize()
	res_npc = random.randi_range(0,2)
	
	if res_npc == 0:
		painel_inimigo.set_rotation_degrees(90)
	else:
		painel_inimigo.set_rotation_degrees(0)
			
	painel_inimigo.frame = res_npc

func buttons_off():
	for r in option_res.get_children():
		r.disabled = true

func buttons_on():
	for r in option_res.get_children():
		r.disabled = false
		
func process_resul():
	
	var resposta_text = ""
	
	if res_npc == 0 and res_player == 0:
		resposta_text = "empate"
	
	if res_npc == 0 and res_player == 1:
		resposta_text = "ganhou"
	
	if res_npc == 0 and res_player == 2:
		resposta_text = "Perdeu"
	
	if res_npc == 1 and res_player == 0:
		resposta_text = "perdeu"
	
	if res_npc == 1 and res_player == 1:
		resposta_text = "empate"
	
	if res_npc == 1 and res_player == 2:
		resposta_text = "ganhou"
	
	if res_npc == 2 and res_player == 0:
		resposta_text = "ganhou"
	
	if res_npc == 2 and res_player == 1:
		resposta_text = "perdeu"
	
	if res_npc == 2 and res_player == 2:
		resposta_text = "empate"
	
	if resposta_text == "ganhou":
		pedro.dialog_state += 1
	revelar_resul()
	texto.text = resposta_text
	tempo.start()
	

func revelar_resul():
	painel_amigo.visible = true
	painel_inimigo.visible = true
	texto.visible = true

func ocultar_resul():
	painel_amigo.visible = false
	painel_inimigo.visible = false
	texto.visible = false

func _on_Timer_timeout():
	janela_task.visible = false
	buttons_on()
	ocultar_resul()
	turn_on_the_player()
	is_pressed = true

func turn_on_the_player():
	var player = get_tree().get_root().find_node("Player", true, false)
	if player:
		player.set_active(true)

func turn_off_the_player():
	var player = get_tree().get_root().find_node("Player", true, false)
	if player:
		player.set_active(false)

func input_task(input_key):
	var a = InputMap.get_action_list(input_key)[0].as_text()
	
	if a.find("(Physical)") != -1:
		return a.split(" ")[0]
	else:
		return a

func _input(event):
	if janela_task.visible != false:
		if is_pressed:
			if event.is_action_pressed("Up"):
				res_player = 2
				painel_amigo.set_rotation_degrees(0)
				painel_amigo.frame = 2
				buttons_off()
				random_res_npc()
				process_resul()
				is_pressed = false
			
			elif event.is_action_pressed("Down"):
				res_player = 1
				painel_amigo.set_rotation_degrees(0)
				painel_amigo.frame = 1
				buttons_off()
				random_res_npc()
				process_resul()
				is_pressed = false
			
			elif event.is_action_pressed("Right"):
				res_player = 0
				painel_amigo.set_rotation_degrees(90)
				painel_amigo.frame = 0
				buttons_off()
				random_res_npc()
				process_resul()
				is_pressed = false
