extends StaticBody2D

onready var dialogo = $dialogo
var interact_id = "quest"

var dial = [{"name":"", "text":"Você faz uma rampa a melhor das suas habilidades"}]

func interact():
	dialogo.play_dialog()
	
