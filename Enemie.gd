extends KinematicBody2D

onready var enemie_sprite = get_node("enemie_frames")
onready var player = get_parent().get_node("Player")
onready var bullet = get_parent().get_node("Player_bullet")
onready var detector = get_node("detector")
onready var player_detector = get_node("Player_detector")

onready var player_bullet = get_parent().get_node("Player_bullet")
onready var global = get_node("/root/Global")

var next_position 
var potential_position
var collide = false
var timers = []
var wait_time = [4,2,1,0.05]
var collider
var jumped = false
var acceleration = 0
var detected = false
var limits = [216,850]
var n = 0
var hit = 0 
var hit_animation = false
func _ready():
	timer_init(wait_time)
	
func flip(other_position):
	if self.position.x < other_position :
		enemie_sprite.flip_h = false
	elif self.position.x > other_position :
		enemie_sprite.flip_h = true

func timer_init(wait_timing):
	for u in range(4):
		var timer = Timer.new()
		timer.wait_time = wait_timing[u-1]
		timer.one_shot = true
		add_child(timer)
		if u == 0 or u==1:
			timer.start()
		timers.append(timer)
		

		
func reaction_behaviour(timer_0):
	if timer_0.time_left <= 0.02 :
		randomize()
		enemie_sprite.play("Idle")
		global.action = ["chase","chase","run"][randi() % len(["chase","chase","run"])]
		timer_0.start()
		collide = false

	if self.position.x < limits[0] :
		self.position.x += 1.5
		enemie_sprite.flip_h = false
		global.action = "still"
		enemie_sprite.play("Idle")
		
	elif self.position.x > limits[1]:
		self.position.x -= 1.5
		enemie_sprite.flip_h = true
		global.action = "still"
		enemie_sprite.play("Idle")
		
	else:
		self.position += global.enemy_pushback*4
		if global.player_died == false:
			if player_detector.is_colliding():
				collider = player_detector.get_collider()
			if collider == player:
				timers[2].start()
			if timers[2].time_left >= 0.2:
				global.action = "shoot"
				detected = true
		if global.action == "run":
			enemie_sprite.play("run")
			if self.position.x - global.player_position.x > 0 :
				enemie_sprite.flip_h = false
				self.position.x += 1.5
			elif self.position.x - global.player_position.x < 0:
				enemie_sprite.flip_h = true
				self.position.x -= 1.5
				
		elif global.action == "chase":
			timer_0.wait_time = wait_time[0]
			enemie_sprite.play("run")
			if self.position.x - global.player_position.x > 0 :
				enemie_sprite.flip_h = true
				self.position.x -= 1.5
			elif self.position.x - global.player_position.x < 0:
				enemie_sprite.flip_h = false
				self.position.x += 1.5
			
		elif global.action == "shoot":
			
			timer_0.wait_time = wait_time[1]
			enemie_sprite.play("shoot")
			if self.position.x - global.player_position.x > 0 :
				enemie_sprite.flip_h = true
			elif self.position.x - global.player_position.x < 0:
				enemie_sprite.flip_h = false
		elif global.action == "still":
			timer_0.wait_time = wait_time[0]

			
func _physics_process(_delta):
	collide = move_and_collide(Vector2.ZERO)
	player_detector.global_rotation_degrees += 15
	if global.enemy_hit - hit == 1 and  global.enemy_hit % 1 == 0:
		self.position.x += global.player_bullet_direction.x*5
		hit += 1
		$enemie_frames/AnimationPlayer.play("flash")
	if global.enemy_hit == 10:
		enemie_sprite.play("death")
		global.enemy_died = true
		global.enemy_dp = self.position
		global.action = "still"
		if n == 0:
			$CollisionShape2D.queue_free()
			n += 1
	elif global.enemy_hit < 16:
		reaction_behaviour(timers[0])
	if global.player_died == true:
		enemie_sprite.play("Idle")




