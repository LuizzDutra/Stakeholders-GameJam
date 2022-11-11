extends Node2D

signal return_to_menu

export(Resource) var dialog_file

onready var npcs = $YSort/Npcs
onready var clusters = $clusters
onready var sub_menu = $CanvasLayer
onready var introDialogue = $dialogo
var random_number = RandomNumberGenerator.new()
onready var player = $YSort/Player
onready var camera = $YSort/Player/Camera2D
onready var arrows = $Arrows
onready var target = null
onready var quest = $Quest

var dialogue_intro = []


var score = 0 setget set_score, get_score

func _ready():
	sub_menu.visible = false
	var clus_q = clusters.get_child_count()
	for i in range(55):
		random_number.randomize()
		var new_npc = load("res://Scenes/NPC.tscn").instance()
		new_npc.position = player.position
		#print(dialog_file.dialog_text)
		new_npc.dialogo_npc = dialog_file.dialog_text[random_number.randi_range(0, len(dialog_file.dialog_text)-1)]
		
		new_npc.class_cluster = clusters.get_child(i%clus_q)
		
		npcs.add_child(new_npc)
	get_node("AudioStreamPlayer").play()
	for i in range(npcs.get_child_count()):
		if npcs.get_child(i).class_cluster != null:
			npcs.get_child(i).wander_state = false
			npcs.get_child(i).position = npcs.get_child(i).class_cluster.get_next_point()[0]
			npc_set_path_cluster(npcs.get_child(i).class_cluster, npcs.get_child(i))
		
	get_node("YSort/armario/Area2D/puzzle_luiza").connect("missao_concluida", get_node("YSort/unity"), "_on_missao_concluida")
	
	get_node("YSort/armario_azul/Area2D/puzzle_cadeirante").connect("concluida", get_node("YSort/cadeirante"), "_on_missao_concluida")
	
	#dialogo intro
	var player_name = player.data_player.get_data()["nome"]
	dialogue_intro = [
	{"name":"Professor","text":"Por hoje é só pessoal, agora é hora do intervalo."},
	{"name":player_name,"text":"Hã?"},
	{"name":player_name,"text":"..."},
	{"name":player_name,"text":"Eu dormi na aula de novo."},
	{"name":player_name,"text":"Mas que sonho estranho."},
]

func _process(_delta):
	if get_parent().get_node_or_null("CanvasLayer/Menu"):
		if not get_parent().get_node("CanvasLayer/Menu").config_menu.visible:
			sub_menu.visible = false
	
	
	#var target = null
	if target != null:
		arrows.get_node("pivot").global_position = player.global_position
		var rot = target.global_position - arrows.get_node("pivot").global_position
		arrows.get_node("pivot").rotation = rot.angle()
		
		if target.get_node("Area2D") in camera.get_node("Area2D").get_overlapping_areas():
			arrows.get_node("pivot").visible = false
			arrows.get_node("hoverarrow").visible = true
			arrows.get_node("hoverarrow").global_position = target.global_position
		else:
			arrows.get_node("pivot").visible = true
			arrows.get_node("hoverarrow").visible = false
	else:
		arrows.get_node("pivot").visible = false
		arrows.get_node("hoverarrow").visible = false

func _input(event):
	if event.is_action_pressed("Return") and get_parent().get_node_or_null("CanvasLayer/Menu"):
		if sub_menu.visible:
			get_parent().get_node("CanvasLayer/Menu").config_menu.visible = false
			sub_menu.visible = false
		else:
			sub_menu.visible = true
			get_parent().get_node("CanvasLayer/Menu").show_in_game_menu()
		get_tree().set_input_as_handled()

#desapega npc do cluster faz andar para qualquer posição
func npc_set_path(npc, pos):
	if npc.cur_cluster != null:
		npc.cur_cluster.free_point(npc.cluster_index)
		npc.cluster_index = -1
		npc.cur_cluster = null
	npc.set_path_location(pos)


#função usada para fazer o npc ir para uma posição disponivel em um cluster
#a ordem é equivalente a que os filhos foram criados -> colocados à mão > código
func npc_set_path_cluster(cluster, npc, overwite = true, best_pos = false):
	var point = cluster.get_next_point()
	#print(npc.cluster_index)
	#print(point)
	if point != null:
		if npc.cur_cluster == null:
			npc.cur_cluster = cluster
		if npc.cur_cluster != cluster:
			#o overwrite permite o npc mudar de cluster
			if not overwite:
				return
			else:
				if npc.cluster_index >= 0:
					npc.cur_cluster.free_point(npc.cluster_index)
					npc.cluster_index = -1
					npc.cur_cluster = cluster

		if npc.cluster_index >= 0:
			if best_pos and (npc.cluster_index > point[1]):
				return
			#print("hey")
			cluster.free_point(npc.cluster_index)
		npc.set_path_location(point[0])
		npc.cluster_fac = cluster.facing
		npc.cluster_index = point[1]
		cluster.occup_point(point[1])
		#print(npc.cluster_pos, npc.cluster_index)

func set_score(value, soma = true):
	if soma:
		score += value
	else:
		score = value

func get_score():
	return score

func _on_clock_class_signal():
	for i in range(npcs.get_child_count()):
		if npcs.get_child(i).class_cluster != null:
			npcs.get_child(i).wander_state = false
			npc_set_path_cluster(npcs.get_child(i).class_cluster, npcs.get_child(i))


func _on_clock_interval_signal():
	for i in range(npcs.get_child_count()):
		npcs.get_child(i).wander_state = true
		#npc_set_path(npcs.get_child(i), Vector2(rand_range(-100, 100), rand_range(-100, 100)))


func _on_clock_lunch_signal():
	for i in range(npcs.get_child_count()):
		npcs.get_child(i).wander_state = false
		npc_set_path_cluster(npcs.get_child(i).class_cluster, npcs.get_child(i))


func _on_Button_pressed():
	emit_signal("return_to_menu")


func _on_introTimer_timeout():
	introDialogue.play_dialog(dialogue_intro)
