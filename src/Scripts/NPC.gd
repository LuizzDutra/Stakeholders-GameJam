extends KinematicBody2D

onready var nav_agent = $NavigationAgent2D

var speed = 200
var vel = Vector2.ZERO
var dir = Vector2.ZERO
var moving = false

func _physics_process(delta):
	if Input.is_action_pressed("click"):
		set_path_location(get_global_mouse_position())
	if moving:
		dir = position.direction_to(nav_agent.get_next_location())
		vel = dir * speed
		vel = move_and_slide(vel)

func set_path_location(location):
	nav_agent.set_target_location(location)
	nav_agent.get_next_location()
	moving = true

func _on_NavigationAgent2D_navigation_finished():
	moving = false

	
