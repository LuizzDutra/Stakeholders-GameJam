extends Node2D

onready var hitbox_lixo = $Area2D
onready var anima_lixo = $AnimatedSprite
var random = RandomNumberGenerator.new()

func _ready():
	random.randomize()
	anima_lixo.frame = random.randi_range(0,4)
