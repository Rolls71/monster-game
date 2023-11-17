extends Node2D

var sprites
var health_bar

func _ready():
	sprites = get_node("Sprites")
	health_bar = get_node("HealthBar")
	
