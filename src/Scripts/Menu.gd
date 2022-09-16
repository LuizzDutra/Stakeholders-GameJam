extends Control

onready var buttons = $Buttons
onready var config_menu = $configMenu
onready var cust_menu = $cust
onready var clickSound = $clickSound
var font_default = load("res://Fonts/font_default.tres")
var font_dyslexic = load("res://Fonts/font_dyslexic.tres")
signal start_game
signal info_saved(s_var, color)

func _ready():
	visible = true
	config_menu.visible = false
	buttons.visible = true
	cust_menu.visible = false
	cust_menu.get_node("bodyPicker").color = cust_menu.get_node("Sprites").get_node("Body").modulate

func _on_Start_pressed():
	buttons.visible = false
	cust_menu.visible = true
	clickSound.play()
	#emit_signal("start_game")

func _on_Config_pressed():
	buttons.visible = false
	config_menu.visible = true
	clickSound.play()

func _on_configBack_pressed():
	buttons.visible = true
	config_menu.visible = false
	clickSound.play()

func _on_Create_pressed():
	clickSound.play()
	emit_signal("start_game")

func _on_dislexieCheck_toggled(button_pressed):
	if button_pressed:
		theme.default_font = font_dyslexic
	else:
		theme.default_font = font_default
	clickSound.play()

func _on_Button_pressed():
	_ready()
	clickSound.play()
	
func save_color_info(color, s_var):
	emit_signal("info_saved", s_var + "_color", color)

func _on_bodyPicker_color_changed(color):
	cust_menu.get_node("Sprites").get_node("Body").modulate = color
	save_color_info(color, "Body")


func _on_bodyPicker_pressed():
	clickSound.play()
