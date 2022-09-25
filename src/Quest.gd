extends CanvasLayer

onready var quest = $quest
onready var slot_quests = $quest/slot_quests


func _ready():
	quest.visible = false
func _input(event):
	
	if event.is_action_pressed("quest"):
		
		if quest.visible == true:
			quest.visible = false
			return
		quest.visible = true

func check_quest(descr_quest):
	
	for r in slot_quests.get_children():
		
		if r.bbcode_text == descr_quest:
			return true
	return false

func add_quest(descr_quest: String):

	for r in slot_quests.get_children():
		
		if check_quest(descr_quest):
			return
			
		if r.bbcode_text == "":
			r.bbcode_text = descr_quest
			
func kill_quest(descr_quest:String):
	
	for r in slot_quests.get_children():
		
		if r.bbcode_text == descr_quest:
			r.bbcode_text = "[color=#006400]"+descr_quest+"[/color]"
