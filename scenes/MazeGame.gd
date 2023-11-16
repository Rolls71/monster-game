extends Node2D

var slime_cell = Vector2i(0,0)
var wall_cell = Vector2i(1,0)
var floor_cell = Vector2i(2,0)

var maze: TileMap
var player: CharacterBody2D

var move_step = 2
var cell_size = 16
var cell_dist = 0

var is_travelling = false
var is_stopping = false
var cur_direction = "right"
var directions = {
	"right": Vector2i(1,0),
	"down": Vector2i(0,1),
	"left": Vector2i(-1,0),
	"up": Vector2i(0,-1),
}

func _ready():
	maze = get_child(0)
	player = get_child(1)
	
	print(maze.get_cell_atlas_coords(0, maze.local_to_map(player.position)))
	
func _physics_process(delta):
	if  int(player.position.x) % cell_size == 0 && int(player.position.y) % cell_size == 0:
		var cur_pos = maze.local_to_map(player.position)
		var cur_cell = maze.get_cell_atlas_coords(0, cur_pos)
		if cur_cell != slime_cell:
			maze.set_cell(0, cur_pos, 2, slime_cell)
		
		var dir = directions[cur_direction]
		var next_pos = cur_pos + dir
		var next_cell = maze.get_cell_atlas_coords(0, next_pos)
		if next_cell == wall_cell:
			is_travelling = false
			return
	var dir = directions[cur_direction]
	player.position += Vector2(dir.x, dir.y)*move_step

		
	
	
	
	
	
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
