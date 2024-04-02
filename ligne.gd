extends Node2D

export var thikness = 2.0
export var max_length = 200

var points = []
var frame = 0
#push_front
#pop_back
func _physics_process(_delta):
	if frame % 1 == 0:
		points.push_front(get_parent().global_position)
		if points.size() >= max_length :
			points.pop_back()
	frame += 1
	update()

func _draw():
	if points.size() < 2 :
		return
	var antialias = false
	var c = modulate
	var s = float(points.size())
	var adjusted = PoolVector2Array()
	var colors = PoolColorArray()

	for i in range(s):
		adjusted.append(points[i]-get_parent().global_position-Vector2(0,0))
		c.a = lerp(1.0,0.0,i/s)
		colors.append(c)
	
#	draw_set_transform(Vector2(0,0),-get_parent().rotation,Vector2(1,1))
	draw_polyline_colors(adjusted,colors,thikness,antialias)
