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
var wander_delay = 8
var wander_range = 300
var delay_rand = 3

var dialogo_npc

var skin_color_array = [Color(0.32549, 0.239216, 0.172549), Color(0.785156, 0.622526, 0.496857), \
						Color(0.664063, 0.463593, 0.308685), Color(0.84375, 0.745211, 0.669067), \
						Color(0.347656, 0.163033, 0.02037)]
	
var hair_color_array = [Color(0.568627, 0.070588, 0.070588), Color(0.21875, 0.134856, 0.067505), \
						Color(0.808594, 0.626507, 0.312698), Color(0.757813, 0.347084, 0.100647)]

var eyes_color_array = [Color(0.141176, 0.047059, 0), Color(0, 0.371094, 0.59375), Color(0, 0, 0),\
						Color(0.619608, 0.611765, 0.32549)]

#referencia que indica a sala do npc
var class_cluster

func _ready():
	sprite.frames = load(sprite_path + str((randi() % 4)+1) + ".tres")
	#sprite.frames = load(sprite_path + "3.tres")
	sprite.play("idle")
	var color = skin_color_array[randi() % len(skin_color_array)]
	sprite.get_material().set_shader_param("skin_modulate", color)
	color = hair_color_array[randi() % len(hair_color_array)]
	sprite.get_material().set_shader_param("hair_modulate", color)
	color = eyes_color_array[randi() % len(eyes_color_array)]
	sprite.get_material().set_shader_param("eyes_modulate", color)

func _physics_process(delta):
	if wander_state and nav_agent.is_navigation_finished() and not hitbox_npc.get_node("dialogo").dialog_ativo:
		if wander_timer.is_stopped():
			var rand_path = position + Vector2(rand_range(-wander_range, wander_range), rand_range(-wander_range, wander_range))
			set_path_location(rand_path)
			#if !nav_agent.is_target_reachable():
			#	moving = false
			wander_start_timer()
	
	if not wander_state:
		if cur_cluster != null:
			sprite.scale.x = cur_cluster.facing
	
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
		print(hitbox_npc.get_node("dialogo").dialog_file.player_name)
		dialogue_player.play_dialog(dialogo_npc)
