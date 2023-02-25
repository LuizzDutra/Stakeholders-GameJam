extends Position2D

onready var sprite = $Sprite

var interact_id = "quest"
var switch = true

func interact():
	sprite.visible = true
	if switch:
		get_tree().get_root().get_node("Global/Game").get_node("YSort/cadeirante").dialog_state = 9
		get_tree().get_root().get_node("Global/Game").get_node("YSort/diretor").dialog_state = 7
		get_tree().get_root().get_node("Global/Game").target = get_tree().get_root().get_node("Global/Game/YSort/cadeirante")
		switch = !switch
	
