extends Node2D

var pos_quant := 0
var pos_states := []
var facing = 0 setget set_facing
#var random = false

func _ready():
	pos_quant = get_child_count()
	for i in range(pos_quant):
		var child = get_child(i) 
		child.position = global_position + child.position
		pos_states.append(0)

func create_points(quant, xoffset, yoffset):
	for i in range(quant):
		var pos_node = Position2D.new()
		pos_node.position = Vector2(global_position.x + i*xoffset, global_position.y + i*yoffset)
		add_child(pos_node)
		pos_states.append(0)
	pos_quant = get_child_count()

func free_point(index):
	pos_states[index] = 0

func occup_point(n):
	pos_states[n] = 1

func get_next_point():
	var ind = pos_states.find(0)
	if ind != -1:
		return [get_child(ind).position, ind].duplicate()
		

func set_facing(n):
	facing = n % 4
