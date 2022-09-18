extends KinematicBody2D

export(Resource) var data_player

var dir = Vector2.ZERO
var vel = Vector2.ZERO
var speed = 300
var frict = 2400
var acel = 1200 + frict
var interactable = null

func _ready():
	load_modulate()

func load_modulate():
	var r_data = data_player.get_data()
	get_node("Sprites/Body").modulate = r_data["Body_color"]
	get_node("Sprites/Hair").modulate = r_data["Hair_color"]
	get_node("Sprites/Eyes").get_material().set_shader_param("modulate", r_data["Eyes_color"])


func _process(delta):
	#print(dir)
	dir.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	dir.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	
	vel += dir * acel * delta
	vel = vel.move_toward(Vector2.ZERO, frict * delta)
	vel = vel.limit_length(speed)
	#print(vel)
	vel = move_and_slide(vel)


func interact():
	print(interactable)
	if interactable != null:
		if interactable.has_method("interact"):
			interactable.interact()

func _on_InteractArea_area_entered(area):
	interactable = area


func _on_InteractArea_area_exited(area):
	if area == interactable:
		interactable = null
