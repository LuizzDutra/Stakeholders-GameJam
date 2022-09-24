extends Resource

class_name metadata

export var player_name: String = "Eu" setget changePlayerName

export var dialog_text: Array = [
	[{"name":"","text":"Olá Meu nome é Bill"}],
	[{"name":"","text":"Eae meu amigo como vai seu dia ?"}],
	[{"name":"","text":"Olá " + str(player_name) + "vc viu o Bill em algum Lugar ?"}],
	[{"name":"","text":"Bora bill kkkkk"}],
	[{"name":"", "text":"Bom dia meu amor : )"}],
	[{"name":"", "text":"Lucas se fudeu kkkk. Ele não estudou para o teste de Karlas"}]
]

func updateDialog():
	dialog_text = [
	[{"name":"","text":"Olá Meu nome é Bill"}],
	[{"name":"","text":"Eae meu amigo como vai seu dia ?"}],
	[{"name":"","text":"Olá " + str(player_name) + " vc viu o Bill em algum Lugar ?"}],
	[{"name":"","text":"Bora bill kkkkk"}],
	[{"name":"", "text":"Bom dia meu amor : )"}],
	[{"name":"", "text":"Lucas se fudeu kkkk. Ele não estudou para o teste de Karlas"}]
]

func changePlayerName(nome):
	player_name = nome
	updateDialog()
	
