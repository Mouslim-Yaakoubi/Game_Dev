extends Node2D

onready var parent = get_parent()

var i = 7
var timeout = true
var health_nodes = ["Sprite","Sprite2","Sprite3","Sprite4","Sprite5","Sprite6","Sprite7","Sprite8"]
onready var timer = get_node("Timer")

func create_bullets():
	pass

func readjust_health():
	if Input.is_action_pressed("right_mouse") :
		if timeout == true:
			if i >= 0:
				get_node(health_nodes[i]).play("poof")
				if get_node(health_nodes[i]).frame == 7 :
					get_node(health_nodes[i]).queue_free()
					i -= 1
					timeout == false
					timer.start()
		
func _physics_process(_delta):
	readjust_health()
	


func _on_Timer_timeout():
	timeout = true


