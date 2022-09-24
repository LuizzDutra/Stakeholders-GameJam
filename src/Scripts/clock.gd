extends Node2D

signal class_signal
signal interval_signal
signal lunch_signal

onready var signalDelay = $signalDelay

var clock_running := true
var time := 0.0

export var timescale := 10
export var class_time := []
export var interval_time := [150]
export var lunch_time := []

func _process(delta):
	if clock_running:
		time += delta * timescale
		#print(time)
	
	if signalDelay.is_stopped():
		if int(time) in class_time:
			signalDelay.start()
			emit_signal("class_signal")
		if int(time) in interval_time:
			signalDelay.start()
			emit_signal("interval_signal")
		if int(time) in lunch_time:
			signalDelay.start()
			emit_signal("lunch_signal")
