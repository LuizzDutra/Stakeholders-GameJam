extends Node2D

var pos_quant := 0
var pos_states := []
export var quantity = 0
export var xoffset = 30
export var yoffset = 0
export var facing = -1 setget set_facing
#var random = false

func _ready():
	create_points(quantity, xoffset, yoffset)

func create_points(quant, x, y):
	pos_states = [] 
	pos_quant = 0
	for i in range(quant):
		var pos_node = Position2D.new()
		pos_node.position = Vector2(global_position.x + i*x, global_position.y + i*y)
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
	else:
		return[Vector2.ZERO, 0]
		
func set_facing(n):
	if n <= 0:
		facing = -1
	else:
		facing = 1
