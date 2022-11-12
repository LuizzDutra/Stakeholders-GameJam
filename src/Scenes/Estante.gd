extends StaticBody2D

var interact_id = "prop"
var descr = [{"name":"", "text":"O diretor guarda vários livros aqui."}, {"name":"", "text":"Ele tem um prêmio de melhor escola do ano!"}]
onready var dialogo = $dialogo


func interact():
	dialogo.play_dialog(descr)
