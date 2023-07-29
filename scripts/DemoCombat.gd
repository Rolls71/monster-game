extends Control

var belt_game = preload("res://scenes/belt-game.tscn")
var rhythm_game = preload("res://scenes/rhythm-game.tscn")

var combat_ui
var minigame

var selected_player = 0
var selected_enemy = 0

func _ready():
	combat_ui = get_node("CombatUI")

func _on_player_characters_item_activated(index):
	selected_player = index

func _on_fight_button_down():
	remove_child(combat_ui)
	match selected_player:
		0:
			minigame = belt_game.instantiate()
		_:
			minigame = rhythm_game.instantiate()
	add_child(minigame)
			
