extends Node2D

const STEP_SIZE = 100
const GAP_STEPS = 2
const LERP_RATE = 7

const MIN_QUEUE = 10
const MAX_QUEUE = 20

const CRIT_MULTIPLIER = 1.2

var is_game_over = false
var is_crit = false
var score = 0

var up = preload("res://scenes/sprites/up.tscn")
var right = preload("res://scenes/sprites/right.tscn")
var down = preload("res://scenes/sprites/down.tscn")
var left = preload("res://scenes/sprites/left.tscn")
var arrows = [up, down, left, right]
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


func _ready():
	set_meta("type", "minigame")
	set_meta("minigame-type", "rhythm")


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
