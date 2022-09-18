extends KinematicBody2D

onready var nav_agent = $NavigationAgent2D
onready var wander_timer = $WanderTimer

var speed = 200
var vel = Vector2.ZERO
var dir = Vector2.ZERO
var moving = false
var cur_cluster
var cluster_fac := 0
var cluster_index := -1

var wander_state = false setget wander_set_timer
var wander_delay = 5
var wander_range = 100
var delay_rand = 3

#referencia que indica a sala do npc
var class_cluster

func _physics_process(delta):
	if wander_state and nav_agent.is_navigation_finished():
		if wander_timer.is_stopped():
			var rand_path = position + Vector2(rand_range(-wander_range, wander_range), rand_range(-wander_range, wander_range))
			set_path_location(rand_path)
			#if !nav_agent.is_target_reachable():
			#	moving = false
			wander_start_timer()
	
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

func wander_start_timer():
	wander_timer.wait_time = rand_range(wander_delay-delay_rand, wander_delay+delay_rand)
	wander_timer.start()

func wander_set_timer(state):
	if state:
		wander_start_timer()
	wander_state = state

