extends Node2D


onready var Animated = get_node("AnimatedSprite")
onready var Poof = get_node("Poof")
onready var boom = get_node("Boom")
onready var node2d = get_node("Node2D")
onready var global = get_node("/root/Global")
var entered = false
var Direction = Vector2.ZERO
var speed = 600
var Poof_speed = 50
var poof = false
var Boom = true
var boom_direction = Vector2.ZERO
var boom_speed = 100
var Poof_direction = Vector2.ZERO
var timeout = false
var color = Color(1,1,1,1)
var collide_to
var collision_list = []
var names 


func _ready():
	Animated.get_node("Timer").start()


	
func _physics_process(delta):
	
	if entered == false and poof == false :
		Animated.modulate = color
		$Light2D.global_position = Animated.position
		node2d.global_position = Animated.position
		Animated.play("default_bullet")
		Animated.position += Direction*speed*delta
		$Light2D.position += Direction*speed*delta
		Poof_direction = Direction
		boom_direction = Direction
		
	if entered == true or timeout == true:
		Poof.modulate = color
		Poof.global_position = Animated.position
		$Light2D.queue_free()
		node2d.queue_free()
		Animated.queue_free()
		poof = true
		entered = false
		timeout = false
		
	if Boom == true :
		boom.modulate = color
		boom.position += boom_direction*boom_speed*delta
		boom.visible = true
		boom.play("default")
		if boom.frame == 8:
			Boom = false
			boom.queue_free()
		
	if poof == true :
		Poof.visible = true
		Poof.play("default")
		Poof.position += Poof_direction*Poof_speed*delta
		if Poof.frame == 7:
			Poof.queue_free()
			get_parent().queue_free()
			

func _on_Timer_timeout():
	timeout = true





func _on_Area2D2_body_entered(body):
	entered = true
	global.player_bullet_direction = Direction
	if body.name == "Enemy":
		global.enemy_hit += 1
		global.enemy_damage = true
	elif body.name == "sword_enemy":
		global.sword_enemy_hit += 1
		global.sword_enemy_damage = true
	elif body.name == "swinger":
		global.swinger_hit += 1
		global.swinger_damage = true
	
	
		
	




func _on_Area2D_area_entered(area):
	if area.name == "Area2D":
		global.settings_hit == true
		entered = true
