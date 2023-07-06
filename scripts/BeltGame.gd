extends Node2D

const STEP_SIZE = 100
const GAP_STEPS = 2
const LERP_RATE = 7

const MIN_QUEUE = 30
const MAX_QUEUE = 60

var is_game_over = false

var dash = preload("res://scenes/belt-game/dash.tscn")
var heart = preload("res://scenes/belt-game/right.tscn")
var sword = preload("res://scenes/belt-game/left.tscn")
var scenes = [dash, heart, sword]
var queue = []

var target_position = position

func _ready():
	
	for i in randi_range(MIN_QUEUE, MAX_QUEUE):
		var rand_int = randi()%scenes.size()
		var instance = scenes[rand_int].instantiate()
		queue.append(instance)
		add_child(instance)
		instance.position = Vector2(STEP_SIZE*(i+GAP_STEPS), get_viewport_rect().size.y/2)
		match rand_int:
			0:
				instance.set_meta("type", "dash")
			1:
				instance.set_meta("type", "right")
			2:
				instance.set_meta("type", "left")

func _process(delta):
	position = lerp(position, target_position, LERP_RATE*delta)

func _unhandled_key_input(event):	
	if is_game_over:
		return
	
	if !event.is_action_pressed("left") && !event.is_action_pressed("right"):
		return
		
	if queue.size() == 0:
		is_game_over = true
		return
	
	match queue.front().get_meta("type"):
		"right": 
			if !event.is_action_pressed("right"):
				is_game_over = true
				return
		"left":
			if !event.is_action_pressed("left"):
				is_game_over = true
				return
	_step()
	
func _step():
	target_position += Vector2.LEFT * STEP_SIZE
	var instance = queue.pop_front()
	instance.queue_free()

