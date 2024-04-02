extends KinematicBody2D


var velocity = Vector2(0,0)
var flip = true
var released = true
var jumped = false
var acceleration = 0
var mouse_position
var dash = true
var idle_gun = true
var angleto
var gun_direction
var colliding 
var hit = 0
export var rotation_speed = 2.0
onready var raycast = get_node("down_cast")
onready var player_frames = get_node("player_frames")
onready var gun = get_node("gun")

onready var Enemy_bullet = get_parent().get_node("Enemy_bullet")
onready var global = get_node("/root/Global")


func animation():
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"):
		player_frames.play("run")
	else :
		player_frames.play("still")

func R_L_movement():
	if Input.is_action_pressed("ui_right") :
		if jumped == false:
			velocity.x = 1.5
		released = false
		
	elif Input.is_action_just_released("ui_right"):
		released = true
		
	if Input.is_action_pressed("ui_left") :
		if jumped == false:
			velocity.x = -1.5
		released = false
		
	elif Input.is_action_just_released("ui_left"):
		released = true
		


	if released == true and jumped == false :
		velocity.x *= 0.9

	self.position.x += velocity.x
		
func U_D_movement():
	
	if jumped == false:
		if Input.is_action_just_pressed("ui_up") :
			jumped = true
			acceleration = -5
		elif raycast.is_colliding() == false:
			jumped = true
	if not colliding  and jumped == true :
		acceleration += 0.2
	elif colliding and jumped == true :
		acceleration = 0
		jumped = false
		
	velocity.y = acceleration
	self.position.y += velocity.y 
	
func Rotate(object,Mouse_position):
	gun_direction = (Mouse_position-self.position).normalized()
	angleto = object.transform.x.angle_to(gun_direction)
	if player_frames.flip_h == false:
		object.flip_v = false
		object.position.x = 6
		if gun_direction >= Vector2.ZERO:
			object.rotate(angleto)
		elif gun_direction <= Vector2.ZERO:
			player_frames.flip_h = true

	elif player_frames.flip_h == true:
		object.flip_v = true
		object.position.x = -6
		if gun_direction <= Vector2.ZERO:
			object.rotate(angleto)
		elif gun_direction > Vector2.ZERO:
			player_frames.flip_h = false
			
func Gun_animation():

	if idle_gun == false :
		if player_frames.flip_h == false:
			velocity.x -= 0.015 
		elif player_frames.flip_h == true:
			velocity.x += 0.015 
		
func _physics_process(_delta):
	global.player_position = self.position
	$gun.play("idle")
	colliding = move_and_collide(Vector2.ZERO)
	mouse_position = get_global_mouse_position()
	if global.player_hit - hit == 1 and  global.player_hit % 1 == 0:
			hit += 1
			$player_frames/AnimationPlayer.play("flash")
	if global.player_hit >= 6 or self.position.y >= 600:
		self.position = Vector2(-199,104)
		global.player_hit = 0
		global.player_dcount += 1
		hit = 0
	animation()
	R_L_movement()
	Rotate(gun,mouse_position)
	if Input.is_action_pressed("right_mouse"):
		self.position -= gun_direction/2
	U_D_movement()


func _on_Timer_timeout():
	dash = false
