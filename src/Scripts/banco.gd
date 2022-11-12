extends StaticBody2D

onready var dialogo = $dialogo

var interact_id = "prop"

var descr = [{"name": "", "text":"É um simples banco de madeira"}, {"name": "", "text":"Mesmo assim é bastante confortável"}]

func interact():
	dialogo.play_dialog(descr)
