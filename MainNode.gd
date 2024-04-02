extends Node2D
onready var mouse = get_node("Mouse")
onready var global = get_node("/root/Global")

func _remove():
	$ColorRect3.queue_free()
func _physics_process(delta):

	var mouse_position = get_global_mouse_position()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	mouse.global_position = lerp(mouse_position,mouse.global_position,delta*60*0.2)
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	elif Input.is_action_just_pressed("right_mouse"):
		mouse.get_node("AnimationPlayer").play("New Anim")
	
	if abs($Player.position.x - $guide.position.x) <= 14:
		$Press_E.visible = true
		$Press_E/AnimationPlayer.play("press_E")
	elif  abs($Player.position.x - $guide.position.x) > 14:
		$Press_E.visible = false

	if abs($Player.position.x - $guide.position.x) <= 14 and Input.is_action_just_pressed("ui_r") :
		get_tree().change_scene("res://scenes/dialogue.tscn")
		$guide.queue_free()
