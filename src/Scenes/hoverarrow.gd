extends Position2D

onready var sprite = $Sprite

var start = 0
export var sway = 10
export var speed = 1.5
export var offset = -40

func _process(delta):
	start += delta
	sprite.position.y = offset + (sway * sin(start * PI * speed))
