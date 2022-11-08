extends StaticBody2D

var open = false
onready var left = $ColLeft
onready var right = $ColRight
onready var door = $ColDoor
onready var area = $Area2D
onready var sprite =$Sprite

func _process(delta):
	if len(area.get_overlapping_areas()) > 0:
		open = true
		sprite.frame = 1
		door.set_deferred("disabled", true)
	else:
		open = false
		sprite.frame = 0
		door.set_deferred("disabled", false)
