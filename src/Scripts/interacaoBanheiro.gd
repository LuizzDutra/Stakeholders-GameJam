extends Node2D

onready var dialogo = $dialogo

var descr = [{"name": "", "text":"Apenas cabines de banheiro."}, {"name": "", "text":"Parece bem limpo para um banheiro de escola."}]

var interact_id = "prop"


func interact():
	dialogo.play_dialog(descr)
