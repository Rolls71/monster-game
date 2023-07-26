extends Node2D

const DIRECTIONS = ["up", "down", "left", "right"]
var controls = []
var is_key_down = 0
# 0 -> no keys held
# 1 -> this key was pressed, but another key is held
# 2 -> currently being held

func _ready():
	var left = get_node("Left")
	var up = get_node("Up")
	var down = get_node("Down")
	var right = get_node("Right")
	controls = {
		"left":[left, 0], 
		"up": [up, 0],
		"down": [down, 0],
		"right": [right, 0],
		}
	
func _physics_process(delta):
	var flag = false
	for direction in DIRECTIONS:
		if controls[direction][1] == 2:
			flag = true
			break
	if flag:
		is_key_down = true
	else:
		var chord = []
		for direction in DIRECTIONS:
			chord.append(direction)
			controls[direction][1] = 0
			controls[direction][0].scale = Vector2(1, 1)
		is_key_down = false
		#connect signal from game
		#emit_signal("rhythm_input", chord)
			
func _unhandled_key_input(event):
	for direction in DIRECTIONS:
		if event.is_action_pressed(direction):
			controls[direction][0].scale = Vector2(0.75, 0.75)
			controls[direction][1] = 2
		elif event.is_action_released(direction):
			controls[direction][1] = 1
		
		

