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

var is_game_over = false
var is_crit = false
var score = 0

var up = preload("res://scenes/sprites/up.tscn")
var right = preload("res://scenes/sprites/right.tscn")
var down = preload("res://scenes/sprites/down.tscn")
var left = preload("res://scenes/sprites/left.tscn")

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
	return score

func send_chord(chord):
	pass
	

func _ready():
	set_meta("type", "minigame")
	set_meta("minigame-type", "rhythm")
	add_user_signal("new_chord", )
	for i in randi_range(MIN_QUEUE, MAX_QUEUE):
		var rand_int = randi()%chords.size()
		var chord = Node2D.new()
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

func _step():
	target_position += Vector2.LEFT * STEP_SIZE
	var instance = queue.pop_front()
	instance.queue_free()
	score += 1
