extends Resource

class_name metadata

export var player_name: String = "Gab" setget changePlayerName

export var dialog_text: Array = []

func _ready():
	updateDialog()

func updateDialog():
	dialog_text = [
	[{"name":"","text":"E aí?."}],
	[{"name":"","text":str(player_name) + " na escola? Vai chover."}],
	[{"name":"","text":"Dally, " + str(player_name) + " de boa?"}],
	[{"name":"","text":"Bom dia."}],
	[{"name":"", "text":"Que aula chata."}],
	[{"name":"", "text":"O dia tá lindo, clima ensolarado..."}],
	[{"name":"", "text":"Opa."}],
	[{"name":"", "text":"Qual a boa?"}]
]

func changePlayerName(nome):
	player_name = nome
	updateDialog()
	
