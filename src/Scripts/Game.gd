extends Node2D

signal return_to_menu

onready var line = $Line2D
onready var npcs = $Npcs
onready var my_npc = $Npcs/NPC
onready var my_cluster = $positionCluster
onready var my_cluster2 = $positionCluster2
onready var player = $Player

func _ready():
	for i in range(15):
		var new_npc = load("res://Scenes/NPC.tscn").instance()
		new_npc.position = player.position
		npcs.add_child(new_npc)

func _process(delta):
	if Input.is_action_just_pressed("Return"):
		emit_signal("return_to_menu")
	
	if Input.is_action_pressed("click"):
		for i in range(npcs.get_child_count()):
			npc_set_path(npcs.get_child(i), get_global_mouse_position())
		#print(my_cluster.pos_states)
	
	if Input.is_action_just_pressed("ui_down"):
		for i in range(npcs.get_child_count()):
			npc_set_path_cluster(my_cluster, npcs.get_child(i))
	
	if Input.is_action_just_pressed("ui_up"):
		for i in range(npcs.get_child_count()):
			npc_set_path_cluster(my_cluster2, npcs.get_child(i))

#desapega npc do cluster faz andar para qualquer posição
func npc_set_path(npc, pos):
	if npc.cur_cluster != null:
		npc.cur_cluster.free_point(npc.cluster_index)
		npc.cluster_index = -1
		npc.cur_cluster = null
	npc.set_path_location(pos)


#função usada para fazer o npc ir para uma posição disponivel em um cluster
#a ordem é equivalente a que os filhos foram criados -> colocados à mão > código
func npc_set_path_cluster(cluster, npc, overwite = true):
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
			#print("hey")
			cluster.free_point(npc.cluster_index)
		npc.set_path_location(point[0])
		npc.cluster_pos = point[0]
		npc.cluster_index = point[1]
		cluster.occup_point(point[1])
		#print(npc.cluster_pos, npc.cluster_index)
