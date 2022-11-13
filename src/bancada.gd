extends StaticBody2D

onready var painel_build = $task_cadeirante_2
var interact_id = "quest"


func _ready():
	pass

func interact():
	painel_build.show_build_painel()
