extends KinematicBody2D

var dir = Vector2.ZERO
var vel = Vector2.ZERO
var speed = 300
var frict = 2400
var acel = 1200 + frict

func _process(delta):
	#print(dir)
	
	dir.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	dir.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	
	vel += dir * acel * delta
	vel = vel.move_toward(Vector2.ZERO, frict * delta)
	vel = vel.limit_length(speed)
	#print(vel)
	vel = move_and_slide(vel)
