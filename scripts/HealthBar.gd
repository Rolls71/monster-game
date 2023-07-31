extends Node2D

const DEFAULT_MAX_HEALTH = 100

var bar

func get_health():
	return bar.value
	
func modify_health(health_change):
	var new_health = bar.value + health_change
	if new_health >= bar.min_value and new_health <= bar.max_value:
		bar.value = new_health
	elif new_health < bar.min_value:
		bar.value = bar.min_value
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

