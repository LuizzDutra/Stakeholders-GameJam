extends StaticBody2D

var interact_id = "prop"
var descr = [{"name":"", "text":"Um belo banco de madeira, é bem comfortável."}]
onready var dialogo = $dialogo


func interact():
	dialogo.play_dialog(descr)
