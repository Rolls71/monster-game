extends Node2D

const DEFAULT_MAX_HEALTH = 100

var bar

func get_health():
	return bar.value
	
func modify_health(health_change):
	var new_health = bar.value + health_change
	if new_health >= 0 and new_health <= bar.max_value:
		bar.value = health_change
	elif new_health < 0:
		bar.value = 0
	else:
		bar.value = bar.max_value
		
	
func set_health(health):
	if health <= bar.max_value:
		bar.value = health
		return true
	else:
		return false



func _ready():
	bar = get_node("ProgressBar")
	bar.min_value = 0
	bar.max_value = DEFAULT_MAX_HEALTH
	bar.value = DEFAULT_MAX_HEALTH

