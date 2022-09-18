extends KinematicBody2D

onready var nav_agent = $NavigationAgent2D

var speed = 200
var vel = Vector2.ZERO
var dir = Vector2.ZERO
var moving = false
var cur_cluster
var cluster_pos: Vector2
var cluster_index := -1

func _physics_process(delta):
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

	
