extends Node2D

var grid = [
	2,2,2,2,2,2,2,2,2,2,2,
	2,2,2,2,2,0,0,0,0,2,2,
	2,2,2,2,0,0,0,0,0,0,2,
	2,2,0,0,0,0,0,0,0,0,2,
	2,0,0,0,0,0,2,2,2,0,2,
	2,0,0,0,0,0,0,0,2,0,2,
	2,0,0,0,0,0,2,0,2,0,2,
	2,2,0,0,0,0,2,0,2,0,2,
	2,2,0,0,0,0,2,0,2,0,2,
	2,2,2,0,0,0,2,0,2,0,2,
	2,0,0,0,0,0,0,0,2,0,2,
	2,0,2,0,0,0,0,0,2,0,2,
	2,0,0,0,0,0,2,2,2,0,2,
	2,2,2,2,2,2,2,2,2,2,2,
]

var width = 11
var height = 14

func set_grid(new_grid, width, height):
	grid = new_grid
