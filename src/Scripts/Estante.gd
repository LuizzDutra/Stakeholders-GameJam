extends StaticBody2D

onready var dialogo = $dialogo

var interact_id = "prop"
var descr = [{"name": "", "text":"O diretor possui vários livros e até um prêmio de melhor escola do ano!"}]

func interact():
	dialogo.play_dialog(descr)
