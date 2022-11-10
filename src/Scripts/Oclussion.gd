extends Node2D

onready var panels = get_children()
onready var player = get_parent().get_node("YSort/Player")

func _process(delta):
	for i in panels:
		if player.get_node("Area2D") in i.get_overlapping_areas():
			i.visible = false
		else:
			i.visible = true
			
	

func _ready():
	for i in panels:
		var rect = i.get_node("ColorRect")
		var area = i.get_node("CollisionShape2D")
		rect.rect_size = area.shape.extents*2
		rect.rect_global_position = area.global_position - area.shape.extents
		
		
