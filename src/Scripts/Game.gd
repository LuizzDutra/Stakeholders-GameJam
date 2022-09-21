extends Node2D

signal return_to_menu

export(Resource) var dialog_file

onready var npcs = $YSort/Npcs
onready var my_cluster = $positionCluster
onready var my_cluster2 = $positionCluster2
var random_number = RandomNumberGenerator.new()
onready var player = $YSort/Player

var score = 0 setget set_score, get_score

func _ready():
	for i in range(15):
		random_number.randomize()
		var new_npc = load("res://Scenes/NPC.tscn").instance()
		new_npc.position = player.position
		new_npc.dialogo_npc = dialog_file.dialog_text[random_number.randi_range(0,5)]
		if i % 2 == 0:
			new_npc.class_cluster = my_cluster2
		else:
			new_npc.class_cluster = my_cluster
		npcs.add_child(new_npc)

func _process(_delta):
	if Input.is_action_just_pressed("Return"):
		emit_signal("return_to_menu")
	
	if Input.is_action_pressed("click"):
		for i in range(npcs.get_child_count()):
			npc_set_path(npcs.get_child(i), get_global_mouse_position())
		#print(my_cluster.pos_states)
	
	if Input.is_action_just_pressed("ui_down"):
		for i in range(npcs.get_child_count()):
			npc_set_path_cluster(my_cluster, npcs.get_child(i))
			npcs.get_child(i).wander_state = true
	
	if Input.is_action_just_pressed("ui_up"):
		_on_clock_class_signal()

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
		npc_set_path_cluster(my_cluster, npcs.get_child(i))
