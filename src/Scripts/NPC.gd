extends KinematicBody2D

onready var nav_agent = $NavigationAgent2D
onready var wander_timer = $WanderTimer
onready var hitbox_npc = $Area2D
onready var sprite = $AnimatedSprite

var sprite_path = "res://spriteFrames/spriteframe"

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

var dialogo_npc

#referencia que indica a sala do npc
var class_cluster

func _ready():
	sprite.frames = load(sprite_path + str((randi() % 4)+1) + ".tres")
	sprite.play("idle")

func _physics_process(delta):
	if wander_state and nav_agent.is_navigation_finished() and not hitbox_npc.get_node("dialogo").dialog_ativo:
		if wander_timer.is_stopped():
			var rand_path = position + Vector2(rand_range(-wander_range, wander_range), rand_range(-wander_range, wander_range))
			set_path_location(rand_path)
			#if !nav_agent.is_target_reachable():
			#	moving = false
			wander_start_timer()
	
	if moving:
		dir = position.direction_to(nav_agent.get_next_location())
		if dir.x != 0:
			if dir.x < 0:
				sprite.scale.x = -1
			if dir.x > 0:
				sprite.scale.x = 1
		vel = dir * speed
		if vel != Vector2.ZERO:
			sprite.play("walk")
		else:
			sprite.play("idle")
		vel = move_and_slide(vel)
	else:
		sprite.play("idle")

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

func _input(event):
	if event.is_action_pressed("space") and len(hitbox_npc.get_overlapping_areas()) > 0:
		find_and_use_dialogue()
		
func find_and_use_dialogue():
	var dialogue_player = get_node_or_null("Area2D/dialogo")
	if dialogue_player:
		dialogue_player.play_dialog(dialogo_npc)
