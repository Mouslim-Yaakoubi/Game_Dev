
extends Camera2D

export var decay = 0.8  # How quickly the shaking stops [0, 1].
export var max_offset = Vector2(100, 75)  # Maximum hor/ver shake in pixels.
export var max_roll = 0.1  # Maximum rotation in radians (use sparingly).
export (NodePath) var target  # Assign the node this camera will follow.
onready var  global = get_node("/root/Global")
var trauma = 0.0  # Current shake strength.
var trauma_power = 2  # Trauma exponent. Use [2, 3].
onready var player = get_parent().get_node("Player")
onready var settings = get_parent().get_node("Settings")
func _ready():
	randomize()

func add_trauma(amount):
	trauma = min(trauma + amount, 1.0)
	
func shake():
	var amount = pow(trauma, trauma_power)
	rotation = max_roll * amount * rand_range(-1, 1)
	offset.x = max_offset.x * amount * rand_range(-1, 1)
	offset.y = max_offset.y * amount * rand_range(-1, 1)
func move(delta):
	if player.position.x <= 216:
		
		settings.position.x = -340
		self.position.x = lerp(self.position.x,-360,delta*0.2*20)
		
	elif player.position.x > 835:
		
		settings.position.x = 610
		self.position.x = lerp(self.position.x,600,delta*0.2*20)
		
	elif player.position.x > 216 and player.position.x < 835:
		
		settings.position.x = 0
		self.position.x = lerp(self.position.x,0,delta*0.2*20)
	
func _process(delta):
	move(delta)
	if Input.is_action_just_pressed("right_mouse"):
		trauma = 0.2
	if trauma and global.player_died == false:
		trauma = max(trauma - decay * delta, 0)
		shake()
