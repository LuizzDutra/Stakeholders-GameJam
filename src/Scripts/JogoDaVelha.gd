extends Control

onready var pos_list = get_node("Positions").get_children()
onready var reset_timer = $ResetTimer

var table = [0, 0, 0, 0, 0, 0, 0, 0, 0]
var paused = false

var check_list = [[0, 1], [3, 1], [6, 1], [0, 3], [1, 3], [2, 3], [0, 4], [2, 2]]

signal ended(win)


func mark(n):
	print("here")
	if not paused:
		if table[n] == 0:
			table[n] = 1
			pos_list[n].text = "X"
			print(table)
			check_score()
			if not paused:
				ai_mark()
				print(table)
				check_score()

func ai_mark():
	while true:
		var choices = []
		for i in check_list:
			var j = ai_step_table_check(i[0], i[1])
			print(j)
			if j != null:
				choices.append(j)
		if choices.size() > 0:
			var pos = choices[randi() % choices.size()]
			table[pos] = 2
			pos_list[pos].text = "O"
			return
		else:
			while true:
				var j = randi() % 9
				if table[j] == 0:
					table[j] = 2
					pos_list[j].text = "O"
					return

func ai_step_table_check(start, step):
	var n = null
	#check passivo
	if table[start] + table[start+step] + table[start+step*2] == 2:
		if table[start] == 1 or table[start+step] == 1 or table[start+step*2] == 1:
			if table[start] == 0:
				n = start
			elif table[start+step] == 0:
				n = start+step
			elif table[start+step*2] == 0:
				n = start+step*2
			return n
	
	
	#check ofensivo
	if table[start] + table[start+step] + table[start+step*2] == 4:
		if table[start] == 0:
			n = start
		elif table[start+step] == 0:
			n = start+step
		elif table[start+step*2] == 0:
			n = start+step*2
	return n

func check_score():
	if table[0] != 0 && table[0] == table[1] && table[1] == table[2]:
		score(table[0])
	if table[3] != 0 && table[3] == table[4] && table[4] == table[5]:
		score(table[3])
	if table[6] != 0 && table[6] == table[7] && table[7] == table[8]:
		score(table[6])
		
	if table[0] != 0 && table[0] == table[3] && table[3] == table[6]:
		score(table[0])
	if table[1] != 0 && table[1] == table[4] && table[4] == table[7]:
		score(table[1])
	if table[2] != 0 && table[2] == table[5] && table[5] == table[8]:
		score(table[2])
	
	if table[0] != 0 && table[0] == table[4] && table[4] == table[8]:
		score(table[0])
	if table[2] != 0 && table[2] == table[4] && table[4] == table[6]:
		score(table[2])
		
	if not 0 in table and not paused:
		score(0)
		

func score(n):
	paused = true
	
	if n == 1:
		print("score X")
		emit_signal("ended", true)
	if n == 2:
		print("score O")
		emit_signal("ended", false)
	if n == 0:
		print("empate")
		emit_signal("ended", null)
		
	reset_timer.start()

func reset():
	paused = false
	table = [0, 0, 0, 0, 0, 0, 0, 0, 0]
	for i in pos_list:
		i.text = ""


func _on_0_pressed():
	mark(0)


func _on_1_pressed():
	mark(1)


func _on_2_pressed():
	mark(2)


func _on_3_pressed():
	mark(3)


func _on_4_pressed():
	mark(4)


func _on_5_pressed():
	mark(5)


func _on_6_pressed():
	mark(6)

func _on_7_pressed():
	mark(7)


func _on_8_pressed():
	mark(8)


func _on_Timer_timeout():
	reset()
