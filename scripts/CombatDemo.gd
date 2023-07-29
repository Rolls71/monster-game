extends Control

var belt_game = preload("res://scenes/belt-game.tscn")
var rhythm_game = preload("res://scenes/rhythm-game.tscn")

var combat_ui
var minigame_instance

var selected_player = 0
var selected_enemy = 0

var score = 0
var score_label 

func _ready():
	combat_ui = get_node("CombatUI")
	score_label = combat_ui.get_node("Label")

func _on_player_characters_item_activated(index):
	selected_player = index

func _on_fight_button_down():
	remove_child(combat_ui)
	match selected_player:
		0:
			minigame_instance = belt_game.instantiate()
		_:
			minigame_instance = rhythm_game.instantiate()
	minigame_instance.get_node("Minigame").game_ended.connect(_on_minigame_end)
	add_child(minigame_instance)
			
func _on_minigame_end(_score):
	remove_child(minigame_instance)
	score += _score
	score_label.text = "Score: " + str(score)
	add_child(combat_ui)
