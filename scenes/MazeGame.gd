extends Node2D

var slime_cell = Vector2i(0,0)
var wall_cell = Vector2i(1,0)
var floor_cell = Vector2i(2,0)

var maze: TileMap
var player: CharacterBody2D

var is_travelling = false
var cur_direction = "right"

func _ready():
	maze = get_child(0)
	player = get_child(1)
	
	print(maze.get_cell_atlas_coords(0, maze.local_to_map(player.position)))
	
func _physics_process(delta):
	if !is_travelling:
		return
	
	var cur_pos = maze.local_to_map(player.position)
	var cur_cell = maze.get_cell_atlas_coords(0, cur_pos)
	if cur_cell != slime_cell:
		maze.set_cell(0, cur_pos, 2, slime_cell)
	
func _unhandled_key_input(event):
	if is_travelling:
		return
	if event.is_action_pressed("right"):
		cur_direction = "right"
	elif event.is_action_pressed("down"):
		cur_direction = "down"
	elif event.is_action_pressed("left"):
		cur_direction = "left"
	elif event.is_action_pressed("up"):
		cur_direction = "up"
	else:
		return
	is_travelling = true
	print(cur_direction)
