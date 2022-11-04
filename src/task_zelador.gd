extends Node2D

onready var grupo_lixo = $grupo_lixo
onready var player = get_node("../YSort/Player")
onready var tempo = $Timer
onready var texto = $CanvasLayer/Label
var random = RandomNumberGenerator.new()
var pos_padrao_1 = [
	[-102,-323],
	[351,-398],
	[494,-138],
	[-96,187],
	[-383,31]
]

func _ready():
	maker_lixos()
	tempo.start()
	
func maker_lixos():
	
	for i in pos_padrao_1:
		random.randomize()
		var lixo_obj = load("res://lixo.tscn").instance()
		
		lixo_obj.position.x = i[0]
		lixo_obj.position.y = i[1]
		
		grupo_lixo.add_child(lixo_obj)

func monitorar_bola():
	
	for r in grupo_lixo.get_children():
		
		if len(r.hitbox_lixo.get_overlapping_areas()) > 0:
			r.queue_free()
			player.cont_lixo += 1

func update_clock():
	
	if int(tempo.get_time_left()) == 10:
		texto.modulate = Color(1,0,0,1)
		
	texto.text = str(int(tempo.get_time_left()))

func _physics_process(delta):
	monitorar_bola()
	update_clock()
