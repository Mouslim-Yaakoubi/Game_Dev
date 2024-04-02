extends Node

onready var Cloud1 = get_node("Cloud01")
onready var Cloud2 = get_node("Cloud02")


var random = RandomNumberGenerator.new()
var speeds = [0,0]


func _ready():
	random.randomize()
	speeds[0] = random.randf_range(0.2,0.5)
	random.randomize()
	speeds[1] = random.randf_range(0.5,0.7)

	
func _process(_delta):

	Cloud1.position.x -= speeds[0]
	Cloud2.position.x -= speeds[1]

	if Cloud1.position.x < -133/2 :
		random.randomize()
		Cloud1.position.x = 1080 + 133/2
		Cloud1.position.y =  random.randf_range(46,100)
	if Cloud2.position.x < -133/2 :
		random.randomize()
		Cloud2.position.x = 1080 + 133/2
		Cloud2.position.y =  random.randf_range(400,500)
	
