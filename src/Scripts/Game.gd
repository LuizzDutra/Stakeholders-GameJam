extends Node2D

signal return_to_menu

onready var line = $Line2D
onready var npc = $NPC
onready var cluster = $positionCluster

func _process(delta):
	line.points = npc.nav_agent.get_nav_path()
	if Input.is_action_just_pressed("Return"):
		emit_signal("return_to_menu")
	
	if Input.is_action_just_pressed("ui_down"):
		var point = cluster.get_next_point()
		if point != null:
			npc.set_path_location(point)
