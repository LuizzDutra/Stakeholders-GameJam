extends Control

onready var buttons = $Buttons
onready var config_menu = $configMenu
onready var cust_menu = $cust
signal start_game

func _ready():
	config_menu.visible = false
	buttons.visible = true

func _on_Start_pressed():
	buttons.visible = false
	cust_menu.visible = true
	#emit_signal("start_game")

func _on_Config_pressed():
	buttons.visible = false
	config_menu.visible = true

func _on_configBack_pressed():
	buttons.visible = true
	config_menu.visible = false

func _on_Create_pressed():
	emit_signal("start_game")
