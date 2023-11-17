extends Node2D

var sprites = []
var current_sprite

func set_sprite(sprite_id):
	if typeof(sprite_id) == TYPE_INT:
		remove_child(current_sprite)
		add_child(sprites[sprite_id])
		current_sprite = sprites[sprite_id]
	elif typeof(sprite_id) == TYPE_STRING:
		for sprite in sprites:
			if sprite.name == sprite_id:
						remove_child(current_sprite)
						add_child(sprite)
						current_sprite = sprite

func get_sprite():
	return current_sprite

func _ready():
	for node in get_children():
		sprites.append(node)
		remove_child(node)
	add_child(sprites[0])
	current_sprite = sprites[0]
	

