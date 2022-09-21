extends Control

onready var buttons = $Buttons
onready var config_menu = $configMenu
onready var cust_menu = $cust
onready var pickers = $cust/pickers
onready var clickSound = $clickSound
onready var sprites = $cust/Sprites
onready var vol_sliders = $configMenu/VolSliders
onready var gotinha = $configMenu/VideoPlayer
onready var musica_brega = $Musicabrega
onready var Musica_default = $MusicaPadrao
onready var musica_loop = $MusicaLoop
var player_data = load("res://resources/data_cust.tres")
var font_default = load("res://Fonts/font_default.tres")
var font_dyslexic = load("res://Fonts/font_dyslexic.tres")
signal start_game
signal info_saved(s_var, info)
signal daltonic_change(index)
signal dalt_int_change(value)

func _ready():
	visible = true
	config_menu.visible = false
	buttons.visible = true
	cust_menu.visible = false
	cust_menu.get_node("LineEdit").text = player_data.data["nome"]
	load_picker_color()

func load_picker_color():
	#seta a cor dos color pickers
	pickers.get_node("bodyPicker").color = sprites.get_node("Body").modulate
	pickers.get_node("hairPicker").color = sprites.get_node("Hair").modulate
	pickers.get_node("eyesPicker").color = sprites.get_node("Eyes").get_material().get_shader_param("modulate")


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


func _on_hairPicker_color_changed(color):
	cust_menu.get_node("Sprites").get_node("Hair").modulate = color
	save_color_info(color, "Hair")


func _on_eyesPicker_color_changed(color):
	cust_menu.get_node("Sprites").get_node("Eyes").get_material().set_shader_param("modulate", color)
	save_color_info(color, "Eyes")


func _on_Button2_pressed():
	sprites.data_player.reset_to_default()
	sprites.load_modulate()
	load_picker_color()
	


func _on_modoDalto_item_selected(index):
	emit_signal("daltonic_change", index - 1)


func _on_HSlider_value_changed(value):
	emit_signal("dalt_int_change", value)


func _on_mestre_drag_ended(value_changed):
	if value_changed:
		var value = linear2db(vol_sliders.get_node("mestre").value)
		#print(value)
		AudioServer.set_bus_volume_db(0, value)


func _on_efeitos_drag_ended(value_changed):
	if value_changed:
		var value = linear2db(vol_sliders.get_node("efeitos").value)
		#print(value)
		AudioServer.set_bus_volume_db(1, value)


func _on_musica_drag_ended(value_changed):
	if value_changed:
		var value = linear2db(vol_sliders.get_node("musica").value)
		#print(value)
		AudioServer.set_bus_volume_db(2, value)


func _on_LineEdit_text_changed(new_text):
	emit_signal("info_saved", "nome", new_text)


func _on_VideoPlayer_finished():
	gotinha.play()


func _on_gotinhaButton_toggled(button_pressed):
	if button_pressed:
		gotinha.visible = true
		gotinha.play()
		#musica_brega.play()
		Musica_default.stop()
		musica_loop.stop()
	else:
		gotinha.visible = false
		gotinha.stop()
		musica_loop.stop()
		Musica_default.play()


func _on_MusicaPadrao_finished():
	if !gotinha.visible:
		musica_loop.play()
	
