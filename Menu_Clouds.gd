extends Node2D

onready var Cloud1 = get_node("Cloud01")
onready var Cloud2 = get_node("Cloud02")
onready var Cloud3 = get_node("Cloud03")
onready var Cloud4 = get_node("Cloud04")

var random = RandomNumberGenerator.new()
var speeds = [0,0,0,0]


func _ready():
	random.randomize()
	speeds[0] = random.randf_range(0.2,0.5)
	random.randomize()
	speeds[1] = random.randf_range(0.2,0.3)
	random.randomize()
	speeds[2] = random.randf_range(0.5,0.7)
	random.randomize()
	speeds[3] = random.randf_range(0.2,0.4)
	
func _physics_process(_delta):

	Cloud1.position.x -= speeds[0]
	Cloud2.position.x -= speeds[1]
	Cloud3.position.x -= speeds[2]
	Cloud4.position.x -= speeds[3]
	if Cloud1.position.x < -525 :
		random.randomize()
		Cloud1.position.x = 1565
		Cloud1.position.y =  random.randf_range(46,100)
	if Cloud2.position.x < -525 :
		random.randomize()
		Cloud2.position.x = 1565
		Cloud2.position.y =  random.randf_range(400,500)
	if Cloud3.position.x < -525 :
		random.randomize()
		Cloud3.position.x = 1565
		Cloud3.position.y =  random.randf_range(300,200)
	if Cloud4.position.x < -525 :
		random.randomize()
		Cloud4.position.x = 1565
		Cloud4.position.y =  random.randf_range(200,100)
