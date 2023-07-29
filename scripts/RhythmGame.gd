extends Node2D

const STEP_SIZE = 100
const GAP_STEPS = 2
const LERP_RATE = 7

const MIN_QUEUE = 10
const MAX_QUEUE = 20

const CRIT_MULTIPLIER = 1.2

const ARROW_GAP = 50
const ARROW_ROWS = {
	"left": -ARROW_GAP*1.5,
	"up": -ARROW_GAP*0.5,
	"down": ARROW_GAP*0.5,
	"right": ARROW_GAP*1.5,
}

signal game_ended

var is_game_over = false
var is_crit = false
var score = 0

var up = preload("res://scenes/sprites/up.tscn")
var right = preload("res://scenes/sprites/right.tscn")
var down = preload("res://scenes/sprites/down.tscn")
var left = preload("res://scenes/sprites/left.tscn")

var controls

var arrows = [up, right, down, left]
var chords = [
	[up],
	[down],
	[left],
	[right],
	[up, left],
	[up, right],
	[down, left],
	[down, right],
	[left, right],
	#[up, left, right],
	#[down, left, right],
	# my keyboard doesn't register three arrow keys at once
]
var queue = []

var target_position = position

func get_score():
	return score
	
func end_game(is_win):
	is_game_over = true
	if is_win:
		is_crit = true
		score *= CRIT_MULTIPLIER
	score = int(score)
	game_ended.emit(score)
	return score	

func _on_rhythm_input(input_chord):
	var queue_chord = queue.front().get_meta("chord")
	if len(queue_chord) != len(input_chord):
		score -= len(input_chord)
		print("length doesnt match")
		return
	for i in range(len(queue_chord)):
		if queue_chord[i].get_meta("arrow_type") != input_chord[i]:
			return
	
	if len(queue) == 0:
		end_game(true)
	_step(len(input_chord))
	if len(queue) == 0:	
		end_game(true)

func _ready():
	set_meta("type", "minigame")
	set_meta("minigame-type", "rhythm")
	
	up.set_meta("arrow_type", "up")
	down.set_meta("arrow_type", "down")
	left.set_meta("arrow_type", "left")
	right.set_meta("arrow_type", "right")
	
	controls = get_parent().get_node("Controls")
	controls.rhythm_input.connect(_on_rhythm_input)
	
	for i in randi_range(MIN_QUEUE, MAX_QUEUE):
		var rand_int = randi()%chords.size()
		var chord = Node2D.new()
		chord.set_meta("chord", chords[rand_int]) 
		for scene in chords[rand_int]:
			var child = scene.instantiate()
			child.position = Vector2(0, ARROW_ROWS[child.name.to_lower()])
			chord.add_child(child)
		queue.append(chord)
		add_child(chord)
		chord.position = Vector2(
			STEP_SIZE*(i+GAP_STEPS),
			get_viewport_rect().size.y/2)

func _process(delta):
	if !is_game_over && queue.size() == 0:
		end_game(true)
	position = lerp(position, target_position, LERP_RATE*delta)
	return

func _step(points):
	target_position += Vector2.LEFT * STEP_SIZE
	var instance = queue.pop_front()
	instance.queue_free()
	score += points
