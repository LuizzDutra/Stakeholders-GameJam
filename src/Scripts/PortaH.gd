extends StaticBody2D

var open = false
onready var left = $ColLeft
onready var right = $ColRight
onready var door = $ColDoor
onready var area = $Area2D
onready var sprite =$Sprite
onready var som = $somPorta

func _process(delta):
	if len(area.get_overlapping_areas()) > 0:
		if !open:
			som.play()
		open = true
		sprite.frame = 1
		door.set_deferred("disabled", true)
	else:
		if open:
			som.play()
		open = false
		sprite.frame = 0
		door.set_deferred("disabled", false)
