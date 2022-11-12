extends StaticBody2D

var open = false
onready var left = $ColLeft
onready var right = $ColRight
onready var door = $ColDoor
onready var area = $Area2D
onready var sprite =$Sprite
onready var som = $somPorta
onready var professora = get_node("../../Professora")
onready var som_fechar = $somPortaFechar

func _process(delta):
	if len(area.get_overlapping_areas()) > 0:
		if !open:
			som.play()
		open = true
		sprite.frame = 1
		door.set_deferred("disabled", true)
	else:
		if open:
			som_fechar.play()
		open = false
		sprite.frame = 0
		door.set_deferred("disabled", false)


func _on_Area2D_body_entered(body):
	if body.is_in_group("player") and professora.porta_interacao:
		professora.interact()
