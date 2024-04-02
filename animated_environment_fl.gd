extends Node2D

#child_nodes

onready var clb1 = get_node("coin_frames")
onready var clb2 = get_node("coin_frames2")
onready var clb3 = get_node("key_frames")
onready var player = get_parent().get_node("Player")
onready var Timtal = get_node("statue")
onready var canvas = get_parent().get_node("CanvasModulate")
onready var  Ui_node = get_parent().get_node("ui_node")
onready var Elivator =  get_node("elivator")
var storing_position = [Vector2(15,15),Vector2(55,15),Vector2(95,20)]
var final_position = [Vector2(849,87),Vector2(907,87),Vector2(879,47)]
var T = [0.05,0.05,0.05]
var collected 
var allowed =  false
var won = false
var entered = false
var menu = false
var green= 1
var red = 1
var blue = 1
var color = Color(red,green,blue,1)
var Elivator_velocity = 0.5
var pick_ups

func _ready():
	pick_ups = [clb1,clb2]
	collected = {"clb1":false,"clb2":false,"clb3":false}
func interpolation1(current_position,next_position,time):
	if time >= 0 and time <= 1 :
		time += 0.002
	current_position = current_position*(1-(time)) + next_position*time
	return current_position
	
func area_entered(Pick_ups):
	for item in Pick_ups:
		if sqrt(pow((item.position.x-player.position.x),2) + pow((item.position.y-player.position.y),2)) < 11:
			if collected["clb1"] == false or collected["clb2"] == false :
				$collect.play()
			if item == clb1:
				collected["clb1"] = true
			elif item == clb2:
				collected["clb2"] = true
		
		if collected["clb1"] == true and collected["clb2"] == true :
			if sqrt(pow((clb3.position.x-player.position.x),2) + pow((clb3.position.y-player.position.y),2)) < 11:
				if collected["clb3"] == false:
					$collect.play()
				collected["clb3"] = true
				allowed = true
	return collected
func _physics_process(delta):
	if Elivator.position.x == 439 :
		Elivator_velocity = 0.5
	elif Elivator.position.x == 590 :
		Elivator_velocity = -0.5
	Elivator.position.x +=  Elivator_velocity
	if allowed == false:
		collected = area_entered(pick_ups)
	if entered == false:
		if collected["clb1"] == true :
			clb1.position = lerp(clb1.position,storing_position[0],delta*0.6)
		if collected["clb2"] == true :
			clb2.position = lerp(clb2.position,storing_position[1],delta*0.5)
		if collected["clb3"] == true :
			clb3.position = lerp(clb3.position,storing_position[2],delta*0.5)
	if allowed == true :
		if sqrt(pow((Timtal.position.x-player.position.x),2) + pow((Timtal.position.y-player.position.y),2)) < 35:
			entered =  true
	if entered == true :
		clb1.position = interpolation1(clb1.position,final_position[0],T[0])
		clb2.position = interpolation1(clb2.position,final_position[1],T[1])
		clb3.position = interpolation1(clb3.position,final_position[2],T[2])
		if won == false:
			Timtal.play("statue1")
			if Timtal.frame == 15 :
				won = true
	if won == true:
		Timtal.animation = "idle statue"
		if Timtal.frame == 1 :
				menu = true
		if menu == true :
			if red > 0.1:
				red -= 0.02
				blue -= 0.02
				green -= 0.02
			color = Color(red,blue,green,1)
			canvas.color = color
			Ui_node.visible = true

			
	
		


