extends Area2D


var active = true

func interact():
	active = false
	get_node("Timer").start()

func _on_Timer_timeout():
	print("uhu")
	active = true
