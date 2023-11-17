extends Control

const MAX_TIME = 15
const MIN_TIME = 0

var minigame
var minigame_type

var time_bar
var score_text
	
func _ready():
	minigame = get_node("Minigame")
	if minigame.get_meta("type") == "minigame":
		minigame_type = minigame.get_meta("minigame-type")
	
	time_bar = get_node("TimeBar")
	time_bar.max_value = MAX_TIME
	time_bar.min_value = MIN_TIME
	time_bar.value = MAX_TIME
	
	score_text = get_node("ScoreText")
	score_text.text = "Score: 0"
	
	
	
func _physics_process(delta):
	if minigame.is_game_over:
		score_text.text = "Score: "+str(minigame.get_score())
	elif time_bar.value <= MIN_TIME:
		time_bar.value = MIN_TIME
		score_text.text = "Score: "+str(minigame.end_game(false))	
	else:
		time_bar.value -= delta
		score_text.text = "Score: "+str(minigame.get_score())
	


