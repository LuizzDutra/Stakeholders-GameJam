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
onready var slider_timer = $configMenu/VolSliders/Timer
var player_data = load("res://resources/data_cust.tres")
var font_default = load("res://Fonts/font_default.tres")
var font_dyslexic = load("res://Fonts/font_dyslexic.tres")
var dialog_file = load("res://dialogo/ncp_dialog.tres")
var sprite_path = "res://spriteFrames/spriteframe"
var selected_sprite = 0
var in_game = false
signal start_game
signal info_saved(s_var, info)
signal daltonic_change(index)
signal dalt_int_change(value)

func _ready():
	visible = true
	get_node("TextureRect").visible = true
	AudioServer.set_bus_volume_db(2, linear2db(0.5))
	vol_sliders.get_node("musica").value = db2linear(AudioServer.get_bus_volume_db(2))
	config_menu.visible = false
	buttons.visible = true
	cust_menu.visible = false
	cust_menu.get_node("LineEdit").text = player_data.data["nome"]
	dialog_file.player_name = player_data.data["nome"]
	sprites.frames = load(sprite_path + "1.tres")
	in_game = false
	Musica_default.play()
	load_picker_color()


func show_in_game_menu():
	visible = true
	get_node("TextureRect").visible = false
	cust_menu.visible = false
	buttons.visible = false
	config_menu.visible = true
	in_game = true

func load_picker_color():
	#seta a cor dos color pickers
	if sprites.get_material():
		pickers.get_node("bodyPicker").color = sprites.get_material().get_shader_param("skin_modulate")
		pickers.get_node("hairPicker").color = sprites.get_material().get_shader_param("hair_modulate")
		pickers.get_node("eyesPicker").color = sprites.get_material().get_shader_param("eyes_modulate")


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
	if not in_game:
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
	sprites.get_material().set_shader_param("skin_modulate", color)
	save_color_info(color, "Body")


func _on_bodyPicker_pressed():
	clickSound.play()


func _on_hairPicker_color_changed(color):
	sprites.get_material().set_shader_param("hair_modulate", color)
	save_color_info(color, "Hair")


func _on_eyesPicker_color_changed(color):
	sprites.get_material().set_shader_param("eyes_modulate", color)
	save_color_info(color, "Eyes")
	


func _on_modoDalto_item_selected(index):
	emit_signal("daltonic_change", index - 1)


func _on_HSlider_value_changed(value):
	emit_signal("dalt_int_change", value)



func _on_LineEdit_text_changed(new_text):
	dialog_file.player_name = new_text
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
	if !gotinha.visible and !get_parent().get_parent().cutscene_active:
		musica_loop.play()
	


func _on_bodyButton_pressed():
	if selected_sprite <= 0:
		selected_sprite = 3
	else:
		selected_sprite -= 1
	sprites.frames = load(sprite_path + str(selected_sprite+1) + ".tres")
	emit_signal("info_saved", "sprite_frame", selected_sprite)


func _on_bodyButton2_pressed():
	selected_sprite = (selected_sprite + 1) % 4
	sprites.frames = load(sprite_path + str(selected_sprite+1) + ".tres")
	emit_signal("info_saved", "sprite_frame", selected_sprite)



func _on_mestre_value_changed(value):
	if value and slider_timer.is_stopped():
		var new_value = linear2db(vol_sliders.get_node("mestre").value)
		AudioServer.set_bus_volume_db(0, new_value)


func _on_musica_value_changed(value):
	if value and slider_timer.is_stopped():
		var new_value = linear2db(vol_sliders.get_node("musica").value)
		AudioServer.set_bus_volume_db(2, new_value)


func _on_efeitos_value_changed(value):
	if value and slider_timer.is_stopped():
		var new_value = linear2db(vol_sliders.get_node("efeitos").value)
		AudioServer.set_bus_volume_db(1, new_value)
