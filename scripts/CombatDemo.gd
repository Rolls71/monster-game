extends Control

var belt_game = preload("res://scenes/belt-game.tscn")
var rhythm_game = preload("res://scenes/rhythm-game.tscn")

var combat_ui
var combat_display
var combat_minigame
var minigame_instance

var selected_friend = -1
var selected_enemy = -1

var score = 0
var score_label 

func _ready():
	combat_ui = get_node("CombatUI")
	combat_display = get_node("CombatDisplay")
	combat_minigame = get_node("CombatMinigame")
	score_label = combat_ui.get_node("Label")

func _on_fight_button_down():
	if selected_enemy == -1:
		return
	match selected_friend:
		-1: 
			return
		0:
			minigame_instance = belt_game.instantiate()
		1:
			minigame_instance = rhythm_game.instantiate()
		_:
			return
	score = 0
	remove_child(combat_ui)	
	minigame_instance.get_node("Minigame").game_ended.connect(_on_minigame_end)
	combat_minigame.add_child(minigame_instance)
			
func _on_minigame_end(_score):
	combat_minigame.remove_child(minigame_instance)
	score += _score
	score_label.text = "Damage dealt: " + str(score)
	add_child(combat_ui)
	var enemy = combat_display.enemies[selected_enemy]
	enemy.health_bar.modify_health(-score)
	if enemy.health_bar.get_health() == 0:
		var enemy_list = combat_ui.get_node("EnemyCharacters")
		enemy_list.set_item_disabled(selected_enemy, true)
		# make function
		enemy_list.deselect_all()
		selected_enemy = -1
		selected_friend = -1
		


func _on_enemy_characters_item_selected(index):
	selected_enemy = index
	
func _on_friend_characters_item_activated(index):
	selected_friend = index
