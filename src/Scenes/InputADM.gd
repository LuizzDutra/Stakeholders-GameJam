extends ColorRect


var cur_action = null
var cur_event = null
var cur_button = null
var old_event = null

var key_count = 0

signal action_edited()

func _ready():
	deactivate()

func _process(delta):
	pass

func activate(action, buttonRef:Button):
	visible = true
	cur_action = action
	cur_button = buttonRef
	if len(InputMap.get_action_list(cur_action)) < 1:
		get_node("ColorRect/InputLabel").text = ""
	else:
		get_node("ColorRect/InputLabel").text = InputMap.get_action_list(cur_action)[0].as_text()
		#retira a tipagem "physical" da string
		var phys_find = get_node("ColorRect/InputLabel").text.rfind(" (Physical)")
		if phys_find != -1:
			get_node("ColorRect/InputLabel").text = get_node("ColorRect/InputLabel").text.left(phys_find)
	set_process_input(true)

func deactivate():
	visible = false
	cur_action = null
	cur_button = null
	cur_event = null
	get_node("ColorRect/InputLabel").text = ""
	set_process_input(false)

func _input(event):
	if event is InputEventKey:
		if event.physical_scancode != KEY_ENTER and  event.physical_scancode != KEY_TAB and event.is_pressed():
			cur_event = event
			get_node("ColorRect/InputLabel").text = cur_event.as_text()
		if event.physical_scancode == KEY_ENTER and event.is_pressed():
			if cur_event != null:
				InputMap.action_erase_events(cur_action)
				InputMap.action_add_event(cur_action, cur_event)
				#cur_button.text = cur_event.as_text()
				emit_signal("action_edited")
					
			deactivate()
		if event.physical_scancode == KEY_TAB and event.is_pressed():
			deactivate()
